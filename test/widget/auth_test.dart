import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pondok207/screen/auth/auth_view_model.dart';
import 'package:pondok207/screen/auth/login_screen.dart';
import 'package:pondok207/screen/auth/register_screen.dart';
import 'package:provider/provider.dart';

Widget _createLoginScreen() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthViewModel(),
      ),
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
  );
}

Widget _createRegisterScreen() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthViewModel(),
      ),
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
    ),
  );
}

void main() {
  AuthViewModel viewModel = AuthViewModel();
  BuildContext? context;
  group('Login Screen Tests', () {
    testWidgets('Testing TextField', (WidgetTester tester) async {
      await tester.pumpWidget(_createLoginScreen());
      await tester.enterText(
          find.byKey(const ValueKey('email')), 'mega@gmail.com');
      await tester.enterText(
          find.byKey(const ValueKey('password')), 'mega1234');
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Find Text Daftar', (WidgetTester tester) async {
      await tester.pumpWidget(_createLoginScreen());
      expect(find.text('Belum punya akun? daftar disini'), findsOneWidget);
    });

    testWidgets('Find Icon Button', (WidgetTester tester) async {
      await tester.pumpWidget(_createLoginScreen());
      expect(find.byType(IconButton), findsOneWidget);
    });
  });

  group('Register Screen Tests', () {
    testWidgets('Testing TextField', (WidgetTester tester) async {
      await tester.pumpWidget(_createRegisterScreen());
      await tester.enterText(
          find.byKey(const ValueKey('name')), 'Fahlevi Dwi Yauma Hadid');
      await tester.enterText(
          find.byKey(const ValueKey('email')), 'lepi@gmail.com');
      await tester.enterText(
          find.byKey(const ValueKey('password')), 'lepi1234');
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Find Text Punya akun', (WidgetTester tester) async {
      await tester.pumpWidget(_createRegisterScreen());
      expect(find.text('Sudah punya akun? masuk disini'), findsOneWidget);
    });
  });
}
