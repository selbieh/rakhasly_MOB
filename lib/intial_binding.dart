import 'package:get/get.dart';
import 'package:rakshly/core/services/auth/I_auth_service.dart';
import 'package:rakshly/core/services/auth/auth_service_impl.dart';
import 'package:rakshly/core/services/http_service.dart';
import 'package:rakshly/features/auth/presentation/sign_in_screen.dart';
import 'package:rakshly/features/profile/presentation/profile_page.dart';

class RakhslyBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.put(HttpService(), permanent: true);
    Get.put<AuthService>(AuthServiceImpl(api: Get.find()), permanent: true);
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => ProfileController());
  }
}
