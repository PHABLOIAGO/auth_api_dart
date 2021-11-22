import 'package:auth_api/entities/auth_user.dart';

abstract class IAuthService {
  Future<String> signIn(Map<String, dynamic> credentials);
  Future<AuthUser> validate(String token);
}
