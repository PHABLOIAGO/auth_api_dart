import 'package:auth_api/application/routers/i_router.dart';
import 'package:auth_api/modules/user/controller/user_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/src/router.dart';

class UserRouter implements IRouter {
  @override
  void configure(Router router) {
    final userController = GetIt.I.get<UserController>();
    router.mount('/auth/', userController.router);
  }
}
