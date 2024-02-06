import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakshny/core/models/user.dart';
import 'package:rakshny/core/services/auth/I_auth_service.dart';
import 'package:rakshny/features/home/presentation/home.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:animate_do/animate_do.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    // SignInController controller = Get.find(tag: 'SignInController');

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
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1300),
                        child: const Text(
                          "Welcome Back",
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
                      const SizedBox(
                        height: 60,
                      ),
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
                                    formControlName: 'email',
                                    decoration: const InputDecoration(
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
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
                                    formControlName: 'password',
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
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
                      GestureDetector(
                        onTap: () {
                          debugPrint("Forget Password");
                        },
                        child: FadeInUp(
                            duration: const Duration(milliseconds: 1500),
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.grey),
                            )),
                      ),
                      const SizedBox(height: 30),
                      controller.obx(
                        (state) {
                          debugPrint("Logged in");
                          return const SizedBox();
                        },
                        onEmpty: FadeInUp(
                            duration: const Duration(milliseconds: 1600),
                            child: LoginBtn(controller: controller)),
                        onError: (error) => Column(
                          children: [
                            LoginBtn(controller: controller),
                            const SizedBox(height: 20),
                            Text(error ?? "Error",
                                style: const TextStyle(color: Colors.red)),
                          ],
                        ),
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
                            child: const Text(
                              "Login as a guest",
                              style: TextStyle(color: Colors.grey),
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
  });

  final SignInController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        if (controller.form.valid) {
          FocusManager.instance.primaryFocus?.unfocus();

          await controller.signIn();
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
          "Login",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SignInController extends GetxController with StateMixin<bool> {
  FormGroup form = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)])
  });

  SignInController() {
    change(false, status: RxStatus.empty());
  }

  Future signIn() async {
    final authService = Get.find<AuthService>();
    change(null, status: RxStatus.loading());
    var res = await authService.login(body: form.value);
    res.fold((left) {
      change(false, status: RxStatus.error(left.message));
    }, (right) async {
      var user = User.fromJson(right);
      await authService.saveUser(user: user);
      change(true, status: RxStatus.success());
      Get.offAll(const Home());
    });
  }
}
