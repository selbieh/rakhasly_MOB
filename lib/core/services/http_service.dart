import 'package:get/get.dart';
import 'package:rakshly/core/constants.dart';
import 'package:rakshly/core/services/auth/I_auth_service.dart';

class HttpService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Constants.url;

    httpClient.addRequestModifier<dynamic>((request) {
      final auth = Get.find<AuthService>();
      if (auth.isLoggedIn) {
        request.headers['Authorization'] = "Bearer ${auth.user?.access}";
      }
      return request;
    });
  }

  Future<Response> login(body) => post('/auth/login/', body);

  Future<Response> signUp(body) => post('/auth/registration/', body);

  Future<Response> updateProfile(body) => put('/auth/user/', body);

  Future<Response> forgetPassword(body) => post('/auth/password/reset/', body);

  Future<Response> saveForm(body) => post("/api/v1/car-license/", body);
  Future<Response> saveDriverForm(body) =>
      post("/api/v1/driver-license/", body);

  Future<Response> getGovernmentsLicenseUnits() => get("/api/v1/governorates/");

  getPreviosDrivingLicensesRequest() => get('/api/v1/driver-license');
  getPreviosCarLicensesRequest() => get('/api/v1/car-license');

  rating(body) => post('/api/v1/ratings/', body);
  updateCarLicenseRequest(int id, Map body) =>
      patch('/api/v1/car-license/$id/', body);
  updateDriverLicenseRequest(int id, Map body) =>
      patch('/api/v1/driver-license/$id/', body);
}
