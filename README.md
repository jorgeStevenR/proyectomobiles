# Login y Registro – App móvil (Flutter)

Taller de maquetación interactiva: flujo de autenticación con 6 pantallas, validaciones y navegación. Sin backend (datos en memoria).

## Versiones

- Flutter 3.47.0 (stable)
- Dart 3.13.0

## Cómo ejecutar

```bash
git clone <url-del-repo>
cd login_registro
flutter pub get
flutter run            # en emulador/celular conectado
# o en navegador:
flutter run -d chrome
```

Pruebas: `flutter test`

## Pantallas

1. **Login** – correo, contraseña, olvidé contraseña, Google/Apple ("Funcionalidad no disponible"), ir a registro.
2. **Registro** – nombre, correo, contraseña + confirmación, checkbox de términos.
3. **Recuperar contraseña** – correo válido → código.
4. **Código de verificación** – 4 casillas (solo dígitos, foco automático), contador 00:45 con "Reenviar código".
5. **Nueva contraseña** – requisitos en tiempo real (8 caracteres, mayúscula, número) y coincidencia.
6. **Home** – avatar, "¡Bienvenido!", correo del usuario, cerrar sesión.

## Estructura

```
lib/
  main.dart               # rutas
  theme.dart              # colores, degradado, validación de correo
  widgets/
    app_input.dart        # Input reutilizable (ojo para contraseñas)
    app_button.dart       # Botón primario / secundario
    code_box.dart         # Casilla de código
    auth_layout.dart      # Fondo con formas decorativas, encabezado y pie
  screens/                # una pantalla por archivo
```
