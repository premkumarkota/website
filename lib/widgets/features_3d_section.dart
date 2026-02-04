import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Features3DSection extends StatefulWidget {
  const Features3DSection({Key? key}) : super(key: key);

  @override
  State<Features3DSection> createState() => _Features3DSectionState();
}

class _Features3DSectionState extends State<Features3DSection>
    with TickerProviderStateMixin {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;
    final isTablet = size.width > 700 && size.width <= 1000;

    return VisibilityDetector(
      key: const Key('features-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !isVisible) {
          setState(() => isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        // Transparent background
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 120 : 24,
                vertical: 100,
              ),
              child: Column(
                children: [
                  // Section Header
                  // Section Header
                  Column(
                    children: [
                      Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'PLATFORM ',
                                style: TextStyle(
                                  fontSize: isDesktop ? 48 : 32,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF111827), // Dark text
                                  letterSpacing: -1,
                                ),
                              ),
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        Color(0xFFD946EF),
                                        Color(0xFFF43F5E),
                                      ],
                                    ).createShader(bounds),
                                child: Text(
                                  'CAPABILITIES',
                                  style: TextStyle(
                                    fontSize: isDesktop ? 48 : 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ),
                            ],
                          )
                          .animate(target: isVisible ? 1 : 0)
                          .fadeIn(duration: 600.ms)
                          .slideY(begin: 0.2, end: 0),
                      const SizedBox(height: 20),
                      Container(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Text(
                              'Experience a seamless ecosystem where data meets decision-making. Our 3D-ready architecture ensures your business stays ahead of the curve.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: const Color(
                                  0xFF4B5563,
                                ), // Grey description
                                height: 1.6,
                              ),
                            ),
                          )
                          .animate(target: isVisible ? 1 : 0)
                          .fadeIn(duration: 800.ms, delay: 400.ms)
                          .slideY(begin: 0.2, end: 0),
                    ],
                  ),
                  const SizedBox(height: 80),

                  // Feature Grid
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (isDesktop) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildFeatureCard(
                                title: 'Unified Solutions',
                                description:
                                    'Consolidate HRMS, ERP, and CRM into a single source of truth.',
                                icon: Icons.layers_outlined,
                                delay: 0,
                              ),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: _buildFeatureCard(
                                title: 'Cloud Native',
                                description:
                                    'Enterprise-grade security with decentralized cloud architecture.',
                                icon: Icons.auto_awesome_mosaic_outlined,
                                delay: 200,
                              ),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: _buildFeatureCard(
                                title: 'Real-time Analytics',
                                description:
                                    'Turn complex data into actionable insights with 3D visualization.',
                                icon: Icons.query_stats_outlined,
                                delay: 400,
                              ),
                            ),
                          ],
                        );
                      } else if (isTablet) {
                        return Wrap(
                          spacing: 32,
                          runSpacing: 32,
                          alignment: WrapAlignment.center,
                          children: [
                            SizedBox(
                              width: (constraints.maxWidth - 32) / 2,
                              child: _buildFeatureCard(
                                title: 'Unified Solutions',
                                description:
                                    'Consolidate HRMS, ERP, and CRM into a single source of truth.',
                                icon: Icons.layers_outlined,
                                delay: 0,
                              ),
                            ),
                            SizedBox(
                              width: (constraints.maxWidth - 32) / 2,
                              child: _buildFeatureCard(
                                title: 'Cloud Native',
                                description:
                                    'Enterprise-grade security with decentralized cloud architecture.',
                                icon: Icons.auto_awesome_mosaic_outlined,
                                delay: 200,
                              ),
                            ),
                            SizedBox(
                              width: (constraints.maxWidth - 32) / 2,
                              child: _buildFeatureCard(
                                title: 'Real-time Analytics',
                                description:
                                    'Turn complex data into actionable insights with 3D visualization.',
                                icon: Icons.query_stats_outlined,
                                delay: 400,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildFeatureCard(
                              title: 'Unified Solutions',
                              description:
                                  'Consolidate HRMS, ERP, and CRM info a single source of truth.',
                              icon: Icons.layers_outlined,
                              delay: 0,
                            ),
                            const SizedBox(height: 24),
                            _buildFeatureCard(
                              title: 'Cloud Native',
                              description:
                                  'Enterprise-grade security with decentralized cloud architecture.',
                              icon: Icons.auto_awesome_mosaic_outlined,
                              delay: 100,
                            ),
                            const SizedBox(height: 24),
                            _buildFeatureCard(
                              title: 'Real-time Analytics',
                              description:
                                  'Turn complex data into actionable insights.',
                              icon: Icons.query_stats_outlined,
                              delay: 200,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String description,
    required IconData icon,
    required int delay,
  }) {
    return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white, // Light Card
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.black.withOpacity(0.05), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD946EF).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFD946EF).withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Icon(icon, color: const Color(0xFFD946EF), size: 32),
                  )
                  .animate(target: isVisible ? 1 : 0)
                  .scale(
                    duration: 600.ms,
                    delay: (delay + 300).ms,
                    curve: Curves.easeOutBack,
                  ),
              const SizedBox(height: 32),
              Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827), // Dark Title
                      letterSpacing: -0.5,
                    ),
                  )
                  .animate(target: isVisible ? 1 : 0)
                  .fadeIn(duration: 600.ms, delay: (delay + 400).ms)
                  .slideX(begin: 0.1, end: 0),
              const SizedBox(height: 16),
              Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color(0xFF6B7280), // Grey Description
                      height: 1.6,
                    ),
                  )
                  .animate(target: isVisible ? 1 : 0)
                  .fadeIn(duration: 600.ms, delay: (delay + 500).ms)
                  .slideX(begin: 0.1, end: 0),
              const SizedBox(height: 32),
              TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Explore Detail',
                          style: TextStyle(
                            color: const Color(0xFFD946EF),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                          color: Color(0xFFD946EF),
                        ),
                      ],
                    ),
                  )
                  .animate(target: isVisible ? 1 : 0)
                  .fadeIn(duration: 600.ms, delay: (delay + 600).ms),
            ],
          ),
        )
        .animate(target: isVisible ? 1 : 0)
        .fadeIn(duration: 800.ms, delay: delay.ms)
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          duration: 800.ms,
          curve: Curves.easeOutBack,
        )
        .moveY(begin: 50, end: 0, duration: 800.ms, curve: Curves.easeOutCubic);
  }
}
