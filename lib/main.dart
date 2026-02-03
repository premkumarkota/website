import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'routes/app_router.dart';
import 'controller/navigation_controller.dart';

void main() {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NavigationController());
  runApp(const JenvedaApp());
}

class JenvedaApp extends StatelessWidget {
  const JenvedaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: 'Jenveda | Next-Gen ERP Solutions',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.dark,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0a0a0a),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF7C3AED),
        secondary: Color(0xFFEC4899),
        surface: Color(0xFF1a1a2e),
        background: Color(0xFF0a0a0a),
        onSurface: Colors.white,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7C3AED),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme() => _buildTheme();
}
