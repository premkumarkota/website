import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '3d_card_widget.dart';
import 'glowing_button.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _floatAnimation = Tween<double>(
      begin: -20,
      end: 20,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1100;

    return Container(
      constraints: BoxConstraints(minHeight: size.height),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 120 : 24,
        vertical: isDesktop ? 40 : 100,
      ),
      child: Row(
        children: [
          Expanded(
            flex: isDesktop ? 5 : 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFD946EF).withOpacity(0.2),
                        const Color(0xFFFB923C).withOpacity(0.2),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: const Color(0xFFD946EF).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                          )
                          .animate(onPlay: (controller) => controller.repeat())
                          .shimmer(duration: 1000.ms),
                      const SizedBox(width: 8),
                      const Text(
                        'Next-Gen ERP Solution',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),

                const SizedBox(height: 32),

                // Main heading with animated text
                Container(
                  constraints: BoxConstraints(minHeight: isDesktop ? 180 : 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                            'Experience Efficiency and Empower Your Business',
                            style: GoogleFonts.poppins(
                              fontSize: isDesktop ? 64 : 32,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1.1,
                              letterSpacing: -1.5,
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 800.ms)
                          .slideY(begin: 0.2, end: 0),
                      const SizedBox(height: 16),
                      DefaultTextStyle(
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 32 : 20,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF7C3AED), // Use theme color
                          height: 1.2,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'With our Cutting-Edge ERP Software Solution',
                              speed: const Duration(milliseconds: 60),
                              cursor: '|',
                            ),
                          ],
                          totalRepeatCount: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Subtitle / Description
                Text(
                      'Streamline your operations, boost productivity, and drive profitability with our comprehensive ERP software. From seamless integration to powerful analytics, our solution is tailored to empower businesses of all sizes and industries.',
                      style: TextStyle(
                        fontSize: isDesktop ? 20 : 16,
                        color: Colors.white.withOpacity(0.7),
                        height: 1.6,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.2,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 1500.ms)
                    .slideY(begin: 0.2, end: 0),

                const SizedBox(height: 48),

                // CTA Buttons
                Wrap(
                  // Changed Row to Wrap for better responsiveness
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    GlowingButton(
                          text: 'Explore Solutions',
                          onTap: () => context.go('/products'),
                          icon: Icons.rocket_launch,
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 1200.ms)
                        .scale(begin: const Offset(0.8, 0.8)),

                    const SizedBox(width: 20),

                    GestureDetector(
                          onTap: () => context.go('/contact'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.play_circle_outline,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Watch Demo',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 1400.ms)
                        .scale(begin: const Offset(0.8, 0.8)),
                  ],
                ),
              ],
            ),
          ),

          if (isDesktop) ...[
            const SizedBox(width: 60),
            Expanded(flex: 5, child: _build3DShowcase()),
          ],
        ],
      ),
    );
  }

  Widget _build3DShowcase() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Background glow
            Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF7C3AED).withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // Floating 3D Cards
            Transform.translate(
              offset: Offset(
                math.cos(_rotationAnimation.value) * 30,
                math.sin(_rotationAnimation.value) * 20 + _floatAnimation.value,
              ),
              child: const Card3D(
                color: Color(0xFF7C3AED),
                icon: Icons.people,
                title: 'HRMS',
                delay: 0,
              ),
            ),

            Transform.translate(
              offset: Offset(
                -math.cos(_rotationAnimation.value + 1) * 40,
                math.sin(_rotationAnimation.value + 1) * 30 -
                    _floatAnimation.value * 0.5,
              ),
              child: const Card3D(
                color: Color(0xFF3B82F6),
                icon: Icons.assignment,
                title: 'PMS',
                delay: 200,
              ),
            ),

            Transform.translate(
              offset: Offset(
                math.cos(_rotationAnimation.value + 2) * 35,
                -math.sin(_rotationAnimation.value + 2) * 25 +
                    _floatAnimation.value * 0.7,
              ),
              child: const Card3D(
                color: Color(0xFF10B981),
                icon: Icons.account_balance,
                title: 'Accounting',
                delay: 400,
              ),
            ),

            // Center glowing orb
            Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFEC4899).withOpacity(0.8),
                        const Color(0xFF7C3AED).withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFEC4899).withOpacity(0.5),
                        blurRadius: 100,
                        spreadRadius: 50,
                      ),
                    ],
                  ),
                )
                .animate(onPlay: (controller) => controller.repeat())
                .scale(
                  duration: 3000.ms,
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1.1, 1.1),
                )
                .then()
                .scale(
                  duration: 3000.ms,
                  begin: const Offset(1.1, 1.1),
                  end: const Offset(0.9, 0.9),
                ),
          ],
        );
      },
    );
  }
}
