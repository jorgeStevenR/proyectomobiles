import 'package:flutter/material.dart';
import 'package:login_registro/screens/home_screen.dart';
import 'package:login_registro/screens/login_screen.dart';
import 'package:login_registro/screens/new_password_screen.dart';
import 'package:login_registro/screens/recover_screen.dart';
import 'package:login_registro/screens/register_screen.dart';
import 'package:login_registro/screens/verify_code_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Color(0xFF6C4CF1)),
      initialRoute: "/login",
      routes: {
        "/login": (_) => LoginScreen(),
        "/register": (_) => RegisterScreen(),
        "/recover": (_) => RecoverScreen(),
        "/verify": (_) => VerifyCodeScreen(),
        "/new-password": (_) => NewPasswordScreen(),
        "/home": (_) => HomeScreen(),
      },
    );
  }
}
