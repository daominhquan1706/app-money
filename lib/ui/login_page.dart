import 'package:flutter/material.dart';
import 'package:money_app/view_models/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Login Page"),
            ElevatedButton(
                onPressed: () {
                  LoginViewModel.instance.login();
                },
                child: Text("Login")),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
