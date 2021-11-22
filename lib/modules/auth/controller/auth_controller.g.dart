// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$AuthControllerRouter(AuthController service) {
  final router = Router();
  router.add('POST', r'/validate', service.validate);
  router.add('POST', r'/signIn', service.signIn);
  return router;
}
