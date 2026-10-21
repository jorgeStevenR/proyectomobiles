import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmar = TextEditingController();
  String? errorNombre;
  String? errorCorreo;
  String? errorPassword;
  String? errorConfirmar;
  bool aceptaTerminos = false;
  bool ocultarPassword = true;
  bool ocultarConfirmar = true;

  void crearCuenta() {
    if (aceptaTerminos == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Debes aceptar los términos y condiciones")),
      );
      return;
    }

    if (nombre.text.trim().isEmpty) {
      errorNombre = "El nombre es obligatorio";
    } else {
      errorNombre = null;
    }

    if (correo.text.trim().isEmpty) {
      errorCorreo = "El correo es obligatorio";
    } else if (!RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$').hasMatch(correo.text.trim())) {
      errorCorreo = "Correo no válido (ej: usuario@dominio.com)";
    } else {
      errorCorreo = null;
    }

    if (password.text.isEmpty) {
      errorPassword = "La contraseña es obligatoria";
    } else {
      errorPassword = null;
    }

    if (confirmar.text.isEmpty) {
      errorConfirmar = "Confirma tu contraseña";
    } else if (confirmar.text != password.text) {
      errorConfirmar = "Las contraseñas no coinciden";
    } else {
      errorConfirmar = null;
    }
    setState(() {});

    if (errorNombre == null && errorCorreo == null && errorPassword == null && errorConfirmar == null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/home",
        (_) => false,
        arguments: correo.text.trim(),
      );
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
                            SizedBox(height: 16),
                            Text(
                              "Crea tu cuenta",
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E1B39)),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Completa tus datos para registrarte",
                              style: TextStyle(fontSize: 15, color: Color(0xFF8A8AA0)),
                            ),
                            SizedBox(height: 28),
                            TextField(
                              controller: nombre,
                              decoration: InputDecoration(
                                hintText: "Nombre completo",
                                errorText: errorNombre,
                                filled: true,
                                fillColor: Color(0xFFF4F3FB),
                                prefixIcon: Icon(Icons.person_outline, color: Color(0xFF8A8AA0)),
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
                            SizedBox(height: 14),
                            TextField(
                              controller: password,
                              obscureText: ocultarPassword,
                              decoration: InputDecoration(
                                hintText: "Contraseña",
                                errorText: errorPassword,
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
                              decoration: InputDecoration(
                                hintText: "Confirmar contraseña",
                                errorText: errorConfirmar,
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
                            Row(
                              children: [
                                Checkbox(
                                  value: aceptaTerminos,
                                  activeColor: Color(0xFF6C4CF1),
                                  onChanged: (valor) {
                                    aceptaTerminos = valor ?? false;
                                    setState(() {});
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    "Acepto los términos y condiciones",
                                    style: TextStyle(color: Color(0xFF8A8AA0)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            // Botón principal: se ve deshabilitado si no acepta los términos
                            Opacity(
                              opacity: aceptaTerminos ? 1 : 0.5,
                              child: Container(
                                height: 54,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [Color(0xFF6C4CF1), Color(0xFF9B6BFF)]),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: TextButton(
                                  onPressed: crearCuenta,
                                  child: Text(
                                    "Crear cuenta",
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text("¿Ya tienes cuenta?", style: TextStyle(color: Color(0xFF8A8AA0))),
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
