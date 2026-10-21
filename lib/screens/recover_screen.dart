import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/app_button.dart';
import '../widgets/app_input.dart';
import '../widgets/auth_layout.dart';

class RecoverScreen extends StatefulWidget {
  const RecoverScreen({super.key});

  @override
  State<RecoverScreen> createState() => _RecoverScreenState();
}

class _RecoverScreenState extends State<RecoverScreen> {
  final _email = TextEditingController();
  String? _error;

  void _send() {
    setState(() => _error = validateEmail(_email.text));
    if (_error == null) {
      Navigator.pushNamed(context, '/verify', arguments: _email.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      onBack: () => Navigator.pop(context),
      children: [
        const SizedBox(height: 24),
        Center(
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.field,
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(
              Icons.lock_reset,
              color: AppColors.primary,
              size: 44,
            ),
          ),
        ),
        const AuthHeader(
          'Recuperar contraseña',
          'Ingresa el correo asociado a tu cuenta y te enviaremos un código de verificación.',
        ),
        AppInput(
          label: 'Correo electrónico',
          controller: _email,
          icon: Icons.email_outlined,
          keyboard: TextInputType.emailAddress,
          error: _error,
        ),
        const SizedBox(height: 8),
        AppButton(text: 'Enviar código', onPressed: _send),
        AuthFooter(
          '¿La recordaste?',
          'Inicia sesión',
          () => Navigator.pop(context),
        ),
      ],
    );
  }
}
