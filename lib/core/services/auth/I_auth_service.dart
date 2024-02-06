import 'package:rakshny/core/models/app_failure.dart';
import 'package:either_dart/either.dart';

abstract class AuthService {
  Future<Either<Failure, dynamic>> login({required Map<String, dynamic> body});

  Future<Either<Failure, dynamic>> updateAccount(
      {required int id, required Map<String, dynamic> body});

  Future<bool> saveUser({required dynamic user});

  Future<bool> loadUser();

  Future<bool> removeUser();
}
