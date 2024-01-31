import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:animate_do/animate_do.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignInController controller = Get.find(tag: 'SignInController');
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Login"),
    //   ),
    //   body: Column(children: [
    //     Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: ReactiveForm(
    //           formGroup: controller.form,
    //           child: Column(
    //             children: [
    //               ReactiveTextField(
    //                 formControlName: 'username',
    //                 decoration: const InputDecoration(
    //                     label: Text('Username'), hintText: 'user'),
    //               ),
    //               const SizedBox(height: 10),
    //               ReactiveTextField(
    //                 formControlName: 'password',
    //                 decoration: const InputDecoration(
    //                     label: Text('Password'), hintText: 'Password'),
    //               ),
    //               const SizedBox(height: 10),
    //             ],
    //           )),
    //     )
    //   ]),
    // );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.orange.shade900,
            Colors.orange.shade800,
            Colors.orange.shade400
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
                                      color: Color.fromRGBO(225, 95, 27, .3),
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
                                      formControlName: 'username',
                                      decoration: InputDecoration(
                                          hintText: "Email or Phone number",
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
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1500),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1600),
                          child: MaterialButton(
                            onPressed: () {},
                            height: 50,
                            // margin: EdgeInsets.symmetric(horizontal: 50),
                            color: Colors.orange[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            // decoration: BoxDecoration(
                            // ),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      // FadeInUp(
                      //   duration: const Duration(milliseconds: 1700),
                      //   child: const Text(
                      //     "Continue with social media",
                      //     style: TextStyle(color: Colors.grey),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      // Row(
                      //   children: <Widget>[
                      //     Expanded(
                      //       child: FadeInUp(
                      //           duration: const Duration(milliseconds: 1800),
                      //           child: MaterialButton(
                      //             onPressed: () {},
                      //             height: 50,
                      //             color: Colors.blue,
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(50),
                      //             ),
                      //             child: const Center(
                      //               child: Text(
                      //                 "Facebook",
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //           )),
                      //     ),
                      //     const SizedBox(
                      //       width: 30,
                      //     ),
                      //     Expanded(
                      //       child: FadeInUp(
                      //           duration: const Duration(milliseconds: 1900),
                      //           child: MaterialButton(
                      //             onPressed: () {},
                      //             height: 50,
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(50),
                      //             ),
                      //             color: Colors.black,
                      //             child: const Center(
                      //               child: Text(
                      //                 "Github",
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //           )),
                      //     )
                      //   ],
                      // )
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

class SignInController extends GetxController {
  FormGroup form = FormGroup({
    'username': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required])
  });
}
