import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rakshny/core/models/governorate.dart';
import 'package:rakshny/core/models/traffics.dart';
import 'package:rakshny/core/models/user.dart';
import 'package:rakshny/core/services/http_service.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DrivingLicensePage extends GetView<DrivingLicenseController> {
  const DrivingLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DrivingLicenseController());
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: const Text("New Driving License"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            }),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: controller.obx(
          (governrates) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(105, 148, 227, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: ReactiveForm(
                          formGroup: controller.form,
                          child: Column(
                            children: <Widget>[
                              FormItem(
                                controller: controller,
                                child: ReactiveDropdownField(
                                  items: (governrates ?? [])
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.name),
                                          ))
                                      .toList(),
                                  formControlName: 'government',
                                  onChanged: (formControl) {
                                    controller.selectedGovernate =
                                        formControl.value!;

                                    controller.update();
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Goverenrate".tr,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8),
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: FormItem(
                                  controller: controller,
                                  child: ReactiveDropdownField(
                                    items: controller.selectedGovernate != null
                                        ? controller.selectedGovernate?.traffics
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(e.name),
                                                    ))
                                                .toList() ??
                                            []
                                        : [],
                                    formControlName: 'license_unit',
                                    decoration: InputDecoration(
                                        hintText: "License unit".tr,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 8),
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: FormItem(
                                  controller: controller,
                                  child: ReactiveCheckboxListTile(
                                    checkColor: Colors.white,
                                    activeColor: Colors.blue,
                                    title: Text('Need check'.tr),
                                    formControlName: 'needCheck',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: FormItem(
                                  controller: controller,
                                  child: ReactiveCheckboxListTile(
                                    checkColor: Colors.white,
                                    activeColor: Colors.blue,
                                    onChanged: (formControl) {
                                      controller.form.controls['installment']
                                          ?.value = formControl.value!;

                                      controller.update();
                                    },
                                    title: Text('Installment'.tr),
                                    formControlName: 'installment',
                                  ),
                                ),
                              ),
                              controller.form.controls['installment']?.value !=
                                          null &&
                                      controller.form.controls['installment']
                                              ?.value ==
                                          true
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: FormItem(
                                        controller: controller,
                                        child: ReactiveDropdownField(
                                            items: [
                                              '1 Year',
                                              '2 Year',
                                              '3 Year'
                                            ]
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(e),
                                                    ))
                                                .toList(),
                                            formControlName: 'installmentPlane',
                                            decoration: InputDecoration(
                                                hintText: "Installment".tr,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none)),
                                      ),
                                    )
                                  : const SizedBox(),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: FormItem(
                                    controller: controller,
                                    child: ReactiveDatePicker<DateTime>(
                                      formControlName: 'date',
                                      firstDate: DateTime(DateTime.now().month),
                                      lastDate:
                                          DateTime(DateTime.now().month + 1),
                                      builder: (context, picker, child) {
                                        Widget suffix = InkWell(
                                          onTap: () {
                                            // workaround until https://github.com/flutter/flutter/issues/39376
                                            // will be fixed

                                            // Unfocus all focus nodes
                                            controller._focusNode.unfocus();

                                            // Disable text field's focus node request
                                            controller._focusNode
                                                .canRequestFocus = false;

                                            // clear field value
                                            picker.control.value = null;

                                            //Enable the text field's focus node request after some delay
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 100), () {
                                              controller._focusNode
                                                  .canRequestFocus = true;
                                            });
                                          },
                                          child: const Icon(Icons.clear),
                                        );

                                        if (picker.value == null) {
                                          suffix =
                                              const Icon(Icons.calendar_today);
                                        }

                                        return ReactiveTextField(
                                          onTap: (_) {
                                            if (controller
                                                ._focusNode.canRequestFocus) {
                                              controller._focusNode.unfocus();
                                              picker.showPicker();
                                            }
                                          },
                                          valueAccessor: DateTimeValueAccessor(
                                            dateTimeFormat:
                                                DateFormat('dd MMM yyyy'),
                                          ),
                                          focusNode: controller._focusNode,
                                          formControlName: 'date',
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8),
                                            labelText: 'Visit time',
                                            suffixIcon: suffix,
                                          ),
                                        );
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    onPressed: () async {
                      if (controller.form.valid) {
                      } else {
                        debugPrint("Error");
                      }
                    },
                    height: 50,
                    // margin: EdgeInsets.symmetric(horizontal: 50),
                    color: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    // decoration: BoxDecoration(
                    // ),
                    child: const Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormItem extends StatelessWidget {
  const FormItem({
    super.key,
    required this.controller,
    required this.child,
  });

  final DrivingLicenseController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
        child: child);
  }
}

class DrivingLicenseController extends GetxController
    with StateMixin<List<Governorate>> {
  HttpService api;
  UserInfo? user;
  List<Governorate>? governorate;
  Governorate? selectedGovernate;

  late FocusNode _focusNode;

  @override
  onInit() async {
    super.onInit();
    _focusNode = FocusNode();
    change(null, status: RxStatus.empty());
    api = Get.find();
    await getGovernmentsLicenseUnits();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future getGovernmentsLicenseUnits() async {
    change(null, status: RxStatus.loading());
    var res = await api
        .get('https://amrtarkhan.pythonanywhere.com/api/v1/governorates/');
    if (res.statusCode == 200) {
      governorate = (json.decode(res.bodyString ?? "") as List)
          .map((i) => Governorate.fromJson(i))
          .toList();
      change(governorate, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.success());
    }
  }

  DrivingLicenseController() : api = Get.find<HttpService>() {
    // user = authService.user!.user;
    form = FormGroup({
      "government": FormControl<Governorate>(),
      "license_unit": FormControl<Traffics>(),
      "needCheck": FormControl<bool>(value: false),
      "installment": FormControl<bool>(value: false),
      "installmentPlane": FormControl<String>(),
      "date": FormControl<DateTime>(),
      "vip": FormControl<bool>(value: false),
      "newCar": FormControl<bool>(value: false),
      "contract": FormControl<String>(),
    });
  }
  late FormGroup form;
}
