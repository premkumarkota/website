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
  final PageController _pageController = PageController(viewportFraction: 0.85);

  final List<Map<String, dynamic>> testimonials = [
    {
      'quote':
          'Jenveda transformed our HR operations completely. The automation features saved us countless hours every week. The level of customization and support is unmatched.',
      'author': 'Sarah Chen',
      'role': 'HR Director, TechCorp',
      'company': 'TechCorp',
      'rating': 5,
    },
    {
      'quote':
          'The project management module is exceptional. We delivered 3 major projects ahead of schedule. Our team collaboration has improved by 40%.',
      'author': 'Michael Rodriguez',
      'role': 'Project Manager, BuildRight',
      'company': 'BuildRight',
      'rating': 5,
    },
    {
      'quote':
          'Finally, an ERP system that understands modern business needs. The intuitive interface and powerful reporting are game-changers for our finance team.',
      'author': 'Emily Watson',
      'role': 'CFO, FinanceHub',
      'company': 'FinanceHub',
      'rating': 5,
    },
    {
      'quote':
          'The inventory tracking is flawless. We have reduced our processing errors by nearly 90% since switching to Jenveda.',
      'author': 'David Miller',
      'role': 'Operations Manager, LogiSource',
      'company': 'LogiSource',
      'rating': 5,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
        decoration: const BoxDecoration(color: Colors.transparent),
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 120 : 20,
          vertical: isDesktop ? 120 : 80,
        ),
        child: Column(
          children: [
            // Section Header
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CLIENT ',
                      style: TextStyle(
                        fontSize: isDesktop ? 48 : 32,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827), // Dark text
                        letterSpacing: -1,
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFD946EF), Color(0xFFF43F5E)],
                      ).createShader(bounds),
                      child: Text(
                        'TESTIMONIALS',
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

            const SizedBox(height: 80),

            // Carousel Area
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: isDesktop ? 480 : 520,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => activeIndex = index);
                    },
                    itemCount: testimonials.length,
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 1.0;
                          if (_pageController.hasClients &&
                              _pageController.position.haveDimensions) {
                            value = (_pageController.page! - index);
                            value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);
                          } else {
                            value = index == activeIndex ? 1.0 : 0.9;
                          }
                          return Center(
                            child: Transform.scale(
                              scale: value,
                              child: Opacity(opacity: value, child: child),
                            ),
                          );
                        },
                        child: _buildTestimonialCard(
                          testimonials[index],
                          !isDesktop,
                        ),
                      );
                    },
                  ),
                ),

                // Navigation Buttons (Desktop only)
                if (isDesktop) ...[
                  Positioned(
                    left: 0,
                    child: _buildNavButton(
                      icon: Icons.chevron_left,
                      onTap: () {
                        _pageController.previousPage(
                          duration: 500.ms,
                          curve: Curves.easeOutCubic,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: _buildNavButton(
                      icon: Icons.chevron_right,
                      onTap: () {
                        _pageController.nextPage(
                          duration: 500.ms,
                          curve: Curves.easeOutCubic,
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 60),

            // Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(testimonials.length, (index) {
                return GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: 500.ms,
                      curve: Curves.easeOutCubic,
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: activeIndex == index ? 40 : 12,
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: activeIndex == index
                          ? const LinearGradient(
                              colors: [Color(0xFFD946EF), Color(0xFFFB923C)],
                            )
                          : null,
                      color: activeIndex == index
                          ? null
                          : const Color(0xFFE5E7EB),
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

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(icon, color: const Color(0xFF111827), size: 32),
        ),
      ),
    ).animate().scale(delay: 500.ms);
  }

  Widget _buildTestimonialCard(
    Map<String, dynamic> testimonial,
    bool isMobile,
  ) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 5 : 20),
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      decoration: BoxDecoration(
        color: Colors.white, // Light Card
        borderRadius: BorderRadius.circular(isMobile ? 24 : 40),
        border: Border.all(color: Colors.black.withOpacity(0.05), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.05),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Icon(
              FontAwesomeIcons.quoteRight,
              size: isMobile ? 40 : 80,
              color: const Color(0xFFD946EF).withOpacity(0.1),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) {
                  return Icon(
                    Icons.star_rounded,
                    color: const Color(0xFFFBBF24),
                    size: isMobile ? 20 : 28,
                  );
                }),
              ),
              SizedBox(height: isMobile ? 24 : 32),
              Text(
                testimonial['quote'],
                textAlign: TextAlign.center,
                maxLines: isMobile ? 8 : 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 22,
                  color: const Color(0xFF374151), // Dark Quote
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: isMobile ? 32 : 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: isMobile ? 48 : 64,
                    height: isMobile ? 48 : 64,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFD946EF), Color(0xFFFB923C)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(isMobile ? 12 : 20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD946EF).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        (testimonial['author'] as String).substring(0, 1),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isMobile ? 20 : 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          testimonial['author'],
                          style: TextStyle(
                            color: const Color(0xFF111827), // Dark Author
                            fontWeight: FontWeight.w900,
                            fontSize: isMobile ? 16 : 20,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          testimonial['role'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFF6B7280), // Grey Role
                            fontSize: isMobile ? 13 : 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
