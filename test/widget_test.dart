import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_registro/main.dart';

void main() {
  testWidgets('Login valida y navega a Home con el correo', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    await tester.pumpWidget(const MainApp());
    expect(find.text('Bienvenido de nuevo'), findsOneWidget);

    await tester.tap(find.text('Iniciar sesión'));
    await tester.pump();
    expect(find.text('El correo es obligatorio'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'usuario@dominio.com');
    await tester.enterText(find.byType(TextField).at(1), '123456');
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();
    expect(find.text('¡Bienvenido!'), findsOneWidget);
    expect(find.text('usuario@dominio.com'), findsOneWidget);
  });
}
