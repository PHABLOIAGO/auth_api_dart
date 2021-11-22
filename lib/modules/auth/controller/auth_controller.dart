import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:auth_api/application/hasura/exceptions/hasura_custom_exceptions.dart';
import 'package:auth_api/entities/auth_user.dart';
import 'package:auth_api/modules/auth/service/i_auth_service.dart';

part 'auth_controller.g.dart';

@Injectable()
class AuthController {
  IAuthService authService;

  AuthController({required this.authService});

  @Route.post('/validate')
  Future<Response> validate(Request request) async {
    // var data = request.headers['Authorization'] ?? '';
    var data = jsonDecode(await request.readAsString());
    try {
      var token = '';
      Map<String, dynamic> headers = data['headers'];
      headers.forEach((key, value) {
        if (key == 'authorization' || key == 'Authorization') {
          token = value;
        }
      });
      if (token.isNotEmpty) {
        var authUser = await authService.validate(token);
        return Response.ok(authUser.toJson());
      } else {
        return Response.ok(AuthUser(x_hasura_role: 'anonymous', x_hasura_is_owner: false, x_Hasura_user_id: '').toJson());
      }
    } on JwtException {
      return Response(HttpStatus.unauthorized);
    } on HasuraCustomExceptions catch (e) {
      return Response(HttpStatus.badRequest, body: "'message': '${e.message}'");
    } catch (e) {
      return Response(HttpStatus.badRequest, body: "'message': 'bad request'");
    }
  }

  @Route.post('/signIn')
  Future<Response> signIn(Request request) async {
    // var data = request.headers['Authorization'] ?? '';
    var data = jsonDecode(await request.readAsString());
    try {
      var token = await authService.signIn(data);
      if (token.isNotEmpty) {
        return Response(HttpStatus.created, body: '{\"accessToken\": \"$token\"}');
      } else {
        return Response(HttpStatus.unauthorized, body: '{\"message\": \"Not autenticated\"}');
      }
    } on JwtException {
      return Response(HttpStatus.unauthorized);
    } on HasuraCustomExceptions catch (e) {
      return Response(HttpStatus.internalServerError, body: "'message': '${e.message}'");
    } catch (e) {
      return Response(HttpStatus.internalServerError, body: "'message': 'bad request'");
    }
  }

  Router get router => _$AuthControllerRouter(this);
}
