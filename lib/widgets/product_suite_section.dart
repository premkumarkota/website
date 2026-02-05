import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'dart:math' as math;

/// Product Suite Section - Separate section showing product cards
/// This is Section 3 (after Enterprise Platform)
class ProductSuiteSection extends StatefulWidget {
  const ProductSuiteSection({super.key});

  @override
  State<ProductSuiteSection> createState() => _ProductSuiteSectionState();
}

class _ProductSuiteSectionState extends State<ProductSuiteSection>
    with TickerProviderStateMixin {
  bool _isVisible = false;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 && !_isVisible) {
      setState(() => _isVisible = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1100;
    final isTablet = size.width > 768 && size.width <= 1100;

    return VisibilityDetector(
      key: const Key('product-suite-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80 : 24,
          vertical: isDesktop ? 100 : 60,
        ),
        // Transparent background - uses the fixed background from landing screen
        color: Colors.transparent,
        child: Column(
          children: [
            // Section Header
            _buildSectionHeader(isDesktop),

            SizedBox(height: isDesktop ? 80 : 50),

            // Product Cards Grid
            _buildProductCards(isDesktop, isTablet),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(bool isDesktop) {
    return Column(
      children: [
        Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'COMPREHENSIVE ',
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
                    'ERP SOLUTIONS',
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
        const SizedBox(height: 24),
        const SizedBox(height: 16),
        Container(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 600 : double.infinity,
          ),
          child:
              Text(
                    'Streamline every aspect of your business with our integrated suite of enterprise solutions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isDesktop ? 18 : 16,
                      color: const Color(0xFF4B5563), // Grey text
                      height: 1.6,
                    ),
                  )
                  .animate(target: _isVisible ? 1 : 0)
                  .fadeIn(duration: 800.ms, delay: 200.ms)
                  .slideY(begin: 0.3, end: 0),
        ),
      ],
    );
  }

  Widget _buildProductCards(bool isDesktop, bool isTablet) {
    final products = [
      ProductData(
        title: 'HR Management',
        description: 'Complete workforce management solution',
        icon: Icons.people_alt_rounded,
        color: const Color(0xFFD946EF),
      ),
      ProductData(
        title: 'Project Management',
        description: 'Track projects from start to finish',
        icon: Icons.task_alt_rounded,
        color: const Color(0xFF3B82F6),
      ),
      ProductData(
        title: 'Finance & Accounting',
        description: 'Streamline financial operations',
        icon: Icons.account_balance_rounded,
        color: const Color(0xFF10B981),
      ),
      ProductData(
        title: 'Inventory Control',
        description: 'Real-time stock management',
        icon: Icons.inventory_2_rounded,
        color: const Color(0xFFF59E0B),
      ),
    ];

    if (isDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: products.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _ProductCard(
              data: entry.value,
              delay: entry.key * 100,
              isVisible: _isVisible,
            ),
          );
        }).toList(),
      );
    } else if (isTablet) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 24,
        runSpacing: 24,
        children: products.asMap().entries.map((entry) {
          return _ProductCard(
            data: entry.value,
            delay: entry.key * 100,
            isVisible: _isVisible,
          );
        }).toList(),
      );
    } else {
      // Mobile - 2 column grid
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 16,
        runSpacing: 16,
        children: products.asMap().entries.map((entry) {
          return _ProductCard(
            data: entry.value,
            delay: entry.key * 100,
            isVisible: _isVisible,
            isMobile: true,
          );
        }).toList(),
      );
    }
  }
}

class ProductData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const ProductData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class _ProductCard extends StatefulWidget {
  final ProductData data;
  final int delay;
  final bool isVisible;
  final bool isMobile;

  const _ProductCard({
    required this.data,
    required this.delay,
    required this.isVisible,
    this.isMobile = false,
  });

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000 + (widget.delay * 5)),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Increased card dimensions for better visibility
    final cardWidth = widget.isMobile ? 170.0 : 260.0;
    final cardHeight = widget.isMobile ? 260.0 : 350.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _floatController,
        builder: (context, child) {
          final float = math.sin(_floatController.value * math.pi) * 6;
          return Transform.translate(offset: Offset(0, float), child: child);
        },
        child:
            AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  width: cardWidth,
                  height: cardHeight,
                  transform: Matrix4.identity()
                    ..translate(0.0, _isHovered ? -12.0 : 0.0),
                  decoration: BoxDecoration(
                    color: Colors.white, // Light card bg
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: widget.data.color.withOpacity(
                        _isHovered ? 0.3 : 0.05, // Subtle border
                      ),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.data.color.withOpacity(
                          _isHovered ? 0.25 : 0.05,
                        ),
                        blurRadius: _isHovered ? 40 : 20,
                        offset: Offset(0, _isHovered ? 20 : 10),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05), // Light shadow
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(widget.isMobile ? 12 : 32),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon container
                          Container(
                            padding: EdgeInsets.all(widget.isMobile ? 12 : 24),
                            decoration: BoxDecoration(
                              color: widget.data.color.withOpacity(
                                0.08,
                              ), // Softer tint
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: widget.data.color.withOpacity(0.15),
                              ),
                            ),
                            child: Icon(
                              widget.data.icon,
                              color: widget.data.color,
                              size: widget.isMobile ? 32 : 54,
                            ),
                          ),
                          SizedBox(height: widget.isMobile ? 12 : 28),
                          // Title
                          Text(
                            widget.data.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF111827), // Dark Title
                              fontSize: widget.isMobile ? 16 : 22,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                            ),
                          ),
                          // Description & accent bar - only on desktop
                          if (!widget.isMobile) ...[
                            const SizedBox(height: 14),
                            Text(
                              widget.data.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(
                                  0xFF6B7280,
                                ), // Grey description
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: 50,
                              height: 4,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    widget.data.color,
                                    widget.data.color.withOpacity(0.5),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                )
                .animate(target: widget.isVisible ? 1 : 0)
                .fadeIn(duration: 700.ms, delay: (300 + widget.delay).ms)
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  curve: Curves.easeOutBack,
                  delay: (300 + widget.delay).ms,
                ),
      ),
    );
  }
}
