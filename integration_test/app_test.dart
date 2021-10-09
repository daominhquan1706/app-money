import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:money_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    //login screen
    final usernameField = find.byKey(const ValueKey('username'));
    final passwordField = find.byKey(const ValueKey('password'));
    final registerButton = find.byKey(const ValueKey('register'));
    final loginButton = find.byKey(const ValueKey('login'));
    final popupMenu = find.byKey(const ValueKey('popupMenu'));
    final signOutButton = find.byKey(const ValueKey('signOut'));

    Future<void> signOutIfNeeded(WidgetTester tester) async {
      await tester.pumpAndSettle();
      if (popupMenu != null) {
        await tester.tap(popupMenu);
        await tester.pumpAndSettle();
        await tester.tap(signOutButton);
      }
    }

    app.main();
    testWidgets('register account', (WidgetTester tester) async {
      await signOutIfNeeded(tester);
      await tester.pumpAndSettle();
      final sec = DateTime.now().toIso8601String();
      await tester.enterText(usernameField, "username$sec@gmail.com");
      await tester.enterText(passwordField, "testPassword");
      await tester.tap(registerButton);
      await tester.pumpAndSettle(const Duration(seconds: 4));
      expect(find.text('Register Success !'), findsOneWidget);
    });

    testWidgets('login', (WidgetTester tester) async {
      await signOutIfNeeded(tester);
      await tester.pumpAndSettle();
      await tester.enterText(usernameField, "quandao012312@gmail.com");
      await tester.enterText(passwordField, "quandao123");
      await tester.tap(registerButton);
      await tester.pumpAndSettle(const Duration(seconds: 4));
      expect(find.text('Register Success !'), findsOneWidget);
    });
  });
}
