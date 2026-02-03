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
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return VisibilityDetector(
      key: const Key('cta-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !isVisible) {
          setState(() => isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: size.width > 1000 ? 120 : 24,
          vertical: 120,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated background waves
            ...List.generate(3, (index) {
              return AnimatedBuilder(
                animation: _waveController,
                builder: (context, child) {
                  return Container(
                    width: 600 + (index * 200),
                    height: 600 + (index * 200),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(
                          0xFF7C3AED,
                        ).withOpacity(0.1 - (index * 0.02)),
                        width: 2,
                      ),
                    ),
                    transform: Matrix4.identity()
                      ..scale(1 + (_waveController.value * 0.1 * (index + 1))),
                  );
                },
              );
            }),

            // Content
            Container(
              padding: EdgeInsets.all(size.width > 600 ? 60 : 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C3AED).withOpacity(0.2),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                        'Ready to Transform?',
                        style: TextStyle(
                          fontSize: size.width > 1000 ? 56 : 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                      .animate(target: isVisible ? 1 : 0)
                      .fadeIn(duration: 800.ms)
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 16),

                  Text(
                        'Join 500+ companies already growing with Jenveda',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      )
                      .animate(target: isVisible ? 1 : 0)
                      .fadeIn(duration: 800.ms, delay: 200.ms)
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 40),

                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      GlowingButton(
                            text: 'Start Free Trial',
                            onTap: () {},
                            icon: Icons.rocket_launch,
                          )
                          .animate(target: isVisible ? 1 : 0)
                          .fadeIn(duration: 600.ms, delay: 400.ms)
                          .scale(begin: const Offset(0.8, 0.8)),

                      GestureDetector(
                            onTap: () {},
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.white.withOpacity(0.9),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Schedule Demo',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .animate(target: isVisible ? 1 : 0)
                          .fadeIn(duration: 600.ms, delay: 500.ms)
                          .scale(begin: const Offset(0.8, 0.8)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
