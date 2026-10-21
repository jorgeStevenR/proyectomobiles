import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmar = TextEditingController();
  bool ocultarPassword = true;
  bool ocultarConfirmar = true;

  @override
  Widget build(BuildContext context) {
    DateTime ahora = DateTime.now();
    String hora = "${ahora.hour.toString().padLeft(2, '0')}:${ahora.minute.toString().padLeft(2, '0')}";

    // Requisitos que se revisan cada vez que el usuario escribe
    bool tieneOcho = password.text.length >= 8;
    bool tieneMayuscula = password.text.contains(RegExp(r'[A-Z]'));
    bool tieneNumero = password.text.contains(RegExp(r'[0-9]'));
    bool coinciden = password.text.isNotEmpty && password.text == confirmar.text;
    bool valido = tieneOcho && tieneMayuscula && tieneNumero && coinciden;

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
                            SizedBox(height: 16),
                            // Etiqueta "Código verificado"
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Color(0xFF2EB67D).withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.verified, color: Color(0xFF2EB67D), size: 16),
                                    SizedBox(width: 6),
                                    Text(
                                      "Código verificado",
                                      style: TextStyle(color: Color(0xFF2EB67D), fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Nueva contraseña",
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E1B39)),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Crea una contraseña segura para tu cuenta",
                              style: TextStyle(fontSize: 15, color: Color(0xFF8A8AA0)),
                            ),
                            SizedBox(height: 28),
                            TextField(
                              controller: password,
                              obscureText: ocultarPassword,
                              onChanged: (valor) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                hintText: "Nueva contraseña",
                                filled: true,
                                fillColor: Color(0xFFF4F3FB),
                                prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF8A8AA0)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    ocultarPassword = !ocultarPassword;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    ocultarPassword ? Icons.visibility_off : Icons.visibility,
                                    color: Color(0xFF8A8AA0),
                                  ),
                                ),
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
                            SizedBox(height: 14),
                            TextField(
                              controller: confirmar,
                              obscureText: ocultarConfirmar,
                              onChanged: (valor) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                hintText: "Confirmar contraseña",
                                errorText: confirmar.text.isNotEmpty && !coinciden ? "Las contraseñas no coinciden" : null,
                                filled: true,
                                fillColor: Color(0xFFF4F3FB),
                                prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF8A8AA0)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    ocultarConfirmar = !ocultarConfirmar;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    ocultarConfirmar ? Icons.visibility_off : Icons.visibility,
                                    color: Color(0xFF8A8AA0),
                                  ),
                                ),
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
                            SizedBox(height: 14),
                            // Lista de requisitos: verde si se cumple, gris si no
                            Row(
                              children: [
                                Icon(
                                  tieneOcho ? Icons.check_circle : Icons.radio_button_unchecked,
                                  color: tieneOcho ? Color(0xFF2EB67D) : Color(0xFF8A8AA0),
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Mínimo 8 caracteres",
                                  style: TextStyle(color: tieneOcho ? Color(0xFF2EB67D) : Color(0xFF8A8AA0)),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  tieneMayuscula ? Icons.check_circle : Icons.radio_button_unchecked,
                                  color: tieneMayuscula ? Color(0xFF2EB67D) : Color(0xFF8A8AA0),
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Una letra mayúscula",
                                  style: TextStyle(color: tieneMayuscula ? Color(0xFF2EB67D) : Color(0xFF8A8AA0)),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  tieneNumero ? Icons.check_circle : Icons.radio_button_unchecked,
                                  color: tieneNumero ? Color(0xFF2EB67D) : Color(0xFF8A8AA0),
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Un número",
                                  style: TextStyle(color: tieneNumero ? Color(0xFF2EB67D) : Color(0xFF8A8AA0)),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            // Botón principal: se ve deshabilitado hasta cumplir todo
                            Opacity(
                              opacity: valido ? 1 : 0.5,
                              child: Container(
                                height: 54,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [Color(0xFF6C4CF1), Color(0xFF9B6BFF)]),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    if (!coinciden) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Las contraseñas no coinciden")),
                                      );
                                    } else if (!valido) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Cumple todos los requisitos")),
                                      );
                                    } else {
                                      // El mensaje se queda visible al llegar al Login
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Contraseña actualizada con éxito")),
                                      );
                                      Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false);
                                    }
                                  },
                                  child: Text(
                                    "Guardar contraseña",
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
