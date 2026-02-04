import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../widgets/animated_navbar.dart';
import '../widgets/animated_footer.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  // We use these keys or state variables to control when animations start
  bool _heroVisible = false;
  bool _visionVisible = false;
  bool _foundationVisible = false;
  bool _productsVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Slightly off-white for depth
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const AnimatedNavbar(),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 120 : 24,
                vertical: 80,
              ),
              child: Column(
                children: [
                  // HERO SECTION
                  VisibilityDetector(
                    key: const Key('about_hero'),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.2 && !_heroVisible) {
                        setState(() => _heroVisible = true);
                      }
                    },
                    child: Column(
                      children: [
                        Text(
                              'ABOUT JENVEDA',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFD946EF),
                                letterSpacing: 4,
                              ),
                            )
                            .animate(target: _heroVisible ? 1 : 0)
                            .fadeIn(duration: 600.ms)
                            .slideY(
                              begin: -0.5,
                              end: 0,
                              curve: Curves.easeOutCirc,
                            ),
                        const SizedBox(height: 24),
                        Text(
                              "Empower Your Business with\nJenVeda's Revolutionary ERP Solution!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isDesktop ? 56 : 32,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF111827),
                                height: 1.1,
                                letterSpacing: -1.5,
                              ),
                            )
                            .animate(target: _heroVisible ? 1 : 0)
                            .fadeIn(duration: 800.ms, delay: 200.ms)
                            .slideY(
                              begin: 0.3,
                              end: 0,
                              curve: Curves.bounceOut,
                            ), // Fluid bounce
                        const SizedBox(height: 32),
                        Container(
                              constraints: const BoxConstraints(maxWidth: 800),
                              child: Text(
                                "Unlock unparalleled efficiency and growth potential with JenVeda's innovative ERP solution, designed to streamline your operations and drive profitability.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isDesktop ? 20 : 16,
                                  color: const Color(0xFF4B5563),
                                  height: 1.6,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                            .animate(target: _heroVisible ? 1 : 0)
                            .fadeIn(duration: 800.ms, delay: 400.ms)
                            .slideY(
                              begin: 0.3,
                              end: 0,
                              curve: Curves.easeOutCubic,
                            ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 120),

                  // VISION & MISSION
                  VisibilityDetector(
                    key: const Key('about_vision'),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.2 && !_visionVisible) {
                        setState(() => _visionVisible = true);
                      }
                    },
                    child: Wrap(
                      spacing: 40,
                      runSpacing: 40,
                      alignment: WrapAlignment.center,
                      children: [
                        _FluidCard(
                          isVisible: _visionVisible,
                          index: 0,
                          title: 'Our Vision',
                          content:
                              "At JenVeda, our vision is to revolutionise the way businesses operate by providing them with a comprehensive ERP solution that empowers them to thrive in today's dynamic market.",
                          icon: Icons.visibility_outlined,
                          accentColor: const Color(0xFFD946EF), // Pink
                        ),
                        _FluidCard(
                          isVisible: _visionVisible,
                          index: 1, // Staggered index
                          title: 'Our Mission',
                          content:
                              "To address the biggest challenges faced by MSMEs by offering them a transformative ERP solution. We are committed to simplifying and streamlining their operations.",
                          icon: Icons.auto_awesome_outlined,
                          accentColor: const Color(0xFFFB923C), // Orange
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 140),

                  // FOUNDATION HEADER
                  VisibilityDetector(
                    key: const Key('about_foundation'),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.2 && !_foundationVisible) {
                        setState(() => _foundationVisible = true);
                      }
                    },
                    child:
                        Text(
                              "The Foundation of JenVeda's Excellence",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isDesktop ? 42 : 28,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF111827),
                                letterSpacing: -1,
                              ),
                            )
                            .animate(target: _foundationVisible ? 1 : 0)
                            .fadeIn(duration: 600.ms)
                            .slideY(
                              begin: 0.2,
                              end: 0,
                              curve: Curves.easeOutBack,
                            ),
                  ),

                  const SizedBox(height: 60),

                  // PRODUCTS GRID
                  VisibilityDetector(
                    key: const Key('about_products'),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.1 && !_productsVisible) {
                        setState(() => _productsVisible = true);
                      }
                    },
                    child: Wrap(
                      spacing: 32,
                      runSpacing: 32,
                      alignment: WrapAlignment.center,
                      children: [
                        _ProductFluidCard(
                          isVisible: _productsVisible,
                          index: 0,
                          title: 'HR Management',
                          desc:
                              "Effective management of human resources, recruitment, and payroll.",
                          icon: Icons.people_outline,
                          color: const Color(0xFFD946EF),
                        ),
                        _ProductFluidCard(
                          isVisible: _productsVisible,
                          index: 1,
                          title: 'Project Management',
                          desc:
                              "Streamline planning, execution, and collaboration with ease.",
                          icon: Icons.task_alt,
                          color: const Color(0xFF3B82F6),
                        ),
                        _ProductFluidCard(
                          isVisible: _productsVisible,
                          index: 2,
                          title: 'Accounting',
                          desc:
                              "Simplify invoicing, expense tracking, and financial reporting.",
                          icon: Icons.account_balance_wallet_outlined,
                          color: const Color(0xFF10B981),
                        ),
                        _ProductFluidCard(
                          isVisible: _productsVisible,
                          index: 3,
                          title: 'Inventory',
                          desc:
                              "Optimise stock levels, streamline procurement, and track assets.",
                          icon: Icons.inventory_2_outlined,
                          color: const Color(0xFFF59E0B),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: AnimatedFooter()),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// FLUID CARDS with Scroll Triggered Animation
// -----------------------------------------------------------------------------

class _FluidCard extends StatefulWidget {
  final bool isVisible;
  final int index;
  final String title;
  final String content;
  final IconData icon;
  final Color accentColor;

  const _FluidCard({
    required this.isVisible,
    required this.index,
    required this.title,
    required this.content,
    required this.icon,
    required this.accentColor,
  });

  @override
  State<_FluidCard> createState() => _FluidCardState();
}

class _FluidCardState extends State<_FluidCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            width: 500,
            padding: const EdgeInsets.all(48),
            transform: Matrix4.identity()
              ..translate(0.0, isHovered ? -10.0 : 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: isHovered
                    ? widget.accentColor.withOpacity(0.5)
                    : const Color(0xFFF3F4F6),
                width: isHovered ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.accentColor.withOpacity(isHovered ? 0.2 : 0.05),
                  blurRadius: isHovered ? 50 : 30,
                  offset: isHovered ? const Offset(0, 20) : const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Pill
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: widget.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(widget.icon, color: widget.accentColor, size: 32),
                ),
                const SizedBox(height: 32),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.content,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4B5563),
                    height: 1.8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate(target: widget.isVisible ? 1 : 0)
        .fadeIn(
          duration: 800.ms,
          delay: (widget.index * 200).ms, // Staggered
          curve: Curves.easeOutQuad,
        )
        .slideY(
          begin: 0.3,
          end: 0,
          duration: 800.ms,
          delay: (widget.index * 200).ms,
          curve: Curves.easeOutBack, // "Fluid" bounce
        );
  }
}

