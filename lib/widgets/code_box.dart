import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';

/// Casilla de un dígito para el código de verificación.
class CodeBox extends StatelessWidget {
  const CodeBox({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.onBackspaceEmpty,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  /// Se llama al presionar borrar con la casilla ya vacía.
  final VoidCallback? onBackspaceEmpty;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: Focus(
        // Escucha la tecla borrar antes que el TextField.
        canRequestFocus: false,
        onKeyEvent: (_, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              controller.text.isEmpty) {
            onBackspaceEmpty?.call();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: AppColors.field,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
