import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rakshny/core/languages.dart';
import 'package:rakshny/features/splash/splash_page.dart';
import 'package:rakshny/intial_binding.dart';

void main() async {
  // Get.lazyPut(() => SignInController(), tag: 'SignInController');
  // Get.lazyPut(() => ProfileController(), tag: 'ProfileController', fenix: true);
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(
      // EasyLocalization(
      //     supportedLocales: const [Locale('en'), Locale('ar')],
      //     path: 'assets/languages',
      //     fallbackLocale: const Locale('en'),
      //     child:
      const MyApp()
      //  ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rakhsly',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      initialBinding: RakhslyBinding(),
      translations: Languages(),
      locale: GetStorage().read('language') != null &&
              GetStorage().read('language') == 'العربية'
          ? const Locale('ar')
          : const Locale('en'),
    );
  }
}
