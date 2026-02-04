import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'glowing_button.dart';

class CTASection extends StatefulWidget {
  const CTASection({Key? key}) : super(key: key);

  @override
  State<CTASection> createState() => _CTASectionState();
}

class _CTASectionState extends State<CTASection> with TickerProviderStateMixin {
  bool isVisible = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    return VisibilityDetector(
      key: const Key('cta-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !isVisible) {
          setState(() => isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: isDesktop ? 600 : 500),
        padding: EdgeInsets.symmetric(
          vertical: isDesktop ? 0 : 80,
          horizontal: 24,
        ),
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Refined Animated Rings
            ...List.generate(4, (index) {
              return AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  final progress = _pulseController.value;
                  return Container(
                    width: 400 + (index * 200) + (progress * 50),
                    height: 400 + (index * 200) + (progress * 50),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(
                          0xFFD946EF,
                        ).withOpacity(0.05 / (index + 1)),
                        width: 1.5,
                      ),
                    ),
                  );
                },
              );
            }),

            // Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                      'Ready to Transform?',
                      style: TextStyle(
                        fontSize: isDesktop ? 72 : 42,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF111827), // Dark Heading
                        letterSpacing: -2,
                        height: 1.1,
                      ),
                    )
                    .animate(target: isVisible ? 1 : 0)
                    .fadeIn(duration: 800.ms)
                    .scale(begin: const Offset(0.9, 0.9)),

                const SizedBox(height: 16),

                Text(
                      'Join 500+ companies already growing with Jenveda',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: const Color(0xFF4B5563), // Grey Text
                        fontWeight: FontWeight.w500,
                      ),
                    )
                    .animate(target: isVisible ? 1 : 0)
                    .fadeIn(duration: 800.ms, delay: 200.ms),

                const SizedBox(height: 56),

                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 24,
                  runSpacing: 20,
                  children: [
                    GlowingButton(
                          text: 'Start Free Trial',
                          onTap: () {},
                          icon: Icons.rocket_launch,
                        )
                        .animate(target: isVisible ? 1 : 0)
                        .fadeIn(duration: 600.ms, delay: 400.ms)
                        .slideX(begin: -0.2, end: 0),

                    // Modern Glassmorphic Button
                    MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 36,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.1),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    color: Color(0xFF374151), // Dark Icon
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Schedule Demo',
                                    style: TextStyle(
                                      color: const Color(
                                        0xFF374151,
                                      ), // Dark Text
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .animate(target: isVisible ? 1 : 0)
                        .fadeIn(duration: 600.ms, delay: 500.ms)
                        .slideX(begin: 0.2, end: 0),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
