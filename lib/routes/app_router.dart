import 'package:go_router/go_router.dart';
import '../screens/landing_screen.dart';
import '../screens/about_screen.dart';
import '../screens/products_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/contact_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LandingScreen()),
      GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
      GoRoute(
        path: '/contact',
        builder: (context, state) => const ContactScreen(),
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) => const ProductsScreen(),
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return ProductDetailScreen(productId: id ?? '');
        },
      ),
    ],
  );
}
