import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RecoverScreen extends StatefulWidget {
  const RecoverScreen({super.key});

  @override
  State<RecoverScreen> createState() => _RecoverScreenState();
}

class _RecoverScreenState extends State<RecoverScreen> {
  TextEditingController correo = TextEditingController();
  String? errorCorreo;

  void enviarCodigo() {
    if (correo.text.trim().isEmpty) {
      errorCorreo = "El correo es obligatorio";
    } else if (!RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$').hasMatch(correo.text.trim())) {
      errorCorreo = "Correo no válido (ej: usuario@dominio.com)";
    } else {
      errorCorreo = null;
    }
    setState(() {});

    if (errorCorreo == null) {
      Navigator.pushNamed(context, "/verify", arguments: correo.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime ahora = DateTime.now();
    String hora = "${ahora.hour.toString().padLeft(2, '0')}:${ahora.minute.toString().padLeft(2, '0')}";

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Formas decorativas del fondo
          Positioned(
            top: -60,
            right: -50,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6C4CF1).withValues(alpha: 0.18),
                    Color(0xFF9B6BFF).withValues(alpha: 0.18),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: -30,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFF9B6BFF).withValues(alpha: 0.3), width: 8),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6C4CF1).withValues(alpha: 0.12),
                    Color(0xFF9B6BFF).withValues(alpha: 0.12),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            right: 24,
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Color(0xFF6C4CF1).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 120,
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Color(0xFF6C4CF1).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Barra de estado: en el celular ya se ve la del sistema, en web se dibuja
                kIsWeb
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(24, 8, 24, 0),
                        child: Row(
                          children: [
                            Text(hora, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E1B39))),
                            Spacer(),
                            Icon(Icons.signal_cellular_alt, size: 16, color: Color(0xFF1E1B39)),
                            SizedBox(width: 4),
                            Icon(Icons.wifi, size: 16, color: Color(0xFF1E1B39)),
                            SizedBox(width: 4),
                            Icon(Icons.battery_full, size: 16, color: Color(0xFF1E1B39)),
                          ],
                        ),
                      )
                    : SizedBox(),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 420),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton.filledTonal(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back_ios_new, size: 18),
                              ),
                            ),
                            SizedBox(height: 24),
                            Center(
                              child: Container(
                                width: 88,
                                height: 88,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF4F3FB),
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: Icon(Icons.lock_reset, color: Color(0xFF6C4CF1), size: 44),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Recuperar contraseña",
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E1B39)),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Ingresa el correo asociado a tu cuenta y te enviaremos un código de verificación.",
                              style: TextStyle(fontSize: 15, color: Color(0xFF8A8AA0)),
                            ),
                            SizedBox(height: 28),
                            TextField(
                              controller: correo,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Correo electrónico",
                                errorText: errorCorreo,
                                filled: true,
                                fillColor: Color(0xFFF4F3FB),
                                prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF8A8AA0)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(color: Color(0xFF6C4CF1), width: 1.5),
                                ),
                              ),
                            ),
                            SizedBox(height: 22),
                            Container(
                              height: 54,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [Color(0xFF6C4CF1), Color(0xFF9B6BFF)]),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: TextButton(
                                onPressed: enviarCodigo,
                                child: Text(
                                  "Enviar código",
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text("¿La recordaste?", style: TextStyle(color: Color(0xFF8A8AA0))),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Inicia sesión",
                                    style: TextStyle(color: Color(0xFF6C4CF1), fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
