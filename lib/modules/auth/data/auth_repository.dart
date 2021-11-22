import 'dart:convert';
import 'package:auth_api/application/hasura/i_hasura.dart';
import 'package:auth_api/application/helpers/crypt_helper.dart';
import 'package:auth_api/application/logger/i_logger.dart';
import 'package:auth_api/entities/auth_user.dart';
import 'package:auth_api/entities/user.dart';
import 'package:auth_api/modules/auth/data/i_auth_repository.dart';
import 'package:dotenv/dotenv.dart' show env;
import 'package:hasura_connect/hasura_connect.dart';
import 'package:injectable/injectable.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final IHasura hasura;
  final ILogger logger;

  AuthRepository({required this.hasura, required this.logger});

  @override
  Future<AuthUser> validate(String token) async {
    try {
      final JWT_TOKEN = env['JWT_SECRET'];
      // final typeToken = token.split(' ')[0];
      final hash = token.split(' ')[1];
      final decClaimSet = verifyJwtHS256Signature(hash, JWT_TOKEN ?? '');
      return AuthUser.fromMap(decClaimSet.toJson());
    } on JwtException catch (e) {
      print(e);
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<String> signIn({required String username, required String password}) async {
    late final HasuraConnect? conn;
    var token = '';
    try {
      conn = hasura.connect();
      final query = r'''
        query MyQuery($login: String!) {
          users(where: {active: {_eq: true}, login: {_eq: $login}}) {               
            id
            login
            name
            password
            role
            updated_at
            created_at
            active
          }
        }
      ''';
      var response = await conn.query(query, variables: {'login': username});
      var user = User.fromJson(jsonEncode(response['data']['users'][0]));
      if (CryptHelper.checkPass(user.password ?? '', password)) {
        var authUser = AuthUser(x_hasura_is_owner: false, x_hasura_role: user.role!, x_Hasura_user_id: user.id!);
        var claims = JwtClaim(otherClaims: authUser.toMap());
        token = issueJwtHS256(claims, env['JWT_SECRET']!);
      }
      return token;
    } on DatasourceError catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      await conn?.dispose();
    }
  }
}
