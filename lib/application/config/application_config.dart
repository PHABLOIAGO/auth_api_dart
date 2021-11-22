import 'package:auth_api/application/config/service_locator_config.dart';
import 'package:auth_api/application/logger/i_logger.dart';
import 'package:auth_api/application/logger/logger.dart';
import 'package:auth_api/application/routers/router_configure.dart';
import 'package:dotenv/dotenv.dart' show load;
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

class ApplicationConfig {
  Future<void> loadCOnfigApplication(Router router) async {
    await _loadEnv();
    _configLogger();
    _loadDependencies();
    _loadRoutersConfigure(router);
  }

  Future<void> _loadEnv() async => load();

  void _configLogger() => GetIt.I.registerLazySingleton<ILogger>(() => Logger());

  void _loadDependencies() => configureDependencies();

  void _loadRoutersConfigure(router) => RouterConfigure(router).configure();
}
