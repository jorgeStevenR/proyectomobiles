import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime ahora = DateTime.now();
    String hora = "${ahora.hour.toString().padLeft(2, '0')}:${ahora.minute.toString().padLeft(2, '0')}";
    // Correo que llega desde Login o Registro
    String correo = ModalRoute.of(context)?.settings.arguments as String? ?? "";

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
                            SizedBox(height: 120),
                            // Avatar con la primera letra del correo
                            Center(
                              child: Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(colors: [Color(0xFF6C4CF1), Color(0xFF9B6BFF)]),
                                ),
                                child: Center(
                                  child: Text(
                                    correo.isEmpty ? "?" : correo[0].toUpperCase(),
                                    style: TextStyle(color: Colors.white, fontSize: 44, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              "¡Bienvenido!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E1B39)),
                            ),
                            SizedBox(height: 8),
                            Text(
                              correo,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: Color(0xFF8A8AA0)),
                            ),
                            SizedBox(height: 48),
                            Container(
                              height: 54,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [Color(0xFF6C4CF1), Color(0xFF9B6BFF)]),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: TextButton.icon(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false);
                                },
                                icon: Icon(Icons.logout, color: Colors.white, size: 22),
                                label: Text(
                                  "Cerrar sesión",
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
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
