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
      if (mounted) {
        setState(() => _isVisible = true);
        _startAutoPlay();
      }
    } else if (info.visibleFraction < 0.1) {
      if (mounted && _isVisible) {
        setState(() => _isVisible = false); // RESET ANIMATION
        _stopAutoPlay();
      }
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
    final sectionHeight = isDesktop
        ? 750.0
        : 800.0; // Increased height to fit larger cards

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
          Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
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

              // Flip/Rotate Calculation
              final dist = value.abs();
              final rotation =
                  value *
                  -0.4; // Rotate based on position (negative for natural left-flip)

              // Parallax Flow
              final parallaxOffset = value * 0.8;

              // Opacity
              final opacity = (1.0 - (dist * 0.3)).clamp(0.0, 1.0);

              // Scale correction (keep active card prominent)
              final scale = 1.0 - (dist * 0.1);

              return Center(
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0015) // Strong perspective
                    ..rotateY(rotation) // The Flip
                    ..scale(scale, scale),
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
    final cardWidth = isDesktop ? 400.0 : size.width * 0.85;
    final cardHeight = isDesktop
        ? 620.0
        : 680.0; // Increased to 680 to fix overflow

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuart,
        width: cardWidth,
        height: cardHeight,
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -10.0 : 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: _isHovered ? 50 : 30,
              offset: Offset(0, _isHovered ? 20 : 10),
            ),
            if (_isHovered)
              BoxShadow(
                color: widget.data.gradient.colors.first.withOpacity(0.2),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              Column(
                children: [
                  // 1. Top Image Section (45%)
                  SizedBox(
                    height: cardHeight * 0.45,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Parallax/Scale Image
                        AnimatedScale(
                          scale: _isHovered ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeOutCubic,
                          child: Image.network(
                            widget.data.image,
                            fit: BoxFit.cover,
                            alignment: Alignment(
                              widget.parallaxOffset * 0.5,
                              0,
                            ),
                            errorBuilder: (context, error, stack) => Container(
                              decoration: BoxDecoration(
                                gradient: widget.data.gradient,
                              ),
                            ),
                          ),
                        ),
                        // Dark overlay for text contrast on top
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.6],
                            ),
                          ),
                        ),
                        // Branding
                        Positioned(
                          top: 24,
                          left: 24,
                          child: Text(
                            'Jenveda',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        // Tag
                        Positioned(
                          top: 24,
                          right: 24,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(20),
                              backgroundBlendMode: BlendMode.overlay,
                            ),
                            child: const Text(
                              'ENTERPRISE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2. Bottom Content Section (55%)
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                        isDesktop ? 32 : 20,
                        isDesktop ? 40 : 16, // Reduced top padding
                        isDesktop ? 32 : 20,
                        isDesktop ? 32 : 16, // Reduced bottom padding
                      ),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title Group
                          Text(
                            'Explore',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 22,
                              color: const Color(0xFF6B7280),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.data.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: isDesktop ? 28 : 22,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF111827),
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.data.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF6B7280),
                              height: 1.5,
                            ),
                          ),

                          const Spacer(),

                          // Features List
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: widget.data.features.take(2).map((
                                feature,
                              ) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_rounded,
                                        size: 18,
                                        color:
                                            widget.data.gradient.colors.first,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          feature,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF374151),
                                          ),
                                        ),
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
                  ),
                ],
              ),

              // 3. Floating Icon
              Positioned(
                top: (cardHeight * 0.45) - 32, // Center on the seam
                right: 32,
                child:
                    Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            gradient: widget.data.gradient,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: widget.data.gradient.colors.first
                                    .withOpacity(0.4),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                              const BoxShadow(
                                color: Colors.white,
                                blurRadius: 0,
                                spreadRadius: 4, // White border effect
                              ),
                            ],
                          ),
                          child: Icon(
                            widget.data.icon,
                            color: Colors.white,
                            size: 28,
                          ),
                        )
                        .animate(target: _isHovered ? 1 : 0)
                        .scale(end: const Offset(1.1, 1.1), duration: 200.ms),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// End of file
