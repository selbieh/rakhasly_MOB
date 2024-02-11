import 'package:get/get.dart';
import 'package:rakshly/core/models/user.dart';
import 'package:rakshly/core/services/auth/I_auth_service.dart';

class HomeController extends GetxController {
  User? user;

  @override
  void onInit() async {
    super.onInit();
    if (Get.find<AuthService>().isLoggedIn) {
      var auth = Get.find<AuthService>();
      user = auth.user;
    }
  }
}
