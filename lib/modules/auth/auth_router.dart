import 'package:auth_api/application/routers/i_router.dart';
import 'package:auth_api/modules/auth/controller/auth_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

class AuthRouter implements IRouter {
  @override
  void configure(Router router) {
    final authController = GetIt.I.get<AuthController>();
    router.mount('/auth/', authController.router);
  }
}