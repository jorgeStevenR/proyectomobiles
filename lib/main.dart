import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/new_password_screen.dart';
import 'screens/recover_screen.dart';
import 'screens/register_screen.dart';
import 'screens/verify_code_screen.dart';
import 'theme.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login y Registro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.primary,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/recover': (_) => const RecoverScreen(),
        '/verify': (_) => const VerifyCodeScreen(),
        '/new-password': (_) => const NewPasswordScreen(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
