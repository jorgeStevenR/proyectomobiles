import 'dart:async';

import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/app_button.dart';
import '../widgets/auth_layout.dart';
import '../widgets/code_box.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final _controllers = List.generate(4, (_) => TextEditingController());
  final _nodes = List.generate(4, (_) => FocusNode());
  Timer? _timer;
  int _seconds = 45;

  bool get _complete => _controllers.every((c) => c.text.length == 1);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _seconds = 45);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds == 0) {
        t.cancel();
      } else {
        setState(() => _seconds--);
      }
    });
  }

  void _onChanged(int i, String v) {
    if (v.isNotEmpty && i < 3) _nodes[i + 1].requestFocus();
    if (v.isEmpty && i > 0) _nodes[i - 1].requestFocus();
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    final time = '00:${_seconds.toString().padLeft(2, '0')}';
    return AuthLayout(
      onBack: () => Navigator.pop(context),
      children: [
        AuthHeader(
          'Código de verificación',
          'Enviamos un código de 4 dígitos a $email',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (i) => CodeBox(
              controller: _controllers[i],
              focusNode: _nodes[i],
              onChanged: (v) => _onChanged(i, v),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: _seconds > 0
              ? Text(
                  'Reenviar código en $time',
                  style: const TextStyle(color: AppColors.grey),
                )
              : TextButton(
                  onPressed: () {
                    _startTimer();
                    showMsg(context, 'Código reenviado a $email');
                  },
                  child: const Text(
                    'Reenviar código',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 24),
        AppButton(
          text: 'Verificar',
          enabled: _complete,
          onPressed: () => _complete
              ? Navigator.pushNamed(context, '/new-password')
              : showMsg(context, 'Completa los 4 dígitos'),
        ),
      ],
    );
  }
}
