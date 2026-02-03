import 'package:flutter/material.dart';
import 'dart:math' as math;

class FloatingParticles extends StatelessWidget {
  final AnimationController controller;

  const FloatingParticles({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          children: List.generate(20, (index) {
            final random = math.Random(index);
            final x = random.nextDouble();
            final y = random.nextDouble();
            final size = random.nextDouble() * 4 + 2;
            final speed = random.nextDouble() * 0.5 + 0.2;
            final offset = (controller.value * speed + random.nextDouble()) % 1;

            return Positioned(
              left: x * MediaQuery.of(context).size.width,
              top: ((y + offset) % 1) * MediaQuery.of(context).size.height,
              child: Opacity(
                opacity: (1 - offset) * 0.6,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: index % 3 == 0
                        ? const Color(0xFF7C3AED)
                        : index % 3 == 1
                        ? const Color(0xFFEC4899)
                        : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                            (index % 3 == 0
                                    ? const Color(0xFF7C3AED)
                                    : const Color(0xFFEC4899))
                                .withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
