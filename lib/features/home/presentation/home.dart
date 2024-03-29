import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakshly/core/services/auth/I_auth_service.dart';
import 'package:rakshly/features/auth/presentation/sign_in_screen.dart';
import 'package:rakshly/features/home/controller/home_controller.dart';
import 'package:rakshly/features/license/presentation/car_license.dart';
import 'package:rakshly/features/license/presentation/driver_license.dart';
import 'package:rakshly/features/license/presentation/previous_request.dart';
import 'package:rakshly/features/profile/presentation/profile_page.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var gridItems = [
      {
        "title": "Driving license".tr,
        "asset": "assets/images/driver_license_2.jpg",
        "tag": "",
        "onClick": () {
          if (!Get.find<AuthService>().isLoggedIn) {
            Get.to(() => const SignInPage());
          } else {
            Get.to(() => const DriverLicensePage());
          }
        }
      },
      {
        "title": "Car license".tr,
        "asset": "assets/images/car_license.png",
        "tag": "",
        "onClick": () {
          if (!Get.find<AuthService>().isLoggedIn) {
            Get.to(() => const SignInPage());
          } else {
            Get.to(() => const CarLicensePage());
          }
        }
      },
      {
        "title": "My requests".tr,
        "asset": "assets/images/profile.jpg",
        "tag": "profile_image",
        "onClick": () async {
          if (!Get.find<AuthService>().isLoggedIn) {
            Get.to(() => const SignInPage());
          } else {
            Get.to(() => PreviousRequest());
          }
        }
      },
    ];
    Get.put(HomeController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue.shade900,
          Colors.blue.shade800,
          Colors.blue.shade400
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: Text(
                            "Welcome".tr,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 40),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1300),
                          child: Text(
                            controller.user != null
                                ? controller.user?.user?.name ?? "User"
                                : "Guest",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          )),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!await Get.find<AuthService>().isAuthiticatedUser()) {
                        Get.to(() => const SignInPage());
                      } else {
                        Get.to(() => const ProfilePage());
                      }
                    },
                    child: Hero(
                      tag: "profile_image2",
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blue.shade800,
                        child: const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person_2_outlined, size: 40),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    itemCount: gridItems.length,
                    itemBuilder: (ctx, i) {
                      return GridItem(
                        index: i,
                        asset: gridItems[i]["asset"].toString(),
                        title: gridItems[i]["title"].toString(),
                        tag: gridItems[i]["tag"].toString(),
                        onClick: gridItems[i]["onClick"] as VoidCallback,
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 5,
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

// ignore: must_be_immutable
class GridItem extends StatelessWidget {
  final int index;
  final String asset;
  final String title;
  final String tag;
  void Function() onClick;

  GridItem({
    super.key,
    required this.index,
    required this.asset,
    required this.title,
    required this.tag,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: FadeInRight(
        duration: const Duration(milliseconds: 1000),
        child: Container(
          height: 80,
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
                Expanded(
                  child: Center(
                      child: tag.isEmpty
                          ? Image.asset(
                              asset,
                              width: 80,
                            )
                          : Hero(
                              tag: tag,
                              child: Image.asset(
                                asset,
                                width: 80,
                              ))),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
