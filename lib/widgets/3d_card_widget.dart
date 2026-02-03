import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Card3D extends StatefulWidget {
  final Color color;
  final IconData icon;
  final String title;
  final int delay;

  const Card3D({
    Key? key,
    required this.color,
    required this.icon,
    required this.title,
    required this.delay,
  }) : super(key: key);

  @override
  State<Card3D> createState() => _Card3DState();
}

class _Card3DState extends State<Card3D> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(isHovered ? -0.1 : 0)
                  ..rotateY(isHovered ? 0.1 : 0)
                  ..translate(0.0, isHovered ? -20.0 : 0.0, 0.0),
                child: Container(
                  width: 180,
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.color.withOpacity(0.8),
                        widget.color.withOpacity(0.4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withOpacity(isHovered ? 0.6 : 0.3),
                        blurRadius: isHovered ? 40 : 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        // Glass effect
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withOpacity(0.1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Content
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  widget.icon,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                widget.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 40,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 800.ms, delay: widget.delay.ms)
              .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1)),
    );
  }
}
