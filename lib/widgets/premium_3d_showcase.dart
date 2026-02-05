import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:google_fonts/google_fonts.dart';

/// Premium 3D Card Showcase Section
/// Features:
/// - Auto-sliding cards with smooth rotate flip transitions
/// - 3D Card Rotation Entry Animation
/// - Portrait fixed card - no floating/movement
/// - Smooth transitions between card views
class Premium3DShowcase extends StatefulWidget {
  const Premium3DShowcase({super.key});

  @override
  State<Premium3DShowcase> createState() => _Premium3DShowcaseState();
}

class _Premium3DShowcaseState extends State<Premium3DShowcase>
    with TickerProviderStateMixin {
  bool _isVisible = false;
  int _currentCardIndex = 0;
  bool _isAnimating = false;
  Timer? _autoSlideTimer;

  // Controllers
  late AnimationController _entranceController;
  late AnimationController _flipController;

  // Animations
  late Animation<double> _entranceRotation;
  late Animation<double> _entranceScale;
  late Animation<double> _entranceOpacity;

  // Card data for Jenveda - 3 cards that auto-rotate
  final List<CardViewData> _cards = [
    CardViewData(
      backgroundImage:
          'https://images.unsplash.com/photo-1497366216548-37526070297c?w=1200&q=80',
      title: 'Explore\nJenveda\nEnterprise Suite',
      subtitle: 'Next-Gen ERP Solutions',
      features: ['HR Management', 'Real-time Analytics', 'Unlimited Access'],
    ),
    CardViewData(
      backgroundImage:
          'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=1200&q=80',
      title: 'Powerful\nAnalytics\nDashboard',
      subtitle: 'Data-Driven Insights',
      features: ['Business Intelligence', 'Custom Reports', 'AI Predictions'],
    ),
    CardViewData(
      backgroundImage:
          'https://images.unsplash.com/photo-1551434678-e076c223a692?w=1200&q=80',
      title: 'Complete\nBusiness\nManagement',
      subtitle: 'All-in-One Platform',
      features: ['Finance Module', 'Inventory Control', 'CRM Integration'],
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Entrance animation - 800ms with cubic-bezier(0.65, 0, 0.35, 1)
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Rotation: -30deg (-0.523 rad) → 0
    _entranceRotation = Tween<double>(begin: -0.523, end: 0.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Cubic(0.65, 0, 0.35, 1),
      ),
    );

    // Scale: 0.9 → 1.0
    _entranceScale = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Cubic(0.65, 0, 0.35, 1),
      ),
    );

    // Opacity: 0 → 1
    _entranceOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOut),
    );

    // Flip controller - 800ms for smooth rotate flip
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _entranceController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.3 && !_isVisible) {
      if (!mounted) return;
      setState(() => _isVisible = true);
      // Start entrance after 300ms delay
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _entranceController.forward();
          // Start auto-slide after entrance completes
          Future.delayed(const Duration(milliseconds: 1500), () {
            _startAutoSlide();
          });
        }
      });
    } else if (info.visibleFraction < 0.1 && _isVisible) {
      if (!mounted) return;
      setState(() => _isVisible = false); // Reset visibility state
      _entranceController.reset(); // Reset animation controller
      _autoSlideTimer?.cancel();
    }
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted && !_isAnimating) {
        _navigateToNextCard();
      }
    });
  }

  Future<void> _navigateToNextCard() async {
    if (_isAnimating) return;

    setState(() => _isAnimating = true);

    // Flip out (0 -> 0.5) - Rotates 0 to 90 degrees
    await _flipController.animateTo(0.5);

    if (mounted) {
      // Change content while card is invisible (at 90 degrees)
      setState(() {
        _currentCardIndex = (_currentCardIndex + 1) % _cards.length;
      });
    }

    // Flip in (0.5 -> 1.0) - Rotates -90 to 0 degrees
    if (mounted) {
      await _flipController.animateTo(1.0);

      // Reset silently
      _flipController.reset();
      setState(() => _isAnimating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1100;
    final isTablet = size.width > 768 && size.width <= 1100;

    // Card dimensions
    final cardWidth = isDesktop ? 420.0 : (isTablet ? 360.0 : 320.0);

    return VisibilityDetector(
      key: const Key('premium-3d-showcase-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.transparent, // Transparent to show FluidBackground
        ),
        child: Container(
          // Removed internal overlay and background image
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 80 : (isTablet ? 40 : 20),
            vertical: isDesktop ? 60 : 40,
          ),
          child: isDesktop
              ? _buildDesktopLayout(cardWidth)
              : _buildMobileLayout(cardWidth, isTablet),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(double cardWidth) {
    const cardHeight = 580.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: Text Content
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSectionHeader(true),
              const SizedBox(height: 48),
              _buildLeftContent(true),
            ],
          ),
        ),
        const SizedBox(width: 60),
        // Right: 3D Card - Fixed, no movement
        SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: _build3DCard(cardWidth, cardHeight),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(double cardWidth, bool isTablet) {
    final cardHeight = isTablet ? 520.0 : 480.0;

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionHeader(false),
          const SizedBox(height: 32),
          SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: _build3DCard(cardWidth, cardHeight),
          ),
          const SizedBox(height: 32),
          _buildLeftContent(false),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(bool isDesktop) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        // Badge
        Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFD946EF).withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xFFD946EF).withOpacity(0.08),
              ),
              child: const Text(
                'IMMERSIVE EXPERIENCE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFD946EF),
                  letterSpacing: 3,
                ),
              ),
            )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.5, end: 0),

        const SizedBox(height: 24),

        // Title
        Text(
              'Discover The Future\nOf Enterprise Solutions',
              textAlign: isDesktop ? TextAlign.left : TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: isDesktop ? 48 : 28,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827),
                height: 1.15,
                fontStyle: FontStyle.italic,
              ),
            )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 800.ms, delay: 200.ms)
            .slideY(begin: 0.3, end: 0),

        const SizedBox(height: 12),

        // Subtitle
        Container(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Text(
                'Experience seamless business intelligence with our revolutionary platform.',
                textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: const Color(0xFF4B5563),
                  height: 1.5,
                ),
              ),
            )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 800.ms, delay: 400.ms)
            .slideY(begin: 0.3, end: 0),
      ],
    );
  }

  Widget _buildLeftContent(bool isDesktop) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        // Feature Items
        _buildFeatureItem(
          icon: Icons.layers_rounded,
          title: 'Unified Platform',
          description: 'All business tools in one ecosystem',
          delay: 500,
        ),
        const SizedBox(height: 18),
        _buildFeatureItem(
          icon: Icons.speed_rounded,
          title: 'Real-Time Analytics',
          description: 'Instant 3D data visualization',
          delay: 650,
        ),
        const SizedBox(height: 18),
        _buildFeatureItem(
          icon: Icons.security_rounded,
          title: 'Enterprise Security',
          description: 'Bank-grade data protection',
          delay: 800,
        ),

        const SizedBox(height: 32),

        // CTA Button
        _buildGradientButton()
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 1000.ms)
            .slideY(begin: 0.3, end: 0),
      ],
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
    required int delay,
  }) {
    return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFD946EF).withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFD946EF).withOpacity(0.25),
                ),
              ),
              child: Icon(icon, color: const Color(0xFFD946EF), size: 20),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ],
        )
        .animate(target: _isVisible ? 1 : 0)
        .fadeIn(duration: 600.ms, delay: delay.ms)
        .slideX(begin: -0.15, end: 0);
  }

  Widget _buildGradientButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFD946EF), Color(0xFFFB923C)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFD946EF).withOpacity(0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Explore Platform',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _build3DCard(double width, double height) {
    return AnimatedBuilder(
      animation: Listenable.merge([_entranceController, _flipController]),
      builder: (context, child) {
        // Entrance animation values
        final entranceRotY = _entranceRotation.value;
        final entranceScale = _entranceScale.value;
        final entranceOpacity = _entranceOpacity.value;

        // Flip animation - smooth rotate flip
        double flipRotY = 0.0;
        double flipScale = 1.0;
        double flipOpacity = 1.0;

        if (_flipController.isAnimating || _flipController.value > 0) {
          final progress = _flipController.value;
          if (progress < 0.5) {
            // Exit: rotate out to right (0 → 90deg)
            final exitProgress = Curves.easeIn.transform(progress * 2);
            flipRotY = exitProgress * 1.5708; // 90 degrees in radians
            flipScale = 1.0 - (exitProgress * 0.1);
            flipOpacity = 1.0 - (exitProgress * 0.8);
          } else {
            // Entry: rotate in from left (-90deg → 0)
            final entryProgress = Curves.easeOut.transform(
              (progress - 0.5) * 2,
            );
            flipRotY = -1.5708 + (entryProgress * 1.5708);
            flipScale = 0.9 + (entryProgress * 0.1);
            flipOpacity = 0.2 + (entryProgress * 0.8);
          }
        }

        // Combine rotations (only entrance if not flipping)
        final totalRotY = _flipController.value > 0 ? flipRotY : entranceRotY;
        final totalScale = _flipController.value > 0
            ? flipScale
            : entranceScale;
        final totalOpacity = _flipController.value > 0
            ? flipOpacity
            : entranceOpacity;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective
            ..rotateY(totalRotY)
            ..scale(totalScale, totalScale, 1.0),
          child: Opacity(
            opacity: totalOpacity.clamp(0.0, 1.0),
            child: _PortraitCard(
              key: ValueKey(
                _currentCardIndex,
              ), // Force rebuild to trigger entry animations per card
              cardData: _cards[_currentCardIndex],
              width: width,
              height: height,
            ),
          ),
        );
      },
    );
  }
}

