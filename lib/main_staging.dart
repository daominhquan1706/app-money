import 'package:moneylover/envs/staging_env.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.STAGING;
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then(
    (value) {
      runApp(
        App(
          env: StagingEnviroment(),
        ),
      );
    },
  );
}
