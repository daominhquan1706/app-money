import 'package:get_it/get_it.dart';
import 'package:money_app/services/api_service.dart';
import 'package:money_app/services/shared_preference_service.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:money_app/view_models/login_viewmodel.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = GetIt.instance;

void setupGetIt() {
  locator.registerLazySingleton<SharedPreferenceService>(
      () => SharedPreferenceService());
  locator.registerLazySingleton<ApiService>(() => ApiService());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<DialogService>(() => DialogService());
  locator.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
  locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  locator.registerLazySingleton<RecordCreateViewModel>(
      () => RecordCreateViewModel());
}
