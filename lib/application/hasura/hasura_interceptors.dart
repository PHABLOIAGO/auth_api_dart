import 'package:hasura_connect/hasura_connect.dart';
import 'package:dotenv/dotenv.dart' show env;

class HasuraInterceptors extends Interceptor {
  @override
  Future<void>? onConnected(HasuraConnect connect) {}

  @override
  Future<void>? onDisconnected() {}

  @override
  Future? onError(HasuraError request) async {
    return request;
  }

  @override
  Future<Request> onRequest(Request request) async {
    request.headers['x-hasura-admin-secret'] = env['HASURA_ADMIN_SECRET'] ?? '';
    return request;
  }

  @override
  Future onResponse(Response data) async {
    return data;
  }

  @override
  Future<void>? onSubscription(Request request, Snapshot snapshot) {}

  @override
  Future<void>? onTryAgain(HasuraConnect connect) {}
}
