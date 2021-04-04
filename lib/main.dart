import 'package:flutter/material.dart';
import 'package:money_app/ui/login_page.dart';
import 'package:money_app/ui/main_page.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:money_app/view_models/login_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginViewModel>(
              create: (_) => LoginViewModel.instance),
          ChangeNotifierProvider<HomeViewModel>(
              create: (_) => HomeViewModel.instance),
        ],
        child: navigateTo(),
      ),
    );
  }

  Widget navigateTo() {
    return Consumer<LoginViewModel>(
      builder: (context, value, child) {
        if (value.isLoggedIn != null && value.isLoggedIn) {
          return const MainPage();
        }
        return LoginPage();
      },
    );
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
