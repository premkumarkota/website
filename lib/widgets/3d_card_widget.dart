import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:math' as math;

// Modified Card3D that works with carousel
class Card3D extends StatefulWidget {
  final Color color;
  final IconData icon;
  final String title;
  final int delay;
  final String? imageUrl; // Optional image

  const Card3D({
    Key? key,
    required this.color,
    required this.icon,
    required this.title,
    required this.delay,
    this.imageUrl,
  }) : super(key: key);

  @override
  State<Card3D> createState() => _Card3DState();
}

class _Card3DState extends State<Card3D> with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late final AnimationController _autoController;

  @override
  void initState() {
    super.initState();
    _autoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _autoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedBuilder(
        animation: _autoController,
        builder: (context, child) {
          final t = _autoController.value * 2 * math.pi;
          final autoFloatY = math.sin(t) * 8.0;

          return Transform.translate(
            offset: Offset(0.0, autoFloatY),
            child: child,
          );
        },
        child:
            AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  transform: Matrix4.identity()
                    ..translate(0.0, isHovered ? -20.0 : 0.0, 0.0),
                  child: Container(
                    width: 400, // Increased width
                    height: 650, // Increased height
                    decoration: BoxDecoration(
                      color: const Color(0xFF1a1a1a), // Simple dark background
                      borderRadius: BorderRadius.circular(24), // Added curves
                      border: Border.all(
                        color: widget.color.withOpacity(0.5),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.color.withOpacity(
                            isHovered ? 0.4 : 0.2,
                          ),
                          blurRadius: isHovered ? 40 : 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24), // Added curves
                      child: Stack(
                        children: [
                          // Background image if provided
                          if (widget.imageUrl != null)
                            Positioned.fill(
                              child: Image.network(
                                widget.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(color: Colors.black),
                              ),
                            ),

                          // Subtle dark overlay to make text readable
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.1),
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(
                                    widget.icon,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  width: 60,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: widget.color,
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
      ),
    );
  }
}

// NEW: 3D Carousel Wrapper
class Card3DCarousel extends StatefulWidget {
  final List<CardData>? cards;
  final double height;
  final bool showIndicators;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final Curve autoPlayCurve;
  final double focusedScale;
  final double sideScale;
  final double sideOpacity;
  final double maxFlipAngle;

  const Card3DCarousel({
    Key? key,
    this.cards,
    this.height = 450,
    this.showIndicators = false,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 600),
    this.autoPlayCurve = Curves.easeInOut,
    this.focusedScale = 1.0,
    this.sideScale = 0.8,
    this.sideOpacity = 0.4,
    this.maxFlipAngle = 1.2, // Rotation for the flip effect
  }) : super(key: key);

  @override
  State<Card3DCarousel> createState() => _Card3DCarouselState();
}

class _Card3DCarouselState extends State<Card3DCarousel> {
  late PageController _pageController;
  double _currentPage = 0.0;
  Timer? _autoTimer;
  int _initialPage = 0;

  List<CardData> get _cards {
    return widget.cards ?? const <CardData>[];
  }

  @override
  void initState() {
    super.initState();
    _initialPage = _cards.isEmpty ? 0 : (_cards.length * 1000);
    _currentPage = _initialPage.toDouble();
    _pageController = PageController(
      initialPage: _initialPage,
      viewportFraction: 0.6, // Adjusted to see sides
    );
    _pageController.addListener(() {
      if (mounted) {
        setState(() {
          _currentPage = _pageController.page ?? 0.0;
        });
      }
    });

    _startAutoPlay();
  }

  @override
  void didUpdateWidget(covariant Card3DCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.autoPlay != widget.autoPlay ||
        oldWidget.autoPlayInterval != widget.autoPlayInterval ||
        (oldWidget.cards?.length ?? 0) != (_cards.length)) {
      _startAutoPlay();
    }
  }

  void _startAutoPlay() {
    _autoTimer?.cancel();
    _autoTimer = null;

    if (!widget.autoPlay) return;
    if (_cards.length < 2) return;

    _autoTimer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (!mounted) return;
      if (!_pageController.hasClients) return;

      final page =
          _pageController.page ?? _pageController.initialPage.toDouble();
      final current = page.round();
      final next = current + 1;
      _pageController.animateToPage(
        next,
        duration: widget.autoPlayAnimationDuration,
        curve: widget.autoPlayCurve,
      );
    });
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: _cards.isEmpty ? 0 : null,
            itemBuilder: (context, index) {
              return _build3DCarouselCard(context, index);
            },
          ),
          if (widget.showIndicators && _cards.isNotEmpty)
            Positioned(
              bottom: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_cards.length, (index) {
                  final activeIndex = (_currentPage.round() % _cards.length)
                      .abs();
                  final isActive = activeIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFFD946EF)
                          : const Color(0xFFD946EF).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }

  Widget _build3DCarouselCard(BuildContext context, int index) {
    final page = _currentPage;
    final delta = index - page;

    // Translation logic to create the centered carousel look
    final t = delta.abs();
    final opacity = (1.0 - t * 0.6).clamp(0.0, 1.0);
    final scale = (1.0 - t * 0.2).clamp(0.0, 1.0);

    // Flip rotation logic
    final rotation = -delta * widget.maxFlipAngle;

    // Horizontal translation to push side cards away from the center card
    // creating a more "circular" or "door-like" carousel effect
    final translationX = delta * 70.0;

    return Center(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // Perspective
          ..translate(translationX)
          ..rotateY(rotation),
        child: Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: Card3D(
              color: _cards[index % _cards.length].color,
              icon: _cards[index % _cards.length].icon,
              title: _cards[index % _cards.length].title,
              imageUrl: _cards[index % _cards.length].imageUrl,
              delay: 0,
            ),
          ),
        ),
      ),
    );
  }
}

// Data class for cards
class CardData {
  final Color color;
  final IconData icon;
  final String title;
  final String imageUrl;

  const CardData({
    required this.color,
    required this.icon,
    required this.title,
    required this.imageUrl,
  });
}

// EXAMPLE USAGE:
class ExamplePage extends StatelessWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '3D Card Carousel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            // Use the carousel
            const Card3DCarousel(),
            const SizedBox(height: 40),
            const Text(
              'Swipe to rotate cards',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
