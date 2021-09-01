import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:money_app/services/dialog_service.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:money_app/ui/login_page.dart';
import 'package:money_app/ui/main_page.dart';
import 'package:money_app/ui/register_page.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:money_app/view_models/login_viewmodel.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setupGetIt();
  configLoading();
  setupDialogUi();
  runApp(MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
            create: (_) => LoginViewModel().instance),
        ChangeNotifierProvider<HomeViewModel>(
            create: (_) => HomeViewModel().instance),
        ChangeNotifierProvider<RecordCreateViewModel>(
            create: (_) => RecordCreateViewModel().instance),
        // ChangeNotifierProvider<HomeViewModel>(
        //     create: (_) => HomeViewModel().instance),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: StackedService.navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: navigateTo(),
        builder: EasyLoading.init(),
      ),
    );
  }

  Widget navigateTo() {
    return Consumer<LoginViewModel>(
      builder: (context, value, child) {
        if (value.isLoggedIn != null && value.isLoggedIn) {
          return const MainPage();
        }
        switch (value.state) {
          case LoginState.login:
            return LoginPage();
          case LoginState.register:
            return RegisterPage();
        }
        return null;
      },
    );
  }
}
