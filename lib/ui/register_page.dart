import 'package:flutter/material.dart';
import 'package:money_app/view_models/login_viewmodel.dart';

class RegisterPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final TextEditingController _passwordTEC = TextEditingController();
  final TextEditingController _userNameTEC = TextEditingController();
  final LoginViewModel viewModel = LoginViewModel().instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Register page"),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: TextFormField(
                controller: _userNameTEC,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: TextFormField(
                controller: _passwordTEC,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
              ),
            ),
            expandButton(
              text: "Register",
              onPressed: () {
                onRegister();
              },
            ),
            flatButton(
              text: "Login",
              onPressed: () {
                onLogin();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget expandButton({String text, VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text ?? ""),
      ),
    );
  }

  Widget flatButton({String text, VoidCallback onPressed}) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.blue,
      minimumSize: const Size(88, 44),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      backgroundColor: Colors.transparent,
    );
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        style: flatButtonStyle,
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  void onRegister() {
    viewModel.register(
        username: _userNameTEC.text, password: _passwordTEC.text);
  }

  void onLogin() {
    viewModel.state = AuthPageType.login;
  }
}
