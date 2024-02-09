import 'package:get/get.dart';
import 'package:rakshny/core/constants.dart';

class HttpService extends GetConnect {
  Future<Response> login(body) => post('${Constants.url}/auth/login/', body);

  Future<Response> saveForm(body) => post("${Constants.url}/", body);

  Future<Response> getGovernmentsLicenseUnits() =>
      get("${Constants.url}/api/v1/governorates/");
}
