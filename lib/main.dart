import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:money_app/services/dialog_service.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:money_app/ui/loading_screen.dart';
import 'package:money_app/ui/login_page.dart';
import 'package:money_app/ui/main_page.dart';
import 'package:money_app/ui/splash_screen.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:money_app/view_models/login_viewmodel.dart';
import 'package:money_app/view_models/record_create_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  configLoading();
  setupDialogUi();
  Intl.defaultLocale = 'vi';
  initializeDateFormatting('vi', null);
  runApp(const App());
}

void configLoading() {
  EasyLoading.instance
    ..userInteractions = true
    ..dismissOnTap = false;
}

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: StackedService.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text("SomethingWentWrong")),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<LoginViewModel>(
                    create: (_) => LoginViewModel().instance),
                ChangeNotifierProvider<HomeViewModel>(
                    create: (_) => HomeViewModel()),
                ChangeNotifierProvider<RecordCreateViewModel>(
                    create: (_) => RecordCreateViewModel()),
              ],
              child: Consumer<LoginViewModel>(
                builder: (context, value, child) {
                  switch (value.authState) {
                    case AuthState.loading:
                      return const LoadingScreen();
                    case AuthState.loggedIn:
                      return const MainPage();
                    case AuthState.notLogin:
                      return LoginPage();
                    default:
                      return null;
                  }
                },
              ),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return SplashScreen();
        },
      ),
      builder: EasyLoading.init(),
    );
  }
}
