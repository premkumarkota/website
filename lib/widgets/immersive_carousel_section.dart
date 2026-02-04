import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:async';

/// Premium 3D Carousel Section - Auto-sliding cards with parallax background
class ImmersiveCarouselSection extends StatefulWidget {
  const ImmersiveCarouselSection({super.key});

  @override
  State<ImmersiveCarouselSection> createState() =>
      _ImmersiveCarouselSectionState();
}

class _ImmersiveCarouselSectionState extends State<ImmersiveCarouselSection>
    with TickerProviderStateMixin {
  bool _isVisible = false;
  int _currentIndex = 0;
  late PageController _pageController;
  Timer? _autoPlayTimer;

  // Card data
  final List<CardData> _cards = [
    CardData(
      title: 'Enterprise Platform',
      subtitle: 'Unified Solutions for Modern Business',
      description: 'All business tools in one ecosystem',
      features: ['HR Management', 'Real-time Analytics', 'Unlimited Access'],
      gradient: const LinearGradient(
        colors: [Color(0xFFD946EF), Color(0xFFFB923C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      icon: Icons.business_center_rounded,
      image:
          'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=600&h=900&q=80',
    ),
    CardData(
      title: 'HR Management',
      subtitle: 'Complete Workforce Solution',
      description: 'Streamline employee management',
      features: ['Employee Records', 'Payroll System', 'Leave Management'],
      gradient: const LinearGradient(
        colors: [Color(0xFFD946EF), Color(0xFF9333EA)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      icon: Icons.people_alt_rounded,
      image:
          'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=600&h=900&q=80',
    ),
    CardData(
      title: 'Project Management',
      subtitle: 'Agile Delivery Excellence',
      description: 'Track projects from start to finish',
      features: ['Task Tracking', 'Team Collaboration', 'Timeline View'],
      gradient: const LinearGradient(
        colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      icon: Icons.task_alt_rounded,
      image:
          'https://images.unsplash.com/photo-1531403009284-440f080d1e12?w=600&h=900&q=80',
    ),
    CardData(
      title: 'Finance & Accounting',
      subtitle: 'Financial Clarity & Control',
      description: 'Streamline financial operations',
      features: ['Invoicing', 'Expense Tracking', 'Financial Reports'],
      gradient: const LinearGradient(
        colors: [Color(0xFF10B981), Color(0xFF059669)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      icon: Icons.account_balance_rounded,
      image:
          'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=600&h=900&q=80',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Start in the middle for infinite scrolling sensation (left/right)
    _pageController = PageController(viewportFraction: 0.75, initialPage: 5000);
    _currentIndex = 0; // Initialize visual index
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.3 && !_isVisible) {
      setState(() => _isVisible = true);
      _startAutoPlay();
    } else if (info.visibleFraction < 0.1 && _isVisible) {
      setState(() => _isVisible = false);
      _stopAutoPlay();
    }
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted && _pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 1200),
          curve: Curves.fastLinearToSlowEaseIn, // Very "liquid" feel
        );
      }
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1100;
    final sectionHeight = isDesktop ? 750.0 : 650.0;

    return VisibilityDetector(
      key: const Key('immersive-carousel-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: SizedBox(
        width: double.infinity,
        height: sectionHeight,
        child: Column(
          children: [
            const SizedBox(height: 60),

            // Header
            _buildHeader(isDesktop),

            const SizedBox(height: 40),

            // 3D Card Carousel
            Expanded(child: _build3DCardCarousel(isDesktop)),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDesktop) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80 : 24),
      child: Column(
        children: [
          Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'NEXT-GEN ',
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
                      'BUSINESS INTELLIGENCE',
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
              .animate(target: _isVisible ? 1 : 0)
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.5, end: 0),
        ],
      ),
    );
  }

  Widget _build3DCardCarousel(bool isDesktop) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification &&
            notification.dragDetails != null) {
          _stopAutoPlay();
        } else if (notification is ScrollEndNotification) {
          _startAutoPlay();
        }
        return false;
      },
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index % _cards.length);
        },
        // Infinite items
        itemCount: null,
        itemBuilder: (context, index) {
          final realIndex = index % _cards.length;

          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 0.0;
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
              }

              // Liquid Physics Calculation
              final dist = value.abs();
              final scale = (1.0 - (dist * 0.15)).clamp(0.8, 1.0);

              // Parallax Flow
              final parallaxOffset = value * 0.5;

              // Opacity & Blur
              final opacity = (1.0 - (dist * 0.4)).clamp(0.0, 1.0);

              // Transform
              final transX = value * 20.0;
              final transY = value.abs() * 30.0;

              return Center(
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // Perspective
                    ..translate(transX, transY, 0.0)
                    ..scale(
                      scale + (0.05 * (1 - dist)),
                      scale,
                      1.0,
                    ), // Elastic scale
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: opacity,
                    child: _Premium3DCard(
                      data: _cards[realIndex],
                      isActive: realIndex == _currentIndex,
                      parallaxOffset: parallaxOffset,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Card Data Model
class CardData {
  final String title;
  final String subtitle;
  final String description;
  final List<String> features;
  final Gradient gradient;
  final IconData icon;
  final String image;

  const CardData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.features,
    required this.gradient,
    required this.icon,
    required this.image,
  });
}

// Premium Fluid Card Widget
class _Premium3DCard extends StatefulWidget {
  final CardData data;
  final bool isActive;
  final double parallaxOffset; // Controls internal image movement

  const _Premium3DCard({
    required this.data,
    required this.isActive,
    this.parallaxOffset = 0.0,
  });

  @override
  State<_Premium3DCard> createState() => _Premium3DCardState();
}

class _Premium3DCardState extends State<_Premium3DCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1100;
    // slightly wider for fluid look
    final cardWidth = isDesktop ? 480.0 : size.width * 0.85;
    final cardHeight = isDesktop ? 600.0 : 540.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuart,
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), // Softer corners
          boxShadow: [
            BoxShadow(
              color: widget.data.gradient.colors.first.withValues(alpha: 0.15),
              blurRadius: _isHovered ? 80 : 40,
              spreadRadius: _isHovered ? 10 : 0,
              offset: Offset(0, _isHovered ? 30 : 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Stack(
            children: [
              // Parallax Background Image
              // We use an effectively larger container and align it based on parallaxOffset
              Positioned.fill(
                left: -50, // Allow room to move
                right: -50,
                child: AnimatedBuilder(
                  // Use simple approach, alignment change
                  animation: AlwaysStoppedAnimation(widget.parallaxOffset),
                  builder: (context, _) {
                    // map -1.0..1.0 to Alignment x
                    return Align(
                      alignment: Alignment(
                        widget.parallaxOffset.clamp(-1.0, 1.0),
                        0,
                      ),
                      child: SizedBox(
                        width: cardWidth * 1.5, // Check this scale
                        height: cardHeight,
                        child: Image.network(
                          widget.data.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stack) => Container(
                            decoration: BoxDecoration(
                              gradient: widget.data.gradient,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // White Gradient overlay (Light Theme)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(
                          alpha: 0.0,
                        ), // Fully transparent at top to show image
                        Colors.white.withValues(
                          alpha: 0.2,
                        ), // Very light middle
                        Colors.white.withValues(
                          alpha: 0.75,
                        ), // Just enough for text readability
                      ],
                      stops: const [0.0, 0.6, 1.0],
                    ),
                  ),
                ),
              ),

              // Shimmer effect
              if (widget.isActive)
                AnimatedBuilder(
                  animation: _shimmerController,
                  builder: (context, child) {
                    return Positioned(
                      left:
                          -cardWidth +
                          (_shimmerController.value * cardWidth * 2),
                      top: 0,
                      child: Container(
                        width: cardWidth * 0.5,
                        height: cardHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white.withValues(alpha: 0.4),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

              // Content
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max, // Fill height so Spacer works
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Jenveda',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF111827),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: widget.data.gradient,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: widget.data.gradient.colors.first
                                    .withValues(alpha: 0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Text(
                            'ENTERPRISE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Spacer to push content down
                    const Spacer(),

                    // Icon
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: widget.data.gradient,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: widget.data.gradient.colors.first.withValues(
                              alpha: 0.4,
                            ),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        widget.data.icon,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    Text(
                      'Explore',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF374151),
                        fontStyle: FontStyle.italic,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      widget.data.title,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                        fontStyle: FontStyle.italic,
                        height: 1.1,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      widget.data.subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: const Color(0xFF4B5563),
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Features
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.data.features.map((feature) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: const Color(0xFF1F2937),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF10B981),
                                  size: 16,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// End of file
