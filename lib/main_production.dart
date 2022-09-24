import 'package:moneylover/envs/production_env.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.PRODUCTION;
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then(
    (value) {
      runApp(
        App(
          env: ProductionEnviroment(),
        ),
      );
    },
  );
}
