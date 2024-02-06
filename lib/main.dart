import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakshny/features/auth/presentation/sign_in_screen.dart';
import 'package:rakshny/features/profile/presentation/profile_page.dart';
import 'package:rakshny/features/splash/splash_page.dart';
import 'package:rakshny/intial_binding.dart';

void main() {
  Get.lazyPut(() => SignInController(), tag: 'SignInController');
  Get.lazyPut(() => ProfileController(), tag: 'ProfileController', fenix: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      initialBinding: RakhslyBinding(),
    );
  }
}
