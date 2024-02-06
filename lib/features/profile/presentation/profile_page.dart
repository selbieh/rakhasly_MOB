import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.find(tag: 'ProfileController');
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
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
                    const SizedBox(height: 20),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Hero(
                          tag: "profile_image",
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.asset(
                                "assets/images/profile.jpg",
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        child: const Text(
                          "Change Picture",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
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
                                  formControlName: 'birthdate',
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
          ],
        ),
      ),
    );
  }
}

class ProfileController extends GetxController {
  FormGroup form = new FormGroup({
    "name": FormControl<String>(value: "Omar"),
    "email": FormControl<String>(value: "admin@gmail.com"),
    "photo": FormControl<String>(),
    "birthdate": FormControl<String>(value: "17/10/1997"),
  });
}
