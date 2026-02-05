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
      title: 'Jenveda',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.light,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFD946EF),
        secondary: Color(0xFFFB923C),
        surface: Colors.white,
        onSurface: Color(0xFF1F2937),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD946EF),
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
