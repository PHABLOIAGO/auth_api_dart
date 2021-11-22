import 'package:auth_api/application/hasura/i_hasura.dart';
import 'package:dotenv/dotenv.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:injectable/injectable.dart';

import 'hasura_interceptors.dart';
import 'package:dotenv/dotenv.dart' show env;

@LazySingleton(as: IHasura)
class Hasura implements IHasura {
  
  @override
  HasuraConnect connect() {
    var URL_BASE = env['HASURA_URL']!;
    var tokenInterceptor = HasuraInterceptors();
    HasuraConnect connect;
    try {
      connect = HasuraConnect(URL_BASE, interceptors: [tokenInterceptor]);
    } catch (e) {
      rethrow;
    }
    return connect;
  }
}
