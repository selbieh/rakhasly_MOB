import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rakshly/core/services/auth/I_auth_service.dart';
import 'package:rakshly/features/auth/presentation/sign_in_screen.dart';
import 'package:rakshly/features/home/presentation/home.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000)).then((value) async {
      if (GetStorage().hasData('user')) {
        await Get.find<AuthService>().loadUser();
        Get.off(() => const Home());
      } else {
        Get.off(() => const SignInPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.blue.shade900,
            Colors.blue.shade800,
            Colors.blue.shade400
          ])),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Image.asset('assets/images/splash.png'),
          ))),
    );
  }
}
