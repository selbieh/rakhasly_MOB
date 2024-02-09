import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rakshny/core/models/governorate.dart';
import 'package:rakshny/core/models/traffics.dart';
import 'package:rakshny/core/models/user.dart';
import 'package:rakshny/core/services/http_service.dart';
import 'package:rakshny/features/home/presentation/home.dart';
import 'package:rakshny/features/license/widgets/reactive_image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

class DriverLicensePage extends GetView<DriverLicenseController> {
  const DriverLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DriverLicenseController());
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: Text("Driver License".tr),
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
                                    onChanged: (formControl) {
                                      controller.form.controls['installment']
                                          ?.value = formControl.value!;
                                      if (formControl.value == false) {
                                        controller
                                            .form.controls['installmentPlane']
                                            ?.reset();
                                      }

                                      controller.update();
                                    },
                                    title: Text('Installment'.tr),
                                    formControlName: 'installment',
                                  ),
                                ),
                              ),
                              // controller.form.controls['installment']?.value !=
                              //             null &&
                              //         controller.form.controls['installment']
                              //                 ?.value ==
                              //             true
                              //     ? Padding(
                              //         padding: const EdgeInsets.only(top: 8.0),
                              //         child: FormItem(
                              //           controller: controller,
                              //           child: ReactiveDropdownField(
                              //               items: [
                              //                 '1 Year'.tr,
                              //                 '2 Year'.tr,
                              //                 '3 Year'.tr
                              //               ]
                              //                   .map((e) => DropdownMenuItem(
                              //                         value: e,
                              //                         child: Text(e),
                              //                       ))
                              //                   .toList(),
                              //               formControlName: 'installmentPlane',
                              //               decoration: InputDecoration(
                              //                   labelText: "Installment".tr,
                              //                   hintText: "Installment".tr,
                              //                   contentPadding:
                              //                       const EdgeInsets.symmetric(
                              //                           horizontal: 8),
                              //                   hintStyle: const TextStyle(
                              //                       color: Colors.grey),
                              //                   border: InputBorder.none)),
                              //         ),
                              //       )
                              //     : const SizedBox(),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: FormItem(
                                    controller: controller,
                                    child: ReactiveTextField(
                                      formControlName: 'date',
                                      onTap: (_) async {
                                        if (controller
                                            ._focusNode.canRequestFocus) {
                                          controller._focusNode.unfocus();
                                          var picked = await showDatePicker(
                                              context: context,
                                              firstDate: DateTime(
                                                DateTime.now().year,
                                                DateTime.now().month,
                                              ),
                                              lastDate: DateTime(
                                                  DateTime.now().year,
                                                  DateTime.now().month,
                                                  31));
                                          if (picked != null) {
                                            controller.form.controls['date']
                                                ?.value = picked;
                                            controller.update();
                                          }
                                        }
                                      },
                                      valueAccessor: DateTimeValueAccessor(
                                        dateTimeFormat:
                                            DateFormat('dd MMM yyyy'),
                                      ),
                                      focusNode: controller._focusNode,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 8),
                                        labelText: 'Visit time'.tr,
                                        suffixIcon: controller.form
                                                    .controls['date']?.value !=
                                                null
                                            ? IconButton(
                                                onPressed: () {
                                                  controller
                                                      .form.controls['date']
                                                      ?.reset();
                                                  controller.update();
                                                },
                                                icon: const Icon(Icons.close))
                                            : const SizedBox(),
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: FormItem(
                                  controller: controller,
                                  child: CustomReactiveImagePicker(
                                    formControlName: 'nationalIdImage',
                                    label: 'National ID'.tr,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: FormItem(
                                  controller: controller,
                                  child: CustomReactiveImagePicker(
                                    formControlName: 'licenseImage',
                                    label: 'License Image'.tr,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: FormItem(
                                  controller: controller,
                                  child: ReactiveTextField(
                                    formControlName: 'notes',
                                    maxLines: 3,
                                    decoration:
                                        InputDecoration(labelText: "Notes".tr),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => controller.isBusy.isFalse
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: MaterialButton(
                          onPressed: () async {
                            if (controller.form.valid) {
                              await controller.saveForm(context);
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
                          child: Center(
                            child: Text(
                              "Save".tr,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    ))
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

  final DriverLicenseController controller;
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

class DriverLicenseController extends GetxController
    with StateMixin<List<Governorate>> {
  HttpService api;
  UserInfo? user;
  List<Governorate>? governorate;
  Governorate? selectedGovernate;

  File? image;

  late FocusNode _focusNode;

  RxBool isBusy = false.obs;

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
    var res = await api.getGovernmentsLicenseUnits();
    if (res.statusCode == 200) {
      governorate = (json.decode(res.bodyString ?? "") as List)
          .map((i) => Governorate.fromJson(i))
          .toList();
      change(governorate, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.success());
    }
  }

  DriverLicenseController() : api = Get.find<HttpService>() {
    // user = authService.user!.user;
    form = FormGroup({
      "government": FormControl<Governorate>(),
      "license_unit": FormControl<Traffics>(),
      "installment": FormControl<bool>(value: false),
      "installmentPlane": FormControl<String>(),
      "date": FormControl<DateTime>(),
      "vip": FormControl<bool>(value: false),
      "nationalIdImage": FormControl<List<SelectedFile>>(),
      "licenseImage": FormControl<List<SelectedFile>>(),
      "notes": FormControl<String>(),
    });
  }
  late FormGroup form;

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;

      form.controls['newCar']?.value = true;
      form.controls['contractImage']?.value = imageTemp;

      update();
      // form.controls['contractImage']?.value = this.image;
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future saveForm(context) async {
    debugPrint(form.value.toString());
    isBusy.value = true;
    // update();
    var formDataBody = _createMultipartFormData();
    final res = await api.saveForm(formDataBody);
    debugPrint(res.bodyString.toString());
    if (res.statusCode == 200) {
      Get.off(() => const Home());
    } else {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.bottomSlide,
              desc: res.bodyString,
              descTextStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
          .show();
    }
    isBusy.value = false;
    update();
  }

  FormData _createMultipartFormData() {
    return FormData({
      "government": (form.control('government').value as Governorate).id,
      "licensing_unit": (form.control('license_unit').value as Traffics).id,
      "installment": form.control('installment').value.toString(),
      "visit_date": form.control('date').value.toString(),
      "vip_assistance": form.control('vip').value.toString(),
      "license_id_image": form.control('licenseImage').value != null
          ? MultipartFile(
              (form.control('licenseImage').value as List<SelectedFile>)[0]
                  .file
                  ?.path,
              filename:
                  (form.control('licenseImage').value as List<SelectedFile>)[0]
                          .file
                          ?.path
                          .split("/")
                          .last ??
                      "Image.jpg",
            )
          : null,
      "national_id_image": form.control('nationalIdImage').value != null
          ? MultipartFile(
              (form.control('nationalIdImage').value as List<SelectedFile>)[0]
                  .file
                  ?.path,
              filename: (form.control('nationalIdImage').value
                          as List<SelectedFile>)[0]
                      .file
                      ?.path
                      .split("/")
                      .last ??
                  "Image.jpg",
            )
          : null,
    });
  }
}
