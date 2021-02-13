import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/view_models/atr_pre_view_model.dart';
import 'package:app/core/view_models/nav_view_model.dart';
import 'package:app/core/view_models/signin_view_model.dart';
import 'package:app/core/view_models/signout_view_model.dart';
import 'package:app/core/view_models/welcome_view_model.dart';
import 'package:get_it/get_it.dart';

import 'authentication/auth_service.dart';
import 'navigation/nav_service.dart';

final locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<DialogService>(() => DialogService());

  locator.registerFactory<WelcomeViewModel>(() => WelcomeViewModel());
  locator.registerFactory<SignInViewModel>(() => SignInViewModel());
  locator.registerFactory<SignOutViewModel>(() => SignOutViewModel());
  locator.registerFactory<NavigationViewModel>(() => NavigationViewModel());
  locator.registerFactory<AnimalTransportRecordPreViewModel>(
      () => AnimalTransportRecordPreViewModel());
}
