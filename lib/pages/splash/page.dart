import 'package:moneylover/pages/splash/controller.dart';
import 'package:moneylover/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:moneylover/components/buttonSecondary.dart';
import 'package:get/get.dart';
import '../../font_style.dart';
import '../../components/buttonPrimary.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0, top: 20.0, left: 20.0),
                  child: Text(
                    "Money Lover.io",
                    style: logoText,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 20.0,
                  ),
                ),
                const Image(
                    image: AssetImage('assets/images/moneylover.jpeg'),
                    height: 250),
                const SizedBox(height: 20),
                Text("Dating metaverse for those looking to forge friendships",
                    style: subHeader, textAlign: TextAlign.center),
                const SizedBox(height: 60),
                const ButtonPrimary(
                  text: "Get Started",
                ),
                const SizedBox(height: 13),
                ButtonSecondary(
                  text: "Login",
                  onPress: () {
                    Get.offNamed(Routes.login);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
