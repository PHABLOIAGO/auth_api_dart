import 'package:auth_api/entities/auth_user.dart';

abstract class IAuthRepository {
  Future<String> signIn({required String username, required String password});
  Future<AuthUser> validate(String token);
}