// Card Data Model
class CardViewData {
  final String backgroundImage;
  final String title;
  final String subtitle;
  final List<String> features;

  const CardViewData({
    required this.backgroundImage,
    required this.title,
    required this.subtitle,
    required this.features,
  });
}

/// Portrait Card - Fixed position, no movement
class _PortraitCard extends StatefulWidget {
  final CardViewData cardData;
  final double width;
  final double height;

  const _PortraitCard({
    super.key,
    required this.cardData,
    required this.width,
    required this.height,
  });

  @override
  State<_PortraitCard> createState() => _PortraitCardState();
}

class _PortraitCardState extends State<_PortraitCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.5 : 0.35),
              blurRadius: _isHovered ? 50 : 35,
              offset: Offset(0, _isHovered ? 25 : 18),
            ),
            BoxShadow(
              color: const Color(
                0xFFD946EF,
              ).withOpacity(_isHovered ? 0.25 : 0.1),
              blurRadius: 40,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.network(
                  widget.cardData.backgroundImage,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: const Color(0xFF1a1a2e),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFD946EF),
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stack) =>
                      Container(color: const Color(0xFF1a1a2e)),
                ),
              ),

              // Dark Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.95),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
              ),

              // Card Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with logo and icons
                    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Jenveda',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF111827),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Row(
                              children: [
                                _IconButton(icon: Icons.menu_rounded),
                                const SizedBox(width: 8),
                                _IconButton(icon: Icons.dashboard_rounded),
                              ],
                            ),
                          ],
                        )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 200.ms)
                        .slideY(begin: -0.2, end: 0),

                    const Spacer(),

                    // Hero Title
                    ...widget.cardData.title
                        .split('\n')
                        .map(
                          (line) =>
                              Text(
                                    line,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 38,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF111827),
                                      fontStyle: FontStyle.italic,
                                      height: 1.1,
                                    ),
                                  )
                                  .animate()
                                  .fadeIn(duration: 600.ms, delay: 400.ms)
                                  .slideX(begin: -0.1, end: 0),
                        ),

                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                          widget.cardData.subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xFF4B5563),
                            fontWeight: FontWeight.w400,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 600.ms)
                        .slideX(begin: -0.1, end: 0),

                    const SizedBox(height: 24),

                    // Form Preview Section
                    Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.05),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...widget.cardData.features.asMap().entries.map(
                                (entry) => Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        entry.key <
                                            widget.cardData.features.length - 1
                                        ? 12
                                        : 0,
                                  ),
                                  child: _FormField(
                                    label: [
                                      'MODULE',
                                      'FEATURE',
                                      'ACCESS',
                                    ][entry.key],
                                    value: entry.value,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              _CardButton(label: 'EXPLORE', onTap: () {}),
                            ],
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 800.ms)
                        .slideY(begin: 0.1, end: 0),
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

// Reusable Components

class _IconButton extends StatelessWidget {
  final IconData icon;

  const _IconButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, color: const Color(0xFF4B5563), size: 16),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final String value;

  const _FormField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6B7280),
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF111827),
                  ),
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: const Color(0xFF9CA3AF),
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(height: 1, color: Colors.black.withOpacity(0.05)),
      ],
    );
  }
}

class _CardButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _CardButton({required this.label, required this.onTap});

  @override
  State<_CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<_CardButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(
                0xFF111827,
              ).withOpacity(_isHovered ? 0.4 : 0.1),
            ),
            borderRadius: BorderRadius.circular(4),
            color: _isHovered
                ? const Color(0xFF111827).withOpacity(0.05)
                : Colors.transparent,
          ),
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -2.0 : 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_rounded,
                color: Color(0xFF111827),
                size: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
