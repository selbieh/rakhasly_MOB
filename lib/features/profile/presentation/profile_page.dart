import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rakshly/core/models/user.dart';
import 'package:rakshly/core/services/auth/I_auth_service.dart';
import 'package:rakshly/features/auth/presentation/sign_in_screen.dart';
import 'package:rakshly/features/home/presentation/home.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: Text("Profile".tr),
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
                    // ),
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
                                decoration: InputDecoration(
                                    labelText: "Name".tr,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
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
                                  decoration: InputDecoration(
                                      labelText: "Email".tr,
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
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
                                  decoration: InputDecoration(
                                      labelText: "Phone".tr,
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
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
                                child: ReactiveDropdownField(
                                  items: ['English', "العربية"]
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  formControlName: 'language',
                                  onChanged: (control) async {
                                    var lang = control.value;
                                    if (lang != null) {
                                      Get.updateLocale(lang == 'English'
                                          ? const Locale('en')
                                          : const Locale('ar'));

                                      await GetStorage()
                                          .write('language', lang);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Language".tr,
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
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
            Obx(
              () => controller.isBusy.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: MaterialButton(
                          onPressed: () async {
                            if (controller.form.valid) {
                              await controller.updateProfile(context);
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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
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
                  child: Center(
                    child: Text(
                      "Logout".tr,
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
                  child: Center(
                    child: Text(
                      "Delete Account".tr,
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

class ProfileController extends GetxController {
  final AuthService authService;
  late UserInfo? user;

  Rx<bool> isBusy = false.obs;

  ProfileController() : authService = Get.find<AuthService>() {
    user = authService.user?.user;
    form = FormGroup({
      "name": FormControl<String?>(
          value: user?.name, validators: [Validators.required]),
      "email": FormControl<String>(
          value: user?.email,
          validators: [Validators.required, Validators.email]),
      'phone': FormControl<String>(value: user?.phone, validators: [
        Validators.required,
        Validators.maxLength(13),
        Validators.minLength(13),
        Validators.pattern(r'^\+20[0-9]{10}$')
      ]),
      "language": FormControl<String>(
          value: Get.locale?.languageCode == "en" ? "English" : "العربية"),
    });
  }
  late FormGroup form;

  Map generateUpdateForm() {
    return {
      'name': form.controls['name']?.value,
      'phone': form.controls['phone']?.value
    };
  }

  Future updateProfile(context) async {
    final authService = Get.find<AuthService>();
    isBusy.value = true;
    var res = await authService.updateAccount(body: form.value);
    res.fold((left) async {
      isBusy.value = false;
      await AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              desc: left.message)
          .show();
    }, (right) async {
      var newProfile = UserInfo.fromJson(right);
      var user = authService.user!;
      user.user = newProfile;
      await authService.saveUser(user: user);
      isBusy.value = false;
      Get.off(const Home());
    });
  }
}
