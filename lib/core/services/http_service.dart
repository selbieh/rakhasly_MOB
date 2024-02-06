import 'package:get/get.dart';

class HttpService extends GetConnect {
  Future<Response> login(body) =>
      post('https://amrtarkhan.pythonanywhere.com/auth/login/', body);
}
