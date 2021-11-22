import 'package:auth_api/application/hasura/exceptions/hasura_custom_exceptions.dart';
import 'package:auth_api/application/hasura/i_hasura.dart';
import 'package:auth_api/application/helpers/crypt_helper.dart';
import 'package:auth_api/entities/user.dart';
import 'package:auth_api/modules/user/data/i_user_repository.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  final IHasura hasura;

  UserRepository({required this.hasura});

  @override
  Future<User> createUser(User user) async {
    late final HasuraConnect? conn;
    try {
      conn = hasura.connect();
      user = user.copyWith(password: CryptHelper.cryptPass(user.password!));
      final mutation = r'''
        mutation($user: users_insert_input!){
          insert_users_one(object: $user){
            id
            login
            name
            password
            role
            active
            created_at
            updated_at
          }
        }
       ''';
      var response = await conn.mutation(mutation, variables: {'user': user.toMapSave()});
      print(response['data']['insert_users_one']);
      return User.fromMap(response['data']['insert_users_one']);
    } on HasuraRequestError catch (e) {
      print(e);
      throw HasuraCustomExceptions(e.message, e.request);
    } finally {
      await conn?.dispose();
    }
  }
}
