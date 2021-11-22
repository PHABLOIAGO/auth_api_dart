import 'dart:io';

import 'package:auth_api/application/middlewares/middlewares.dart';
import 'package:shelf/src/response.dart';
import 'package:shelf/src/request.dart';
import 'package:dotenv/dotenv.dart' show env;

class Security extends Middlewares {
  @override
  Future<Response> execute(Request request) async {
    if (request.url.path != 'auth/validate') {
      if (request.headers['API-TOKEN'] != env['TOKEN_AUTH']) {
        return Response(HttpStatus.unauthorized);
      }
    }
    final response = await innerHandler(request);

    return response;
  }
}
