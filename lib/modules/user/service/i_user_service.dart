import 'package:auth_api/entities/user.dart';

abstract class IUserService {
  Future<User> createUser(Map<String, dynamic> user);
}
