import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../widgets/hero_section.dart';
import '../widgets/animated_navbar.dart';
import '../widgets/features_3d_section.dart';
import '../widgets/products_showcase.dart';
import '../widgets/immersive_carousel_section.dart';
import '../widgets/product_suite_section.dart';
import '../widgets/clients_showcase.dart';
import '../widgets/stats_section.dart';
import '../widgets/testimonial_section.dart';
import '../widgets/cta_section.dart';
import '../widgets/interface_showcase_section.dart';
import '../widgets/animated_footer.dart';
import '../controller/navigation_controller.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  final NavigationController navController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Light Theme Background
      endDrawer: _buildMobileDrawer(),
      body: Stack(
        children: [
          // UNIFIED STATIC BACKGROUND (Light Theme)
          Positioned.fill(child: Container(color: const Color(0xFFF9FAFB))),

          // Gradient Overlay (Light Theme adjustments)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),

          // Main Content - Scrolls over the fixed background
          CustomScrollView(
            controller: navController.scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Section 1: Navbar
              const AnimatedNavbar(),

              // Section 1: Hero Section - Centered Content (Light area)
              const SliverToBoxAdapter(child: HeroSection()),

              // Section 2: Enterprise Platform (Transition area)
              const SliverToBoxAdapter(child: ImmersiveCarouselSection()),

              // Section 2.5: App Interface Showcase
              const SliverToBoxAdapter(child: InterfaceShowcaseSection()),

              // Section 3: Product Suite (Dark area)
              const SliverToBoxAdapter(child: ProductSuiteSection()),

              // Section 4: Features with 3D cards
              const SliverToBoxAdapter(child: Features3DSection()),

              // Section 5: Products showcase
              const SliverToBoxAdapter(child: ProductsShowcase()),

              // Section 6: Clients Showcase Marquee
              const SliverToBoxAdapter(child: ClientsShowcase()),

              // Section 7: Stats counter animation
              const SliverToBoxAdapter(child: StatsSection()),

              // Section 8: Testimonials
              const SliverToBoxAdapter(child: TestimonialsSection()),

              // Section 9: CTA Section
              const SliverToBoxAdapter(child: CTASection()),

              // Section 10: Footer
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
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD946EF), Color(0xFFFB923C)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: const Center(
              child: Text(
                'Jenveda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
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
                    style: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
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
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD946EF), Color(0xFFFB923C)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD946EF).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
