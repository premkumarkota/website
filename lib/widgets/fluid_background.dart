import 'dart:ui';
import 'package:flutter/material.dart';

class FluidBackground extends StatefulWidget {
  const FluidBackground({Key? key}) : super(key: key);

  @override
  State<FluidBackground> createState() => _FluidBackgroundState();
}

class _FluidBackgroundState extends State<FluidBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF050508), // Deepest dark
      child: Stack(
        children: [
          // Blob 1 - Purple (Top Left)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                top: -100 + (_animation.value * 50),
                left: -100 + (_animation.value * 30),
                child: Container(
                  width: 600,
                  height: 600,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFD946EF).withOpacity(0.4), // Pink/Purple
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Blob 2 - Orange (Center Right)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                top: 300 - (_animation.value * 80),
                right: -200 + (_animation.value * 50),
                child: Container(
                  width: 700,
                  height: 700,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFFB923C).withOpacity(0.3), // Orange
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Blob 3 - Blue/Cyan (Bottom Left)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                bottom: -200 + (_animation.value * 60),
                left: -100 - (_animation.value * 40),
                child: Container(
                  width: 800,
                  height: 800,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF3B82F6).withOpacity(0.35), // Blue
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Blob 4 - Accent Pink (Bottom Right)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                bottom: 100 - (_animation.value * 40),
                right: -50 - (_animation.value * 30),
                child: Container(
                  width: 500,
                  height: 500,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFEC4899).withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Heavy Blur to Create "Liquid" Effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(color: Colors.transparent),
          ),

          // Subtle Grain Overlay (Optional, uses a network image for now or css gradient)
          // For now, let's keep it clean.
        ],
      ),
    );
  }
}
