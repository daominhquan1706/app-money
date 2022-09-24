import 'package:moneylover/biz/app_controller.dart';
import 'package:moneylover/pages/auth/login/controller.dart';
import 'package:moneylover/pages/auth/login/page.dart';
import 'package:moneylover/pages/splash/page.dart';
import 'package:moneylover/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class RefreshUserDataMiddleware extends GetMiddleware {
  RefreshUserDataMiddleware({int priority = 10}) : super(priority: priority);

  @override
  Widget onPageBuilt(Widget page) {
    if (Get.find<IApiService>()?.isAuthorized() == true) {
      Get.find<AppController>().refreshUserData();
    }
    return super.onPageBuilt(page);
  }
}

abstract class AppPages {
  static final pages = [
    GetPage(
      // middlewares: const [],
      name: Routes.splash,
      transition: Transition.fadeIn,
      page: () => const SplashPage(),
      bindings: const [
        // BindingsBuilder(() => Get.put<SplashController>(SplashController())),
      ],
    ),
    GetPage(
      // middlewares: const [],
      name: Routes.login,
      page: () => const LoginPage(),
      bindings: [
        BindingsBuilder(() => Get.put<LoginController>(LoginController())),
      ],
    ),
  ];
}
