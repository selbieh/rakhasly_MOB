import 'package:get/get.dart';
import 'package:rakshny/core/services/auth/I_auth_service.dart';
import 'package:rakshny/core/services/auth/auth_service_impl.dart';
import 'package:rakshny/core/services/http_service.dart';
import 'package:rakshny/features/auth/presentation/sign_in_screen.dart';
import 'package:rakshny/features/profile/presentation/profile_page.dart';

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
