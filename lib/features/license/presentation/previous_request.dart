// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakshly/core/models/previous_car_requests.dart';

import 'package:rakshly/core/services/http_service.dart';
import 'package:rakshly/features/license/widgets/tab_card.dart';

class PreviousRequest extends GetView<PreviousRequestController> {
  const PreviousRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreviousRequestController());

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
        children: const [
          CarLicenseTab(),
          DrivingLicenseTab(),
        ],
      ),
    );
  }
}

class PreviousRequestController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
  }
}

class CarLicenseTab extends StatefulWidget {
  const CarLicenseTab({super.key});

  @override
  _CarLicenseTabState createState() => _CarLicenseTabState();
}

class _CarLicenseTabState extends State<CarLicenseTab>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.put(CarLicenseTabController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Obx(() => Text(controller.car.value)),
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
  const DrivingLicenseTab({super.key});

  @override
  _DrivingLicenseState createState() => _DrivingLicenseState();
}

class _DrivingLicenseState extends State<DrivingLicenseTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var controller = Get.put(DrivingLicenseController(context: context));
    return Center(
      child: Obx(() => controller.isBusy.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : controller.isError.value
              ? Center(
                  child: Column(
                    children: [
                      Text("error".tr),
                      MaterialButton(
                        onPressed: () async {
                          await controller
                              .getPreviosDrivingLicensesRequest(context);
                        },
                        child: Text("Retry".tr),
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(
                            controller.prevRequest?.results?.length ?? 0,
                            (index) => TabItem(
                                item: controller.prevRequest!.results![index]),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DrivingLicenseController extends GetxController {
  final bike = ''.obs;
  var isBusy = false.obs;
  var isError = false.obs;
  final api = Get.find<HttpService>();
  final BuildContext context;
  DrivingLicenseController({
    required this.context,
  });

  PreviosDrivingLicenseRequest? prevRequest;

  @override
  void onInit() async {
    super.onInit();
    await getPreviosDrivingLicensesRequest(context);
  }

  getPreviosDrivingLicensesRequest(context) async {
    isError.value = false;
    isBusy.value = true;
    final res = await api.getPreviosDrivingLicensesRequest();
    if (res.statusCode == 200) {
      prevRequest = PreviosDrivingLicenseRequest.fromJson(res.body);
      isBusy.value = false;
    } else {
      isBusy.value = false;
      isError.value = true;
      AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.bottomSlide,
              desc: res.bodyString,
              descTextStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
          .show();
    }
  }
}