class _ProductFluidCard extends StatefulWidget {
  final bool isVisible;
  final int index;
  final String title;
  final String desc;
  final IconData icon;
  final Color color;

  const _ProductFluidCard({
    required this.isVisible,
    required this.index,
    required this.title,
    required this.desc,
    required this.icon,
    required this.color,
  });

  @override
  State<_ProductFluidCard> createState() => _ProductFluidCardState();
}

class _ProductFluidCardState extends State<_ProductFluidCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            width: 400,
            height: 320, // Fixed height for uniformity
            padding: const EdgeInsets.all(32),
            transform: Matrix4.identity()
              ..scale(
                isHovered ? 1.02 : 1.0,
                isHovered ? 1.02 : 1.0,
              ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isHovered
                    ? widget.color.withOpacity(0.3)
                    : const Color(0xFFF3F4F6),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(isHovered ? 0.15 : 0.05),
                  blurRadius: isHovered ? 40 : 20,
                  offset: isHovered ? const Offset(0, 20) : const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isHovered
                        ? widget.color
                        : widget.color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    color: isHovered ? Colors.white : widget.color,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.desc,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF6B7280),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate(target: widget.isVisible ? 1 : 0)
        .fadeIn(
          duration: 600.ms,
          delay: (widget.index * 150).ms, // Staggered
        )
        .moveY(
          begin: 50,
          end: 0,
          duration: 800.ms,
          delay: (widget.index * 150).ms,
          curve: Curves.easeOutCubic, // Smooth fluid motion
        );
  }
}
