import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakshny/core/models/user.dart';
import 'package:rakshny/core/services/auth/I_auth_service.dart';
import 'package:rakshny/core/services/http_service.dart';
import 'package:rakshny/features/auth/presentation/sign_in_screen.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    // Center(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(12),
                    //     child: Hero(
                    //       tag: "profile_image",
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(60),
                    //           border: Border.all(color: Colors.grey),
                    //         ),
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(60),
                    //           child: Image.asset(
                    //             "assets/images/profile.jpg",
                    //             height: 100,
                    //             width: 100,
                    //             fit: BoxFit.fill,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Center(
                    //   child: TextButton(
                    //     child: const Text(
                    //       "Change Picture",
                    //       style: TextStyle(
                    //         decoration: TextDecoration.underline,
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ),
                    //     onPressed: () {},
                    //   ),
                    // ),P
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
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: ReactiveTextField(
                                formControlName: 'name',
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: ReactiveTextField(
                                  formControlName: 'email',
                                  showErrors: (controller) =>
                                      controller.hasErrors,
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: ReactiveTextField(
                                  formControlName: 'phone',
                                  showErrors: (controller) =>
                                      controller.hasErrors,
                                  decoration: const InputDecoration(
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  onPressed: () async {
                    await Get.find<AuthService>().removeUser();
                    Get.offAll(() => const SignInPage());
                  },
                  height: 50,
                  // margin: EdgeInsets.symmetric(horizontal: 50),
                  color: Colors.blue[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  // decoration: BoxDecoration(
                  // ),
                  child: const Center(
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
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
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  // decoration: BoxDecoration(
                  // ),
                  child: const Center(
                    child: Text(
                      "Delete Account",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrivingLicenseController extends GetxController {
  final HttpService api;
  UserInfo? user;

  @override
  onInit() {
    super.onInit();
  }

  DrivingLicenseController() : api = Get.find<HttpService>() {
    // user = authService.user!.user;
    form = FormGroup({
      "name": FormControl<String?>(value: user?.name),
      "email": FormControl<String>(value: user?.email),
      "photo": FormControl<String>(),
      "phone": FormControl<String>(value: user?.phone),
    });
  }
  late FormGroup form;
}
