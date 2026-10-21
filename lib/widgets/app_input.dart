import 'package:flutter/material.dart';

import '../theme.dart';

/// Input reutilizable. Si [password] es true muestra el ojo para ver/ocultar.
class AppInput extends StatefulWidget {
  const AppInput({
    super.key,
    required this.label,
    required this.controller,
    this.icon,
    this.password = false,
    this.error,
    this.keyboard,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final IconData? icon;
  final bool password;
  final String? error;
  final TextInputType? keyboard;
  final ValueChanged<String>? onChanged;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.password && _hidden,
        keyboardType: widget.keyboard,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.label,
          errorText: widget.error,
          filled: true,
          fillColor: AppColors.field,
          prefixIcon: widget.icon == null
              ? null
              : Icon(widget.icon, color: AppColors.grey),
          suffixIcon: widget.password
              ? IconButton(
                  icon: Icon(
                    _hidden ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.grey,
                  ),
                  onPressed: () => setState(() => _hidden = !_hidden),
                )
              : null,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          errorBorder: border.copyWith(
            borderSide: const BorderSide(color: AppColors.error),
          ),
        ),
      ),
    );
  }
}
