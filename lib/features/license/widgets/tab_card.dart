import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakshly/core/models/previous_car_requests.dart';
import 'package:rating_dialog/rating_dialog.dart';

class TabItem extends StatelessWidget {
  final PrevDrivingLicenseRequestResults item;

  TabItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.status == "DONE") {
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
            onSubmitted: (response) {
              debugPrint(
                  'rating: ${response.rating}, comment: ${response.comment}');

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
                    {"status": item.status ?? ""},
                    {"needs_check": item.needsCheck ?? false},
                    {"renewal_duration": item.renewalDuration ?? 0},
                    {"visit_date": item.visitDate ?? ""},
                    {"visit_slot": item.visitSlot ?? ""},
                    {"vip_assistance": item.vipAssistance ?? false},
                    {"installment": item.installment ?? false},
                    {"is_new_car": item.isNewCar ?? false},
                    {"contract": item.contract ?? ""},
                    {"license_id_image": item.licenseIdImage ?? ""},
                    {"national_id_image": item.nationalIdImage ?? ""},
                    {"price": item.price ?? ""},
                    {"notes": item.notes ?? ""},
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
                  if (item.status != "DONE") ...[
                    MaterialButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.red,
                      child: Text(
                        "Cancel request".tr,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
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
