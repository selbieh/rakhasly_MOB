import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rakshly/core/languages.dart';
import 'package:rakshly/features/splash/splash_page.dart';
import 'package:rakshly/intial_binding.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
    return ReactiveFormConfig(
      validationMessages: {
        ValidationMessage.required: (error) => 'Field must not be empty'.tr,
        ValidationMessage.email: (error) => 'Must enter a valid email'.tr,
        ValidationMessage.min: (error) => 'Minimum Length'.tr,
        ValidationMessage.minLength: (error) => 'Minimum Length'.tr,
        ValidationMessage.max: (error) => 'Max Length'.tr,
        ValidationMessage.maxLength: (error) => 'Max Length'.tr,
        ValidationMessage.mustMatch: (error) => 'Passwords must match'.tr,
        ValidationMessage.pattern: (error) => 'Phone must start with 0'.tr,
      },
      child: GetMaterialApp(
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
      ),
    );
  }
}
