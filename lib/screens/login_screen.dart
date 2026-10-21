import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/app_button.dart';
import '../widgets/app_input.dart';
import '../widgets/auth_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  String? _emailError, _passError;
  bool _msgShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mensaje de éxito al volver desde "Nueva contraseña".
    final msg = ModalRoute.of(context)?.settings.arguments;
    if (msg is String && !_msgShown) {
      _msgShown = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => showMsg(context, msg),
      );
    }
  }

  void _login() {
    setState(() {
      _emailError = validateEmail(_email.text);
      _passError = _pass.text.isEmpty ? 'La contraseña es obligatoria' : null;
    });
    if (_emailError == null && _passError == null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (_) => false,
        arguments: _email.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      children: [
        const SizedBox(height: 24),
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: AppColors.gradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.lock_outline,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
        const AuthHeader('Bienvenido de nuevo', 'Inicia sesión para continuar'),
        AppInput(
          label: 'Correo electrónico',
          controller: _email,
          icon: Icons.email_outlined,
          keyboard: TextInputType.emailAddress,
          error: _emailError,
        ),
        AppInput(
          label: 'Contraseña',
          controller: _pass,
          icon: Icons.lock_outline,
          password: true,
          error: _passError,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Navigator.pushNamed(context, '/recover'),
            child: const Text(
              '¿Olvidaste tu contraseña?',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(height: 8),
        AppButton(text: 'Iniciar sesión', onPressed: _login),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'o continúa con',
                  style: TextStyle(color: AppColors.grey),
                ),
              ),
              Expanded(child: Divider()),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: 'Google',
                icon: Icons.g_mobiledata,
                primary: false,
                onPressed: () =>
                    showMsg(context, 'Funcionalidad no disponible'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                text: 'Apple',
                icon: Icons.apple,
                primary: false,
                onPressed: () =>
                    showMsg(context, 'Funcionalidad no disponible'),
              ),
            ),
          ],
        ),
        AuthFooter(
          '¿No tienes cuenta?',
          'Regístrate',
          () => Navigator.pushNamed(context, '/register'),
        ),
      ],
    );
  }
}
