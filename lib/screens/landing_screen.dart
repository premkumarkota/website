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

import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

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

  Future<void> _handleRefresh() async {
    // Simulate refresh delay or reload data
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Trigger rebuilds if needed
    });
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
          LiquidPullToRefresh(
            onRefresh: _handleRefresh,
            color: const Color(0xFFD946EF), // Theme pink
            backgroundColor: Colors.white,
            height: 100,
            showChildOpacityTransition: false,
            animSpeedFactor: 2.0,
            child: CustomScrollView(
              controller: navController.scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Section 1: Navbar
                const AnimatedNavbar(),

                // Section 1: Hero Section - Centered Content (Light area)
                const SliverToBoxAdapter(child: HeroSection()),

                // Section 2: Enterprise Platform (Transition area)
                const SliverToBoxAdapter(child: ImmersiveCarouselSection()),

                // Section 2.5: App Interface Showcase (Beautiful Interface)
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
          ),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(0)),
      ),
      child: Column(
        children: [
          // Professional Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo / Brand
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFD946EF), Color(0xFFFB923C)],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Jenveda',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827),
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  // Close Button
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 20),
                    ),
                    color: const Color(0xFF6B7280),
                  ),
                ],
              ),
            ),
          ),

          // Navigation Links
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              children: [
                _buildDrawerItem(
                  title: 'Home',
                  icon: Icons.home_rounded,
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/');
                  },
                ),
                _buildDrawerItem(
                  title: 'About',
                  icon: Icons.info_outline_rounded,
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/about');
                  },
                ),
                // Products Expansion Tile
                Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD946EF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.grid_view_rounded,
                        size: 20,
                        color: Color(0xFFD946EF),
                      ),
                    ),
                    title: const Text(
                      'Products',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    childrenPadding: const EdgeInsets.only(left: 16),
                    children: [
                      _buildSubMenuItem('HR Management', () {}),
                      _buildSubMenuItem('Project Management', () {}),
                      _buildSubMenuItem('Finance & Accounting', () {}),
                      _buildSubMenuItem('CRM Solutions', () {}),
                    ],
                  ),
                ),
                _buildDrawerItem(
                  title: 'Contact',
                  icon: Icons.mail_outline_rounded,
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/contact');
                  },
                ),
              ],
            ),
          ),

          // Footer CTA
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
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: const Color(0xFF6B7280)),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1F2937),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );
  }

  Widget _buildSubMenuItem(String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 48, right: 16),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF4B5563),
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 12,
        color: Color(0xFF9CA3AF),
      ),
      onTap: () {
        Navigator.pop(context);
        // Navigate or show snackbar
        context.go('/products'); // Generalized for now, can be specific later
      },
    );
  }
}
