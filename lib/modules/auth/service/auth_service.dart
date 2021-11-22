import 'dart:developer';

import 'package:auth_api/entities/auth_user.dart';
import 'package:auth_api/modules/auth/data/i_auth_repository.dart';
import 'package:auth_api/modules/auth/service/i_auth_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthService)
class AuthService implements IAuthService {
  IAuthRepository authRepository;

  AuthService({
    required this.authRepository,
  });

  @override
  Future<String> signIn(Map<String, dynamic> credentials) async {
    try {
      String username = credentials['input']['username'];
      String password = credentials['input']['password'];
      var result = await authRepository.signIn(username: username, password: password);
      return result;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<AuthUser> validate(String token) {
    return authRepository.validate(token);
  }
}
