import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF6C4CF1);
  static const secondary = Color(0xFF9B6BFF);
  static const text = Color(0xFF1E1B39);
  static const grey = Color(0xFF8A8AA0);
  static const field = Color(0xFFF4F3FB);
  static const error = Color(0xFFE5484D);
  static const success = Color(0xFF2EB67D);
  static const gradient = LinearGradient(colors: [primary, secondary]);
}

final emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

String? validateEmail(String v) {
  if (v.trim().isEmpty) return 'El correo es obligatorio';
  if (!emailRegex.hasMatch(v.trim())) {
    return 'Correo no válido (ej: usuario@dominio.com)';
  }
  return null;
}

void showMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(msg)));
}
