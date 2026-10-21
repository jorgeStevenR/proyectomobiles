import 'package:flutter/material.dart';

import '../theme.dart';

/// Estructura común: fondo con formas decorativas, botón atrás opcional y scroll.
class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, required this.children, this.onBack});

  final List<Widget> children;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(top: -60, right: -50, child: _Bubble(180, 0.18)),
          const Positioned(top: 120, left: -30, child: _Ring(70)),
          const Positioned(bottom: -40, left: -40, child: _Bubble(140, 0.12)),
          const Positioned(bottom: 90, right: 24, child: _Square(28)),
          const Positioned(top: 60, left: 120, child: _Square(14)),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (onBack != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton.filledTonal(
                            onPressed: onBack,
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 18,
                            ),
                          ),
                        ),
                      ...children,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble(this.size, this.opacity);
  final double size, opacity;
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: [
          AppColors.primary.withValues(alpha: opacity),
          AppColors.secondary.withValues(alpha: opacity),
        ],
      ),
    ),
  );
}

class _Ring extends StatelessWidget {
  const _Ring(this.size);
  final double size;
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: AppColors.secondary.withValues(alpha: 0.3),
        width: 8,
      ),
    ),
  );
}

class _Square extends StatelessWidget {
  const _Square(this.size);
  final double size;
  @override
  Widget build(BuildContext context) => Transform.rotate(
    angle: 0.5,
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );
}

/// Título + subtítulo de cada pantalla.
class AuthHeader extends StatelessWidget {
  const AuthHeader(this.title, this.subtitle, {super.key});
  final String title, subtitle;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 15, color: AppColors.grey),
        ),
      ],
    ),
  );
}

/// Pie tipo "¿No tienes cuenta? Regístrate".
class AuthFooter extends StatelessWidget {
  const AuthFooter(this.text, this.link, this.onTap, {super.key});
  final String text, link;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 24),
    child: Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(text, style: const TextStyle(color: AppColors.grey)),
        TextButton(
          onPressed: onTap,
          child: Text(
            link,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
