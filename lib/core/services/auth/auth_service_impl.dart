import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rakshny/core/models/app_failure.dart';
import 'package:rakshny/core/models/user.dart';
import 'package:rakshny/core/services/auth/I_auth_service.dart';
import 'package:rakshny/core/services/http_service.dart';

class AuthServiceImpl implements AuthService {
  HttpService api;
  AuthServiceImpl({required this.api});

  User? _userModel;

  @override
  User? get user => _userModel;

  @override
  bool get isLoggedIn => user != null;

  final box = GetStorage();

  // bool get isLogged =>
  //     SharedPref.getBool(PrefKeys.isUserLoggedIn) ?? false == true;

  @override
  Future<bool> saveUser({required User user}) async {
    try {
      // await SharedPref.setString(PrefKeys.userData, json.encode(user.toJson()));
      // await SharedPref.setString(
      // PrefKeys.token, user.token ?? "USER_TOKEN_NOT_FOUND");
      // await SharedPref.setBool(PrefKeys.isUserLoggedIn, true);
      await box.write('user', user.toJson());
      await box.write('isLogged', true);

      _userModel = user;
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<User?> loadUser() async {
    try {
      if (box.hasData('user')) {
        debugPrint("Load User Method");
        _userModel = User.fromJson(box.read('user'));
        return user;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  @override
  Future<bool> isAuthiticatedUser() async {
    try {
      if (box.hasData('isLogged')) {
        debugPrint("IS AUTHINTICATED USER");
        return box.read<bool>('isLogged') ?? false;
      } else {
        return false;
      }
    } catch (error) {
      // await SharedPref.clear();
      return false;
    }
  }

  @override
  Future<bool> removeUser() async {
    try {
      await box.erase();
      _userModel = null;
      return true;
    } catch (error) {
      return false;
    }
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
      return Left(Failure(message: res.bodyString ?? "Error in login".tr));
    }
  }

  @override
  set isLoggedIn(bool logged) {
    logged = true;
  }

  @override
  Future forgetPassword({required Map<String, dynamic> body}) async {
    var res = await api.forgetPassword(body);
    if (res.statusCode == 200) {
      return Right(res.body);
    } else {
      return Left(
          Failure(message: res.bodyString ?? "Error in forget password".tr));
    }
  }

  @override
  Future<Either<Failure, dynamic>> signUp(
      {required Map<String, dynamic> body}) async {
    var res = await api.signUp(body);
    if (res.statusCode == 201) {
      return Right(res.body);
    } else {
      return Left(Failure(message: res.bodyString ?? "Error in signUp".tr));
    }
  }
}
