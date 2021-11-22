import 'package:auth_api/application/routers/i_router.dart';
import 'package:auth_api/modules/auth/auth_router.dart';
import 'package:auth_api/modules/user/user_router.dart';
import 'package:shelf_router/shelf_router.dart';

class RouterConfigure {
  final Router _router;
  final List<IRouter> _routers = [
    UserRouter(),
    AuthRouter()
  ];

  RouterConfigure(this._router);

  void configure() => _routers.forEach((r) => r.configure(_router));
}
