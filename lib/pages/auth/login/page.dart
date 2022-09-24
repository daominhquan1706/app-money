import 'package:moneylover/pages/auth/login/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneylover/components/buttonTertiary.dart';
import 'package:moneylover/components/link.dart';
import 'package:moneylover/widgets/loading_button.dart';
import '../../../font_style.dart';
import '../../../components/inputText.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Text(
                    "Money Lover.io",
                    style: logoText,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Image(
                    image: AssetImage('assets/images/login.png'), height: 250),
                InputText(
                  placeholder: "Email Address",
                  controller: controller.emailController,
                  maxLines: 1,
                ),
                InputText(
                  obscureText: true,
                  placeholder: "Password",
                  maxLines: 1,
                  controller: controller.passwordController,
                ),
                const SizedBox(height: 20),
                controller.isLoading.value
                    ? const LoadingButton()
                    : const ButtonTertiary(
                        text: "Login",
                      ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  alignment: Alignment.centerLeft,
                  child: LinkWidget(
                    text: "Forgot Password?",
                    onPress: () {},
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
