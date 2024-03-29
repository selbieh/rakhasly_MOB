// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakshly/core/models/previous_car_requests.dart';

import 'package:rakshly/core/services/http_service.dart';
import 'package:rakshly/features/license/widgets/tab_card.dart';

class PreviousRequest extends GetView<PreviousRequestController> {
  const PreviousRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreviousRequestController(context: context));

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: controller.tabController,
          tabs: const [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.credit_card)),
          ],
        ),
        title: Text('My requests'.tr),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          CarLicenseTab(controller),
          DrivingLicenseTab(controller: controller),
        ],
      ),
    );
  }
}

class PreviousRequestController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final bike = ''.obs;
  var isBusy = false.obs;
  var isError = false.obs;
  var isLoadingMore = false.obs;
  final api = Get.find<HttpService>();
  final BuildContext context;
  PreviousRequestController({required this.context});

  final Map<int, PreviosDrivingLicenseRequest?> cachedResults = {};

  Rx<PreviosDrivingLicenseRequest> prevRequest =
      PreviosDrivingLicenseRequest().obs;

  @override
  void onInit() async {
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(() async {
      // await getPreviosLicensesRequest(tabController.index);
      final int currentIndex = tabController.index;

      // Check if the result is already cached
      if (!cachedResults.containsKey(currentIndex)) {
        // If not cached, make the request and store the result in the cache
        final result = await getPreviosLicensesRequest();
        cachedResults[currentIndex] = result.value;
      }
      prevRequest.value = cachedResults[currentIndex]!;
    });
    super.onInit();
    cachedResults[tabController.index] =
        (await getPreviosLicensesRequest()).value;
  }

  getPreviosLicensesRequest({offset = 0, loadingMore = false}) async {
    isError.value = false;
    if (loadingMore) {
      isBusy.value = true;
    } else {
      isLoadingMore.value = true;
    }
    final res = tabController.index == 0
        ? await api.getPreviosCarLicensesRequest(offset: offset)
        : await api.getPreviosDrivingLicensesRequest(offset: offset);
    if (res.statusCode == 200) {
      prevRequest.value = PreviosDrivingLicenseRequest.fromJson(res.body);
      if (loadingMore) {
        isBusy.value = false;
      } else {
        isLoadingMore.value = false;
      }
      return prevRequest;
    } else {
      if (loadingMore) {
        isBusy.value = false;
      } else {
        isLoadingMore.value = false;
      }
      isError.value = true;
      AwesomeDialog(
              context: Get.context!,
              dialogType: DialogType.error,
              animType: AnimType.bottomSlide,
              desc: res.bodyString,
              descTextStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
          .show();
    }
  }
}

class CarLicenseTab extends StatefulWidget {
  final PreviousRequestController controller;
  const CarLicenseTab(this.controller, {super.key});

  @override
  _CarLicenseTabState createState() => _CarLicenseTabState();
}

class _CarLicenseTabState extends State<CarLicenseTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Obx(() => widget.controller.isBusy.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : widget.controller.isError.value
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("error".tr),
                      MaterialButton(
                        onPressed: () async {
                          await widget.controller.getPreviosLicensesRequest();
                        },
                        child: Text("Retry".tr),
                      )
                    ],
                  ),
                )
              : EasyRefresh(
                  onRefresh: () async {
                    await widget.controller.getPreviosLicensesRequest();
                  },
                  onLoad: () async {
                    if (widget.controller.prevRequest.value.next != null) {
                      var nextLink =
                          widget.controller.prevRequest.value.next as String;
                      var offsetAndLimit = nextLink.split("?")[1].split("&");
                      Map<String, String> queryParams = {};

                      for (String param in offsetAndLimit) {
                        List<String> keyValue = param.split("=");
                        if (keyValue.length == 2) {
                          queryParams[keyValue[0]] = keyValue[1];
                        }
                      }
                      debugPrint(queryParams.toString());
                      await widget.controller.getPreviosLicensesRequest(
                          offset: int.parse(queryParams['offset'] ?? "0") + 10);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(
                              widget.controller.prevRequest.value.results
                                      ?.length ??
                                  0,
                              (index) => TabItem(
                                item: widget.controller.prevRequest.value
                                    .results![index],
                                controller: widget.controller,
                                ctx: context,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        widget.controller.isLoadingMore.value
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CarLicenseTabController extends GetxController {
  final car = ''.obs;

  @override
  void onInit() {
    car.value = 'Ferrari';
    super.onInit();
  }
}

class DrivingLicenseTab extends StatefulWidget {
  final PreviousRequestController controller;
  const DrivingLicenseTab({required this.controller, super.key});

  @override
  _DrivingLicenseState createState() => _DrivingLicenseState();
}

class _DrivingLicenseState extends State<DrivingLicenseTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Obx(() => widget.controller.isBusy.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : widget.controller.isError.value
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("error".tr),
                      MaterialButton(
                        onPressed: () async {
                          await widget.controller.getPreviosLicensesRequest();
                        },
                        child: Text("Retry".tr),
                      )
                    ],
                  ),
                )
              : EasyRefresh(
                  onRefresh: () async {
                    await widget.controller.getPreviosLicensesRequest();
                  },
                  onLoad: () async {
                    if (widget.controller.prevRequest.value.next != null) {
                      var nextLink =
                          widget.controller.prevRequest.value.next as String;
                      var offsetAndLimit = nextLink.split("?")[1].split("&");
                      Map<String, String> queryParams = {};

                      for (String param in offsetAndLimit) {
                        List<String> keyValue = param.split("=");
                        if (keyValue.length == 2) {
                          queryParams[keyValue[0]] = keyValue[1];
                        }
                      }
                      debugPrint(queryParams.toString());
                      await widget.controller.getPreviosLicensesRequest(
                          offset: int.parse(queryParams['offset'] ?? "0") + 10);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(
                              widget.controller.prevRequest.value.results
                                      ?.length ??
                                  0,
                              (index) => TabItem(
                                item: widget.controller.prevRequest.value
                                    .results![index],
                                controller: widget.controller,
                                ctx: context,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        widget.controller.isLoadingMore.value
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
