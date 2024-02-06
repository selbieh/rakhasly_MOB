import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:rakshny/core/models/app_failure.dart';
import 'package:rakshny/core/services/auth/I_auth_service.dart';
import 'package:rakshny/core/services/http_service.dart';

class AuthServiceImpl implements AuthService {
  HttpService api;
  AuthServiceImpl({required this.api});

  dynamic? _userModel;
  dynamic? get userModel => _userModel;

  // bool get isLogged =>
  //     SharedPref.getBool(PrefKeys.isUserLoggedIn) ?? false == true;

  Future<bool> saveUser({required dynamic user}) async {
    try {
      // await SharedPref.setString(PrefKeys.userData, json.encode(user.toJson()));
      // await SharedPref.setString(
      // PrefKeys.token, user.token ?? "USER_TOKEN_NOT_FOUND");
      // await SharedPref.setBool(PrefKeys.isUserLoggedIn, true);
      _userModel = user;
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> loadUser() async {
    try {
      // Map<String, dynamic> userMap =
      // json.decode(SharedPref.getString(PrefKeys.userData)!);
      // _userModel = UserModel.fromJson(userMap);
      // Logger().i(_userModel);
      // notifyListeners();
      return true;
    } catch (error) {
      // await SharedPref.clear();
      return false;
    }
  }

  Future<bool> removeUser() async {
    try {
      // await SharedPref.remove(PrefKeys.userData);
      // await SharedPref.remove(PrefKeys.token);
      // await SharedPref.remove(PrefKeys.fcmToken);
      // await SharedPref.setBool(PrefKeys.isUserLoggedIn, false);
      _userModel = null;
      // notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<Either<Failure, dynamic>> loginByPhone(
      {required Map<String, dynamic> body}) async {
    // final res = await api.request(
    //   EndPoints.loginByPhone,
    //   type: RequestType.post,
    //   body: body,
    //   // headers: Header.clientAuth,
    // );
    // return res;
    var res = Future.value(Left(Failure(message: "test")));
    return res;
  }

  @override
  Future<Either<Failure, dynamic>> verifyAccount(
      {required Map<String, dynamic> body}) async {
    // final res = await api.request(
    //   EndPoints.verifyAccount,
    //   type: RequestType.post,
    //   body: body,
    //   // headers: Header.clientAuth,
    // );
    var res = Future.value(Left(Failure(message: "test")));
    return res;
  }

  @override
  Future<Either<Failure, dynamic>> updateAccount({
    required int id,
    required Map<String, dynamic> body,
  }) async {
    // final res = await api.request(
    //   "${EndPoints.user}/$id",
    //   type: RequestType.put,
    //   body: body,
    //   headers: Header.userHeader,
    // );
    var res = Future.value(Left(Failure(message: "test")));
    return res;
  }

  @override
  Future<Either<Failure, dynamic>> login(
      {required Map<String, dynamic> body}) async {
    var res = await api.login(body);
    if (res.statusCode == 200) {
      return Right(res.body);
    } else {
      return Left(Failure(message: res.bodyString ?? "Error in login"));
    }
  }
}
