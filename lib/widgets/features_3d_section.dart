import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:parallax_rain/parallax_rain.dart';
import 'dart:math' as math;

class Features3DSection extends StatefulWidget {
  const Features3DSection({Key? key}) : super(key: key);

  @override
  State<Features3DSection> createState() => _Features3DSectionState();
}

class _Features3DSectionState extends State<Features3DSection>
    with TickerProviderStateMixin {
  bool isVisible = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    return VisibilityDetector(
      key: const Key('features-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !isVisible) {
          setState(() => isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 120 : 24,
          vertical: 80,
        ),
        child: Stack(
          children: [
            // Parallax rain effect
            Positioned.fill(
              child: ParallaxRain(
                dropColors: [
                  const Color(0xFF7C3AED).withOpacity(0.3),
                  const Color(0xFFEC4899).withOpacity(0.3),
                ],
                numberOfDrops: 20,
                trail: true,
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Section header
                Text(
                      'POWERFUL FEATURES',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFD946EF),
                        letterSpacing: 4,
                      ),
                    )
                    .animate(target: isVisible ? 1 : 0)
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 16),

                Text(
                      'Everything You Need to\nScale Your Business',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isDesktop ? 48 : 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    )
                    .animate(target: isVisible ? 1 : 0)
                    .fadeIn(duration: 600.ms, delay: 100.ms)
                    .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 80),

                // 3D Feature cards
                if (isDesktop)
                  _buildDesktopFeatures()
                else
                  _buildMobileFeatures(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopFeatures() {
    return Wrap(
      spacing: 40,
      runSpacing: 40,
      alignment: WrapAlignment.center,
      children: [
        _buildFeatureCube(
          'Unified Solution',
          'Seamlessly merges HRMS, PMS, Accounts, and Inventory into one powerful platform.',
          Icons.hub,
          const Color(0xFFD946EF),
          -0.2,
          0,
        ),
        _buildFeatureCube(
          'Cloud Native',
          'Cloud-enabled architecture ensuring seamless scalability and accessibility anywhere.',
          Icons.cloud_done,
          const Color(0xFFFB923C),
          0,
          200,
        ),
        _buildFeatureCube(
          'Easy Onboarding',
          'Simplifies your transition with Excel templates for rapid data import and setup.',
          Icons.speed,
          const Color(0xFF3B82F6),
          0.2,
          400,
        ),
      ],
    );
  }

  Widget _buildMobileFeatures() {
    return Column(
      children: [
        _buildFeatureCube(
          'Unified Solution',
          'Seamless integration of HRMS, PMS, and more.',
          Icons.hub,
          const Color(0xFF7C3AED),
          0,
          0,
        ),
        const SizedBox(height: 24),
        _buildFeatureCube(
          'Cloud Native',
          'Scale effortlessly with cloud-enabled accessibility.',
          Icons.cloud_done,
          const Color(0xFFEC4899),
          0,
          200,
        ),
        const SizedBox(height: 24),
        _buildFeatureCube(
          'Easy Onboarding',
          'Rapid setup with our Excel-driven data import.',
          Icons.speed,
          const Color(0xFF3B82F6),
          0,
          400,
        ),
      ],
    );
  }

  Widget _buildFeatureCube(
    String title,
    String description,
    IconData icon,
    Color color,
    double tilt,
    int delay,
  ) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final bounce = math.sin(_controller.value * 2 * math.pi) * 10;

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(tilt)
            ..translate(0.0, bounce, 0.0),
          alignment: Alignment.center,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: math.min(350, MediaQuery.of(context).size.width * 0.85),
              minHeight: 480,
              maxHeight: 480,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
              ),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: color.withOpacity(0.3), width: 1),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Stack(
                children: [
                  // Animated gradient border effect
                  Positioned.fill(
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 3),
                      decoration: BoxDecoration(
                        gradient: SweepGradient(
                          center: Alignment.center,
                          colors: [
                            color.withOpacity(0),
                            color.withOpacity(0.3),
                            color.withOpacity(0),
                          ],
                          transform: GradientRotation(
                            _controller.value * 2 * math.pi,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [color, color.withOpacity(0.6)],
                                ),
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: color.withOpacity(0.4),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Icon(icon, color: Colors.white, size: 40),
                            )
                            .animate(target: isVisible ? 1 : 0)
                            .scale(
                              duration: 600.ms,
                              delay: (delay + 200).ms,
                              begin: const Offset(0, 0),
                              end: const Offset(1, 1),
                              curve: Curves.elasticOut,
                            ),

                        const SizedBox(height: 32),

                        Text(
                              title,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                            .animate(target: isVisible ? 1 : 0)
                            .fadeIn(duration: 600.ms, delay: (delay + 300).ms)
                            .slideY(begin: 0.3, end: 0),

                        const SizedBox(height: 16),

                        Text(
                              description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.7),
                                height: 1.6,
                              ),
                            )
                            .animate(target: isVisible ? 1 : 0)
                            .fadeIn(duration: 600.ms, delay: (delay + 400).ms)
                            .slideY(begin: 0.3, end: 0),

                        const SizedBox(height: 32),

                        Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: color.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Learn More',
                                    style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: color,
                                    size: 16,
                                  ),
                                ],
                              ),
                            )
                            .animate(target: isVisible ? 1 : 0)
                            .fadeIn(duration: 600.ms, delay: (delay + 500).ms),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
