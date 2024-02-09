import 'package:rakshny/core/models/app_failure.dart';
import 'package:either_dart/either.dart';
import 'package:rakshny/core/models/user.dart';

abstract class AuthService {
  User? get user;

  bool isLoggedIn = false;

  Future<Either<Failure, dynamic>> login({required Map<String, dynamic> body});

  Future<Either<Failure, dynamic>> updateAccount(
      {required int id, required Map<String, dynamic> body});

  Future<bool> saveUser({required User user});

  Future<User?> loadUser();

  Future forgetPassword({required Map<String, dynamic> body});

  Future<bool> isAuthiticatedUser();

  Future<bool> removeUser();
}
