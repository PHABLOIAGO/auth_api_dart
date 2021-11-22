// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/auth/controller/auth_controller.dart' as _i15;
import '../../modules/auth/data/auth_repository.dart' as _i11;
import '../../modules/auth/data/i_auth_repository.dart' as _i10;
import '../../modules/auth/service/auth_service.dart' as _i14;
import '../../modules/auth/service/i_auth_service.dart' as _i13;
import '../../modules/user/controller/user_controller.dart' as _i9;
import '../../modules/user/data/i_user_repository.dart' as _i5;
import '../../modules/user/data/user_repository.dart' as _i6;
import '../../modules/user/service/i_user_service.dart' as _i7;
import '../../modules/user/service/user_service.dart' as _i8;
import '../hasura/hasura.dart' as _i4;
import '../hasura/i_hasura.dart' as _i3;
import '../logger/i_logger.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.IHasura>(() => _i4.Hasura());
  gh.lazySingleton<_i5.IUserRepository>(
      () => _i6.UserRepository(hasura: get<_i3.IHasura>()));
  gh.lazySingleton<_i7.IUserService>(
      () => _i8.UserService(userRepository: get<_i5.IUserRepository>()));
  gh.factory<_i9.UserController>(
      () => _i9.UserController(userService: get<_i7.IUserService>()));
  gh.lazySingleton<_i10.IAuthRepository>(() => _i11.AuthRepository(
      hasura: get<_i3.IHasura>(), logger: get<_i12.ILogger>()));
  gh.lazySingleton<_i13.IAuthService>(
      () => _i14.AuthService(authRepository: get<_i10.IAuthRepository>()));
  gh.factory<_i15.AuthController>(
      () => _i15.AuthController(authService: get<_i13.IAuthService>()));
  return get;
}
