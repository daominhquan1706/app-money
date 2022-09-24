import 'package:moneylover/pages/auth/user_auth_controller.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:moneylover/biz/app_notification_controller.dart';
import 'package:moneylover/biz/lifecycle_controller.dart';
import 'package:moneylover/envs/base.dart';
import 'package:moneylover/language/localization_service.dart';

import 'biz/app_controller.dart';
import 'biz/app_repository.dart';
import 'routes/app_pages.dart';
import 'services/api_connector.dart';
import 'services/api_service.dart';
import 'theme/theme_data.dart';

class App extends StatelessWidget {
  final IEnviroment env;

  const App({Key key, @required this.env}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: SuntecThemeData.themeData,
      getPages: AppPages.pages,
      navigatorObservers: [
        SuntecNavigatorObserver(),
      ],
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      initialBinding: AppBindings(env),
      builder: EasyLoading.init(
        builder: _builder,
      ),
      defaultTransition: kIsWeb ? Transition.noTransition : Transition.native,
      initialRoute: Routes.splash,
      routingCallback: (route) {},
    );
  }

  Widget _builder(BuildContext context, Widget child) {
    // Lock os font scale up
    double textScale = 1.0;
    // if (context.width > 600.0) {
    //   textScale = 1.1;
    // }
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: textScale),
      child: child,
    );
  }
}

class AppBindings extends Bindings {
  final IEnviroment env;
  AppBindings(this.env);

  @override
  void dependencies() {
    Get.put<IEnviroment>(env, permanent: true);
    Get.put<GetConnect>(ApiConnector(env: Get.find()), permanent: true);
    Get.put<IApiService>(ApiService(connector: Get.find()), permanent: true);
    Get.lazyPut<IAppRepository>(() => AppRepository(), fenix: true);
    Get.put(AppController(env: env));
    Get.put(AppNotificationController());
    Get.put(LifeCycleController());
    Get.put(UserAuthController());
  }
}
