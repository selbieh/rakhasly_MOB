import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakshly/core/models/previous_car_requests.dart';
import 'package:rakshly/core/services/http_service.dart';
import 'package:rakshly/features/license/presentation/previous_request.dart';
import 'package:rating_dialog/rating_dialog.dart';

class TabItem extends StatelessWidget {
  PrevDrivingLicenseRequestResults? item;
  final PreviousRequestController controller;
  final BuildContext ctx;
  TabItem(
      {super.key,
      required this.item,
      required this.controller,
      required this.ctx});

  @override
  Widget build(BuildContext context) {
    var isPending = false.obs;
    var type = controller.tabController.index == 0 ? "car" : "driver";
    return GestureDetector(
      onTap: () {
        if (item!.status == "DONE") {
          final dialog = RatingDialog(
            initialRating: 1.0,
            // your app's name?
            title: Text(
              'Rate our service'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            // encourage your user to leave a high rating?
            message: Text(
              'Tap a star to set your rating. Add more description here if you want.'
                  .tr,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
            // your app's logo?
            // image: const FlutterLogo(size: 100),
            submitButtonText: 'Submit',
            commentHint: 'Set your custom comment hint',
            onCancelled: () => debugPrint('cancelled'),
            onSubmitted: (response) async {
              debugPrint(
                  'rating: ${response.rating}, comment: ${response.comment}');

              final api = Get.find<HttpService>();
              var res = await api.rating(
                  {"rating": response.rating, "comment": response.comment});

              if (res.statusCode == 201) {
                await AwesomeDialog(
                        context: ctx,
                        desc: "Rating is done".tr,
                        dialogType: DialogType.success)
                    .show();
              } else {
                await AwesomeDialog(
                        context: ctx,
                        desc: "Error in rating".tr,
                        dialogType: DialogType.error)
                    .show();
              }
              debugPrint(res.body.toString());
              if (response.rating < 3.0) {}
            },
          );

          // show the dialog
          showDialog(
            context: context,
            barrierDismissible:
                true, // set to false if you want to force a rating
            builder: (context) => dialog,
          );
        }
      },
      child: FadeInRight(
        duration: const Duration(milliseconds: 1000),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
          child: Container(
            // height: 130,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(105, 148, 227, .3),
                      blurRadius: 20,
                      offset: Offset(0, 10))
                ]),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...[
                    {"id": item!.id ?? ""},
                    {"status": item!.status ?? ""},
                    {"needs_check": item!.needsCheck ?? false},
                    {"renewal_duration": item!.renewalDuration ?? 0},
                    {"visit_date": item!.visitDate ?? ""},
                    {"vip_assistance": item!.vipAssistance ?? false},
                    {"installment": item!.installment ?? false},
                    {"is_new_car": item!.isNewCar ?? false},
                    // {"contract": item!.contract ?? ""},
                    {"price": item!.price ?? ""},
                    {"notes": item!.notes ?? ""},
                  ].map<Widget>(
                    (item) {
                      var itemKey = item.keys.first;
                      var itemValue = item[itemKey];
                      return Row(
                        children: [
                          Text(
                            "$itemKey : ",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width * .9) * .6,
                              child: Text(
                                itemValue.toString(),
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                  if (item!.status != "DONE" &&
                      item!.status != "APPROVED" &&
                      item!.status != "CANCELED") ...[
                    MaterialButton(
                      onPressed: isPending.value
                          ? null
                          : () async {
                              try {
                                controller.isBusy.value = true;
                                final api = Get.find<HttpService>();
                                var res;
                                int id = item!.id!;
                                if (type == "car") {
                                  res = await api.updateCarLicenseRequest(
                                      id, {"status": "CANCELED"});
                                } else {
                                  res = await api.updateDriverLicenseRequest(
                                      id, {"status": "CANCELED"});
                                }
                                item =
                                    PrevDrivingLicenseRequestResults.fromJson(
                                        res.body);

                                var oldIndex = controller
                                    .prevRequest.value.results
                                    ?.indexWhere((element) => element.id == id);
                                controller.prevRequest.value
                                    .results![oldIndex!] = item!;
                                controller.isBusy.value = false;
                              } catch (e) {
                                controller.isBusy.value = false;
                              }
                            },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.red,
                      child: Text(
                        "Cancel request".tr,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
