import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/app_button.dart';
import '../widgets/app_input.dart';
import '../widgets/auth_layout.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  bool _terms = false;
  String? _nameError, _emailError, _passError, _confirmError;

  void _register() {
    if (!_terms) {
      showMsg(context, 'Debes aceptar los términos y condiciones');
      return;
    }
    setState(() {
      _nameError = _name.text.trim().isEmpty
          ? 'El nombre es obligatorio'
          : null;
      _emailError = validateEmail(_email.text);
      _passError = _pass.text.isEmpty ? 'La contraseña es obligatoria' : null;
      _confirmError = _confirm.text.isEmpty
          ? 'Confirma tu contraseña'
          : _confirm.text != _pass.text
          ? 'Las contraseñas no coinciden'
          : null;
    });
    if ([
      _nameError,
      _emailError,
      _passError,
      _confirmError,
    ].every((e) => e == null)) {
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
      onBack: () => Navigator.pop(context),
      children: [
        const AuthHeader(
          'Crea tu cuenta',
          'Completa tus datos para registrarte',
        ),
        AppInput(
          label: 'Nombre completo',
          controller: _name,
          icon: Icons.person_outline,
          error: _nameError,
        ),
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
        AppInput(
          label: 'Confirmar contraseña',
          controller: _confirm,
          icon: Icons.lock_outline,
          password: true,
          error: _confirmError,
        ),
        Row(
          children: [
            Checkbox(
              value: _terms,
              activeColor: AppColors.primary,
              onChanged: (v) => setState(() => _terms = v ?? false),
            ),
            const Expanded(
              child: Text(
                'Acepto los términos y condiciones',
                style: TextStyle(color: AppColors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppButton(text: 'Crear cuenta', enabled: _terms, onPressed: _register),
        AuthFooter(
          '¿Ya tienes cuenta?',
          'Inicia sesión',
          () => Navigator.pop(context),
        ),
      ],
    );
  }
}
