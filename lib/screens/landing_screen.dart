import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../widgets/hero_section.dart';
import '../widgets/animated_navbar.dart';
import '../widgets/features_3d_section.dart';
import '../widgets/products_showcase.dart';
import '../widgets/clients_showcase.dart';
import '../widgets/stats_section.dart';
import '../widgets/testimonial_section.dart';
import '../widgets/cta_section.dart';
import '../widgets/animated_footer.dart';
import '../widgets/floating_particles.dart';
import '../controller/navigation_controller.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  final NavigationController navController = Get.find();
  late AnimationController _particleController;
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _floatController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _particleController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      endDrawer: _buildMobileDrawer(),
      body: Stack(
        children: [
          // Animated gradient background
          _buildAnimatedBackground(),

          // Floating particles
          FloatingParticles(controller: _particleController),

          // Main content
          CustomScrollView(
            controller: navController.scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Navbar
              const AnimatedNavbar(),

              // Hero Section with 3D elements
              const SliverToBoxAdapter(child: HeroSection()),

              // Features with 3D cards
              const SliverToBoxAdapter(child: Features3DSection()),

              // Products showcase
              const SliverToBoxAdapter(child: ProductsShowcase()),

              // Clients Showcase Marquee
              const SliverToBoxAdapter(child: ClientsShowcase()),

              // Stats counter animation
              const SliverToBoxAdapter(child: StatsSection()),

              // Testimonials
              const SliverToBoxAdapter(child: TestimonialsSection()),

              // CTA Section
              const SliverToBoxAdapter(child: CTASection()),

              // Footer
              const SliverToBoxAdapter(child: AnimatedFooter()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer() {
    final List<Map<String, dynamic>> navItems = [
      {'title': 'Home', 'route': '/'},
      {'title': 'About', 'route': '/about'},
      {'title': 'Products', 'route': '/products'},
      {'title': 'Contact', 'route': '/contact'},
    ];

    return Drawer(
      backgroundColor: const Color(0xFF0a0a0a),
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7C3AED), Color(0xFFEC4899)],
              ),
            ),
            child: Center(
              child: Image.network(
                'https://placeholder.com/150', // Replace with real logo if needed
                errorBuilder: (c, e, s) => const Text(
                  'Jenveda',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: navItems.map((item) {
                return ListTile(
                  title: Text(
                    item['title'] as String,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.go(item['route'] as String);
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Get Started'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(
                -0.5 + (_floatController.value * 0.2),
                -0.5 + (_floatController.value * 0.1),
              ),
              radius: 1.5,
              colors: [
                const Color(0xFF7C3AED).withOpacity(0.15),
                const Color(0xFF0a0a0a),
              ],
            ),
          ),
        );
      },
    );
  }
}
