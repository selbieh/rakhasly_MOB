import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakshly/core/models/user.dart';
import 'package:rakshly/core/services/auth/I_auth_service.dart';
import 'package:rakshly/features/home/presentation/home.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:animate_do/animate_do.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.blue.shade900,
            Colors.blue.shade800,
            Colors.blue.shade400
          ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: Text(
                          "Registeration".tr,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 40),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1300),
                        child: Text(
                          "Welcome".tr,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 60),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1400),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
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
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: ReactiveTextField(
                                    formControlName: 'name',
                                    decoration: InputDecoration(
                                        hintText: "Name".tr,
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: ReactiveTextField(
                                    formControlName: 'email',
                                    decoration: InputDecoration(
                                        hintText: "Email".tr,
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: ReactiveTextField(
                                    formControlName: 'phone',
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        hintText: "Phone Number".tr,
                                        prefix: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Text("+2"),
                                        ),
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: ReactiveTextField(
                                    formControlName: 'password1',
                                    obscureText: true,
                                    showErrors: (control) =>
                                        control.invalid &&
                                        control.touched &&
                                        control.dirty,
                                    decoration: InputDecoration(
                                        hintText: "Password".tr,
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: ReactiveTextField(
                                    obscureText: true,
                                    formControlName: 'password2',
                                    decoration: InputDecoration(
                                        hintText: "Confirm Password".tr,
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      controller.obx(
                        (state) {
                          debugPrint("Logged in");
                          return const SizedBox();
                        },
                        onEmpty: FadeInUp(
                            duration: const Duration(milliseconds: 1600),
                            child: LoginBtn(
                              controller: controller,
                              ctx: context,
                            )),
                        // onError: (error) => Column(
                        //   children: [
                        //     LoginBtn(
                        //       controller: controller,
                        //       ctx: context,
                        //     ),
                        //     const SizedBox(height: 20),
                        //     Text(error ?? "Error".tr,
                        //         style: const TextStyle(color: Colors.red)),
                        //   ],
                        // ),
                        onLoading: const CircularProgressIndicator(),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          debugPrint("Guest");
                          Get.off(() => const Home());
                        },
                        child: FadeInUp(
                            duration: const Duration(milliseconds: 1500),
                            child: Text(
                              "Login as a guest".tr,
                              style: const TextStyle(color: Colors.grey),
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginBtn extends StatelessWidget {
  const LoginBtn({
    super.key,
    required this.controller,
    required this.ctx,
  });

  final SignUpController controller;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        controller.form.unfocus();
        if (controller.form.valid) {
          FocusManager.instance.primaryFocus?.unfocus();

          await controller.signUp(ctx);
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
          "Sign Up".tr,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SignUpController extends GetxController with StateMixin<bool> {
  FormGroup form = FormGroup({
    'username': FormControl<String>(),
    'name': FormControl<String>(),
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
    'phone': FormControl<String>(validators: [
      Validators.required,
      Validators.maxLength(10),
      Validators.minLength(10),
      Validators.pattern(r'^[0-9]{10}$')
    ]),
    'password1': FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)]),
    'password2': FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)]),
  }, validators: [
    const MustMatchValidator('password1', 'password2', true)
  ]);

  @override
  onInit() {
    super.onInit();
    change(false, status: RxStatus.empty());
  }

  Future signUp(context) async {
    var newForm = form.value;
    newForm['phone'] = '+2${(form.controls['phone']?.value as String)}';

    form.controls['username']?.value =
        (form.controls['email']?.value as String).split("@")[0];
    final authService = Get.find<AuthService>();
    change(null, status: RxStatus.loading());
    var res = await authService.signUp(body: form.value);
    res.fold((left) async {
      change(false, status: RxStatus.empty());
      await AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              desc: "Error in singup".tr)
          .show();
    }, (right) async {
      var user = User.fromJson(right);
      await authService.saveUser(user: user);
      change(true, status: RxStatus.success());
      Get.offAll(const Home());
    });
  }
}
