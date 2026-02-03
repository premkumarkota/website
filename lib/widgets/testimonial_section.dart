import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({Key? key}) : super(key: key);

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  bool isVisible = false;
  int activeIndex = 0;

  final List<Map<String, dynamic>> testimonials = [
    {
      'quote':
          'Jenveda transformed our HR operations completely. The automation features saved us countless hours every week.',
      'author': 'Sarah Chen',
      'role': 'HR Director, TechCorp',
      'company': 'TechCorp',
      'rating': 5,
    },
    {
      'quote':
          'The project management module is exceptional. We delivered 3 major projects ahead of schedule.',
      'author': 'Michael Rodriguez',
      'role': 'Project Manager, BuildRight',
      'company': 'BuildRight',
      'rating': 5,
    },
    {
      'quote':
          'Finally, an ERP system that understands modern business needs. Highly recommended!',
      'author': 'Emily Watson',
      'role': 'CFO, FinanceHub',
      'company': 'FinanceHub',
      'rating': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    return VisibilityDetector(
      key: const Key('testimonials-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !isVisible) {
          setState(() => isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 120 : 24,
          vertical: 100,
        ),
        child: Column(
          children: [
            Text(
              'TESTIMONIALS',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF3B82F6),
                letterSpacing: 4,
              ),
            ).animate(target: isVisible ? 1 : 0).fadeIn(duration: 600.ms),

            const SizedBox(height: 16),

            Text(
                  'Loved by Teams Worldwide',
                  style: TextStyle(
                    fontSize: isDesktop ? 48 : 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
                .animate(target: isVisible ? 1 : 0)
                .fadeIn(duration: 600.ms, delay: 100.ms)
                .slideY(begin: 0.3, end: 0),

            const SizedBox(height: 60),

            if (isDesktop) _buildDesktopCarousel() else _buildMobileList(),

            const SizedBox(height: 40),

            // Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(testimonials.length, (index) {
                return GestureDetector(
                  onTap: () => setState(() => activeIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: activeIndex == index ? 32 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: activeIndex == index
                          ? const LinearGradient(
                              colors: [Color(0xFF7C3AED), Color(0xFFEC4899)],
                            )
                          : null,
                      color: activeIndex == index
                          ? null
                          : Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopCarousel() {
    return SizedBox(
      height: 400,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(testimonials.length, (index) {
          final offset = index - activeIndex;
          final isActive = index == activeIndex;

          return AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            left: MediaQuery.of(context).size.width / 2 - 250 + (offset * 100),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(offset * -0.2)
                ..scale(isActive ? 1.0 : 0.8),
              child: Opacity(
                opacity: isActive ? 1.0 : 0.5,
                child: _buildTestimonialCard(testimonials[index], index),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMobileList() {
    return Column(
      children: List.generate(testimonials.length, (index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: _buildTestimonialCard(testimonials[index], index),
        );
      }),
    );
  }

  Widget _buildTestimonialCard(Map<String, dynamic> testimonial, int index) {
    return Container(
          constraints: const BoxConstraints(maxWidth: 500),
          width: double.infinity,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C3AED).withOpacity(0.1),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    Icons.star,
                    color: const Color(0xFFF59E0B),
                    size: 20,
                  );
                }),
              ),
              const SizedBox(height: 24),
              Text(
                '"${testimonial['quote']}"',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7C3AED), Color(0xFFEC4899)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        (testimonial['author'] as String).substring(0, 1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        testimonial['author'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        testimonial['role'] as String,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
        .animate(target: isVisible ? 1 : 0)
        .fadeIn(duration: 800.ms, delay: (index * 150).ms)
        .slideY(begin: 0.3, end: 0);
  }
}
