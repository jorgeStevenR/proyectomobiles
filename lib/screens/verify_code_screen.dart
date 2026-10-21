import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  List<TextEditingController> casillas = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  List<FocusNode> focos = [FocusNode(), FocusNode(), FocusNode(), FocusNode()];
  Timer? temporizador;
  int segundos = 45;

  @override
  void initState() {
    super.initState();
    iniciarContador();
  }

  void iniciarContador() {
    temporizador?.cancel();
    segundos = 45;
    setState(() {});
    temporizador = Timer.periodic(Duration(seconds: 1), (t) {
      if (segundos == 0) {
        t.cancel();
      } else {
        segundos--;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    temporizador?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime ahora = DateTime.now();
    String hora = "${ahora.hour.toString().padLeft(2, '0')}:${ahora.minute.toString().padLeft(2, '0')}";
    String correo = ModalRoute.of(context)?.settings.arguments as String? ?? "";
    String tiempo = "00:${segundos.toString().padLeft(2, '0')}";
    bool completo = casillas[0].text.length == 1 &&
        casillas[1].text.length == 1 &&
        casillas[2].text.length == 1 &&
        casillas[3].text.length == 1;

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
                            SizedBox(height: 16),
                            Text(
                              "Código de verificación",
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E1B39)),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Enviamos un código de 4 dígitos a $correo",
                              style: TextStyle(fontSize: 15, color: Color(0xFF8A8AA0)),
                            ),
                            SizedBox(height: 28),
                            // Las 4 casillas del código
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(4, (i) {
                                return SizedBox(
                                  width: 64,
                                  height: 64,
                                  child: Focus(
                                    // Si la casilla ya está vacía y se presiona borrar, vuelve a la anterior
                                    canRequestFocus: false,
                                    onKeyEvent: (_, evento) {
                                      if (evento is KeyDownEvent &&
                                          evento.logicalKey == LogicalKeyboardKey.backspace &&
                                          casillas[i].text.isEmpty &&
                                          i > 0) {
                                        casillas[i - 1].clear();
                                        focos[i - 1].requestFocus();
                                        setState(() {});
                                        return KeyEventResult.handled;
                                      }
                                      return KeyEventResult.ignored;
                                    },
                                    child: TextField(
                                      controller: casillas[i],
                                      focusNode: focos[i],
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                      onChanged: (valor) {
                                        if (valor.isNotEmpty && i < 3) {
                                          focos[i + 1].requestFocus();
                                        }
                                        if (valor.isEmpty && i > 0) {
                                          focos[i - 1].requestFocus();
                                        }
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        counterText: "",
                                        filled: true,
                                        fillColor: Color(0xFFF4F3FB),
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
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 24),
                            Center(
                              child: segundos > 0
                                  ? Text("Reenviar código en $tiempo", style: TextStyle(color: Color(0xFF8A8AA0)))
                                  : TextButton(
                                      onPressed: () {
                                        iniciarContador();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Código reenviado a $correo")),
                                        );
                                      },
                                      child: Text(
                                        "Reenviar código",
                                        style: TextStyle(color: Color(0xFF6C4CF1), fontWeight: FontWeight.bold),
                                      ),
                                    ),
                            ),
                            SizedBox(height: 24),
                            // Botón principal: se ve deshabilitado hasta completar los 4 dígitos
                            Opacity(
                              opacity: completo ? 1 : 0.5,
                              child: Container(
                                height: 54,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [Color(0xFF6C4CF1), Color(0xFF9B6BFF)]),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    if (completo) {
                                      Navigator.pushNamed(context, "/new-password");
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Completa los 4 dígitos")),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Verificar",
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
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
