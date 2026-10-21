import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/app_button.dart';
import '../widgets/app_input.dart';
import '../widgets/auth_layout.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _pass = TextEditingController();
  final _confirm = TextEditingController();

  bool get _hasLength => _pass.text.length >= 8;
  bool get _hasUpper => _pass.text.contains(RegExp(r'[A-Z]'));
  bool get _hasNumber => _pass.text.contains(RegExp(r'[0-9]'));
  bool get _matches => _pass.text.isNotEmpty && _pass.text == _confirm.text;
  bool get _valid => _hasLength && _hasUpper && _hasNumber && _matches;

  void _save() {
    if (!_valid) {
      showMsg(
        context,
        _matches
            ? 'Cumple todos los requisitos'
            : 'Las contraseñas no coinciden',
      );
      return;
    }
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (_) => false,
      arguments: 'Contraseña actualizada con éxito',
    );
  }

  Widget _requirement(String text, bool ok) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Icon(
          ok ? Icons.check_circle : Icons.radio_button_unchecked,
          color: ok ? AppColors.success : AppColors.grey,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: ok ? AppColors.success : AppColors.grey),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      children: [
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified, color: AppColors.success, size: 16),
                SizedBox(width: 6),
                Text(
                  'Código verificado',
                  style: TextStyle(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const AuthHeader(
          'Nueva contraseña',
          'Crea una contraseña segura para tu cuenta',
        ),
        AppInput(
          label: 'Nueva contraseña',
          controller: _pass,
          icon: Icons.lock_outline,
          password: true,
          onChanged: (_) => setState(() {}),
        ),
        AppInput(
          label: 'Confirmar contraseña',
          controller: _confirm,
          icon: Icons.lock_outline,
          password: true,
          onChanged: (_) => setState(() {}),
          error: _confirm.text.isNotEmpty && !_matches
              ? 'Las contraseñas no coinciden'
              : null,
        ),
        _requirement('Mínimo 8 caracteres', _hasLength),
        _requirement('Una letra mayúscula', _hasUpper),
        _requirement('Un número', _hasNumber),
        const SizedBox(height: 16),
        AppButton(
          text: 'Guardar contraseña',
          enabled: _valid,
          onPressed: _save,
        ),
      ],
    );
  }
}
