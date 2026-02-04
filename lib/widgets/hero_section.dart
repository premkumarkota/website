import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:go_router/go_router.dart';
import 'glowing_button.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1100;

    return Container(
      constraints: BoxConstraints(
        minHeight: isDesktop ? size.height * 0.85 : size.height * 0.75,
      ),
      width: double.infinity,
      padding: EdgeInsets.only(
        left: isDesktop ? 120 : 24,
        right: isDesktop ? 120 : 24,
        top: isDesktop ? 80 : 60,
        bottom: isDesktop ? 80 : 60,
      ),
      child: Center(child: _buildHeroContent(isDesktop)),
    );
  }

  Widget _buildHeroContent(bool isDesktop) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFD946EF).withOpacity(0.15),
                const Color(0xFFFB923C).withOpacity(0.15),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: const Color(0xFFD946EF).withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 1000.ms),
              const SizedBox(width: 10),
              const Text(
                'Next-Gen ERP Solution',
                style: TextStyle(
                  color: const Color(0xFF1F2937), // Dark text
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),

        const SizedBox(height: 40),

        // Main heading - Centered
        Container(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 900 : double.infinity,
          ),
          child: Column(
            children: [
              Text(
                    'Experience Efficiency and',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop ? 68 : 36,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF111827), // Dark heading
                      height: 1.1,
                      letterSpacing: -2,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 100.ms)
                  .slideY(begin: 0.2, end: 0),

              ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFFD946EF), Color(0xFFFB923C)],
                    ).createShader(bounds),
                    child: Text(
                      'Empower Your Business',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop ? 68 : 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.black, // Opaque for mask
                        height: 1.1,
                        letterSpacing: -2,
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 200.ms)
                  .slideY(begin: 0.2, end: 0),

              const SizedBox(height: 20),

              DefaultTextStyle(
                style: GoogleFonts.poppins(
                  fontSize: isDesktop ? 26 : 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF374151), // Animated text dark
                  height: 1.4,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'With our Cutting-Edge ERP Software Solution',
                      speed: const Duration(milliseconds: 50),
                      cursor: '|',
                      textAlign: TextAlign.center,
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Description
        Container(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 700 : double.infinity,
              ),
              child: Text(
                'Streamline your operations, boost productivity, and drive profitability with our comprehensive ERP software. From seamless integration to powerful analytics.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isDesktop ? 18 : 16,
                  color: const Color(0xFF4B5563), // Description grey
                  height: 1.7,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms, delay: 1200.ms)
            .slideY(begin: 0.2, end: 0),

        const SizedBox(height: 48),

        // CTA Buttons - Centered
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            GlowingButton(
                  text: 'Explore Solutions',
                  onTap: () => context.go('/products'),
                  icon: Icons.rocket_launch,
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 1400.ms)
                .scale(begin: const Offset(0.9, 0.9)),

            GestureDetector(
                  onTap: () => context.go('/contact'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.play_circle_outline,
                          color: Color(0xFF1F2937),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Watch Demo',
                          style: TextStyle(
                            color: Color(0xFF1F2937),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 1500.ms)
                .scale(begin: const Offset(0.9, 0.9)),
          ],
        ),

        const SizedBox(height: 60),

        // Scroll indicator
        Column(
          children: [
            Text(
              'Scroll to explore',
              style: TextStyle(
                color: const Color(0xFF6B7280), // Scroll label
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 24,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD1D5DB), width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child:
                    Container(
                          margin: const EdgeInsets.only(top: 8),
                          width: 4,
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD946EF),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        )
                        .animate(onPlay: (c) => c.repeat())
                        .slideY(begin: 0, end: 1.5, duration: 1200.ms)
                        .then()
                        .fadeOut(duration: 300.ms),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 2000.ms),
      ],
    );
  }
}
