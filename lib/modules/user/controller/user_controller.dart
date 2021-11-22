import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auth_api/application/hasura/exceptions/hasura_custom_exceptions.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:auth_api/modules/user/service/i_user_service.dart';

part 'user_controller.g.dart';

@Injectable()
class UserController {
  IUserService userService;

  UserController({
    required this.userService,
  });

  @Route.post('/create')
  Future<Response> create(Request request) async {
    var data = jsonDecode(await request.readAsString());
    try {
      var savedUser = await userService.createUser(data);
      var sendUser = savedUser.copyWith(password: '');
      return Response.ok(sendUser.toJson());
    } on HasuraCustomExceptions catch (e) {
      return Response(HttpStatus.badRequest, body: "'error': '${e.message}'");
    } catch (e) {
      return Response(HttpStatus.badRequest, body: "'error': 'bad request'");
    }
  }

  Router get router => _$UserControllerRouter(this);
}
