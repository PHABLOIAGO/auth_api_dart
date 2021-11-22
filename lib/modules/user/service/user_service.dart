import 'package:auth_api/entities/user.dart';
import 'package:auth_api/modules/user/data/i_user_repository.dart';
import 'package:auth_api/modules/user/service/i_user_service.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserService)
class UserService implements IUserService {
  IUserRepository userRepository;

  UserService({
    required this.userRepository,
  });

  @override
  Future<User> createUser(Map<String, dynamic> user) async {
    final User userEntity = User.fromMap(user);
    var result = await userRepository.createUser(userEntity);
    return result;
  }
}
