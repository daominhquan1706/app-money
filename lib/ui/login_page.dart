import 'package:flutter/material.dart';
import 'package:money_app/helper/dialog_helper.dart';
import 'package:money_app/view_models/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            Text(
              viewModel.pageType == AuthPageType.login
                  ? "Đăng nhập"
                  : "Đăng ký",
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: TextFormField(
                key: const ValueKey("username"),
                controller: _userNameTEC,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: TextFormField(
                key: const ValueKey("password"),
                controller: _passwordTEC,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Mật khẩu",
                ),
              ),
            ),
            if (viewModel.pageType == AuthPageType.login) ...[
              expandButton(
                key: const ValueKey("login"),
                text: "Đăng nhập",
                onPressed: () {
                  onLogin();
                },
              ),
              flatButton(
                key: const ValueKey("register"),
                text: "Chưa có tài khoản? Đăng ký",
                onPressed: () {
                  onRegister();
                },
              )
            ] else ...[
              expandButton(
                key: const ValueKey("register"),
                text: "Đăng ký",
                onPressed: () {
                  onRegister();
                },
              ),
              flatButton(
                key: const ValueKey("login"),
                text: "Đã có tài khoản? Đăng nhập",
                onPressed: () {
                  onLogin();
                },
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget expandButton({String text, VoidCallback onPressed, Key key}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        key: key,
        onPressed: onPressed,
        child: Text(text ?? ""),
      ),
    );
  }

  Widget flatButton({String text, VoidCallback onPressed, ValueKey key}) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.blue,
      minimumSize: const Size(88, 44),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      backgroundColor: Colors.transparent,
      alignment: Alignment.centerRight,
    );
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        key: key,
        style: flatButtonStyle,
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  void onRegister() {
    if (viewModel.pageType == AuthPageType.login) {
      viewModel.pageType = AuthPageType.register;
    } else {
      DialogHelper.showLoading();
      viewModel
          .register(username: _userNameTEC.text, password: _passwordTEC.text)
          .then(
        (message) {
          DialogHelper.dismissLoading();
          DialogHelper.showSnackBar(message);
        },
      );
    }
  }

  void onLogin() {
    if (viewModel.pageType == AuthPageType.register) {
      viewModel.pageType = AuthPageType.login;
    } else {
      DialogHelper.showLoading();
      viewModel
          .login(username: _userNameTEC.text, password: _passwordTEC.text)
          .then(
        (message) {
          DialogHelper.dismissLoading();
          DialogHelper.showSnackBar(message);
        },
      );
    }
  }
}
