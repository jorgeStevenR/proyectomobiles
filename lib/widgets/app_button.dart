import 'package:flutter/material.dart';

import '../theme.dart';

/// Botón reutilizable: primario (degradado) o secundario (borde).
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.primary = true,
    this.enabled = true,
    this.icon,
  });

  final String text;
  final VoidCallback onPressed;
  final bool primary;
  final bool enabled;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final color = primary ? Colors.white : AppColors.text;
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          height: 54,
          decoration: BoxDecoration(
            gradient: primary ? AppColors.gradient : null,
            color: primary ? null : Colors.white,
            border: primary ? null : Border.all(color: const Color(0xFFE2E1EC)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: color, size: 22),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: color,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
