import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:async';

class InterfaceShowcaseSection extends StatefulWidget {
  const InterfaceShowcaseSection({super.key});

  @override
  State<InterfaceShowcaseSection> createState() =>
      _InterfaceShowcaseSectionState();
}

class _InterfaceShowcaseSectionState extends State<InterfaceShowcaseSection> {
  bool _isVisible = false;
  late PageController _pageController;
  int _currentPage = 2; // Start in middle
  Timer? _timer;

  final List<String> _images = [
    'assets/images/1.jpeg',
    'assets/images/2.jpeg',
    'assets/images/3.jpeg',
    'assets/images/4.jpeg',
    'assets/images/5.jpeg',
    'assets/images/6.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.20, // Reduced width for slimmer look
      initialPage: 1000, // Start in middle for infinite scrolling
    );
    // Timer started via visibility detector
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutQuart,
        );
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _stopTimer();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    // Adjust viewport fraction for responsiveness
    final targetFraction = isDesktop ? 0.20 : 0.6;

    // Re-initialize controller if viewport fraction needs to change (e.g. resize)
    // Note: We check against the current controller's fraction.
    // This allows proper resizing between Mobile and Desktop modes.
    if (_pageController.viewportFraction != targetFraction) {
      final oldPage = _pageController.hasClients
          ? _pageController.page?.round() ?? 1000
          : 1000;
      _pageController = PageController(
        viewportFraction: targetFraction,
        initialPage: oldPage,
      );
    }

    return VisibilityDetector(
      key: const Key('interface-showcase-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.4) {
          if (!_isVisible) setState(() => _isVisible = true);
          _startTimer();
        } else if (info.visibleFraction < 0.1) {
          if (_isVisible)
            setState(() => _isVisible = false); // Reset for replay
          _stopTimer();
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          children: [
            // Header
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Beautiful ',
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
                        'interface',
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
                .fadeIn()
                .slideY(begin: 0.3, end: 0),

            const SizedBox(height: 60),

            // Carousel
            SizedBox(
              height: isDesktop ? 600 : 470,
              child: PageView.builder(
                controller: _pageController,
                itemCount: null, // Infinite scrolling
                onPageChanged: (index) {
                  setState(() => _currentPage = index % _images.length);
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final realIndex = index % _images.length;
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 0.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                      } else {
                        value = 0.0;
                      }

                      // Enhanced Scale Effect: "Big Pop Up"
                      // 1.0 (Active) vs 0.7 (Inactive)
                      final scale = (1 - (value.abs() * 0.4)).clamp(0.7, 1.0);
                      final isActive = index == _currentPage;

                      return Center(
                        child: Transform.scale(
                          scale: scale,
                          child: Opacity(
                            opacity: (1 - (value.abs() * 0.5)).clamp(0.4, 1.0),
                            child: _PhoneMockup(
                              imagePath: _images[realIndex],
                              isActive: isActive,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 40),

            // Pagination Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_images.length, (index) {
                final isActive = index == _currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: isActive ? 12 : 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFFD946EF)
                        : Colors.grey.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhoneMockup extends StatelessWidget {
  final String imagePath;
  final bool isActive;

  const _PhoneMockup({required this.imagePath, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(8), // Thinner bezel
        decoration: BoxDecoration(
          color: const Color(0xFF121212), // Darker, sleeker bezel
          borderRadius: BorderRadius.circular(48),
          border: Border.all(
            color: const Color(0xFF333333), // Metallic rim
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40), // Logic screen radius
          child: Stack(
            children: [
              // Screen Content
              Image.asset(
                imagePath,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  );
                },
              ),

              // Dynamic Island
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 90,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              // Glass reflection overlay (subtle)
              IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.08),
                        Colors.transparent,
                        Colors.white.withOpacity(0.05),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
