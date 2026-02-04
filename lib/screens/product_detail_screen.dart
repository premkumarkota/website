import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../utils/constants.dart';
import '../widgets/animated_navbar.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({Key? key, required this.productId})
    : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _heroController;
  late Map<String, dynamic> product;

  @override
  void initState() {
    super.initState();
    _heroController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _loadProduct();
  }

  @override
  void didUpdateWidget(ProductDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.productId != oldWidget.productId) {
      setState(() {
        _loadProduct();
      });
    }
  }

  void _loadProduct() {
    product = AppData.products.firstWhere(
      (p) => p['id'] == widget.productId,
      orElse: () => AppData.products.first,
    );
  }

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const AnimatedNavbar(),

          // Hero section
          SliverToBoxAdapter(
            child: Container(
              constraints: BoxConstraints(minHeight: isDesktop ? 600 : 0),
              decoration: const BoxDecoration(color: Colors.white),
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 120 : 24,
                vertical: 60,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: isDesktop ? 6 : 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    (product['color'] as Color),
                                    (product['color'] as Color).withOpacity(
                                      0.7,
                                    ),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: (product['color'] as Color)
                                        .withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Text(
                                product['subtitle'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 800.ms)
                            .scale(begin: const Offset(0.8, 0.8)),

                        const SizedBox(height: 32),

                        Text(
                              product['title'] as String,
                              style: TextStyle(
                                fontSize: isDesktop ? 72 : 42,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF111827),
                                height: 1.05,
                                letterSpacing: -1,
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 800.ms, delay: 100.ms)
                            .slideY(begin: 0.2, end: 0),

                        const SizedBox(height: 32),

                        Text(
                              product['fullDesc'] as String,
                              style: TextStyle(
                                fontSize: isDesktop ? 20 : 16,
                                color: const Color(0xFF6B7280),
                                height: 1.6,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 800.ms, delay: 200.ms)
                            .slideY(begin: 0.2, end: 0),

                        const SizedBox(height: 48),

                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFFD946EF,
                                    ).withOpacity(0.3),
                                    blurRadius: 30,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 24,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'Start Free Trial',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.play_circle_fill,
                                size: 32,
                                color: Color(0xFF6B7280),
                              ),
                              label: const Text(
                                'Watch Product Tour',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(20),
                              ),
                            ),
                          ],
                        ).animate().fadeIn(duration: 800.ms, delay: 400.ms),
                      ],
                    ),
                  ),
                  if (isDesktop) ...[
                    const SizedBox(width: 80),
                    Expanded(flex: 5, child: _buildFloatingHeroCard()),
                  ],
                ],
              ),
            ),
          ),

          // Section Divider
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(color: Color(0xFFFAFAFA)),
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 120 : 24,
                vertical: 40,
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (product['color'] as Color),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    'EXPLORE MODULES',
                    style: TextStyle(
                      color: (product['color'] as Color),
                      fontWeight: FontWeight.w800,
                      letterSpacing: 4,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Detailed Sections or Features grid
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 120 : 24,
              vertical: 80,
            ),
            sliver: SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                          product.containsKey('detailSections')
                              ? 'Deep Dive Features'
                              : 'Key Features',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 60),

                    if (product.containsKey('detailSections'))
                      Column(
                        children: List.generate(
                          (product['detailSections'] as List).length,
                          (index) => _buildDetailSectionRow(
                            (product['detailSections'] as List)[index],
                            index,
                            isDesktop,
                          ),
                        ),
                      )
                    else
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        children: List.generate(
                          (product['features'] as List).length,
                          (index) => _buildFeatureCard(
                            (product['features'] as List)[index],
                            index,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSectionRow(
    Map<String, dynamic> section,
    int index,
    bool isDesktop,
  ) {
    final color = product['color'] as Color;
    final isReversed = index % 2 != 0;

    Widget textContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                section['icon'] as IconData,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                section['title'] as String,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF111827),
                  letterSpacing: -1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          section['description'] as String,
          style: TextStyle(
            fontSize: 18,
            color: const Color(0xFF6B7280),
            height: 1.7,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildMiniBadge('Automated', color),
            _buildMiniBadge('Real-time', color),
            _buildMiniBadge('Secure', color),
          ],
        ),
      ],
    );

    bool isHovered = false;
    Widget imageContent = StatefulBuilder(
      builder: (context, setCardState) {
        return MouseRegion(
          onEnter: (_) => setCardState(() => isHovered = true),
          onExit: (_) => setCardState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            transform: isHovered
                ? (Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(0.05)
                    ..rotateY(isReversed ? 0.05 : -0.05)
                    ..scale(1.05))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: color.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(isHovered ? 0.15 : 0.08),
                  blurRadius: 50,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Stack(
                children: [
                  Image.asset(
                    section['image'] as String,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: isDesktop ? 450 : 300,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 450,
                        color: const Color(0xFFFAFAFA),
                        child: Center(
                          child: Icon(
                            Icons.broken_image,
                            color: const Color(0xFFE5E7EB),
                            size: 64,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: isDesktop
          ? Row(
              children: [
                if (!isReversed) ...[
                  Expanded(child: textContent),
                  const SizedBox(width: 80),
                  Expanded(child: imageContent),
                ] else ...[
                  Expanded(child: imageContent),
                  const SizedBox(width: 80),
                  Expanded(child: textContent),
                ],
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [textContent, const SizedBox(height: 48), imageContent],
            ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildMiniBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildFloatingHeroCard() {
    return AnimatedBuilder(
      animation: _heroController,
      builder: (context, child) {
        final float = math.sin(_heroController.value * 2 * math.pi) * 15;
        return Transform.translate(
          offset: Offset(0, float),
          child:
              Container(
                    height: 550,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(48),
                      border: Border.all(
                        color: (product['color'] as Color).withOpacity(0.2),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (product['color'] as Color).withOpacity(0.1),
                          blurRadius: 60,
                          spreadRadius: 10,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(48),
                            child: Center(
                              child: Icon(
                                product['icon'] as IconData,
                                size: 240,
                                color: (product['color'] as Color).withOpacity(
                                  0.1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 1000.ms)
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    curve: Curves.easeOutBack,
                  ),
        );
      },
    );
  }

  Widget _buildFeatureCard(String feature, int index) {
    return Container(
          width: 300,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: (product['color'] as Color).withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: (product['color'] as Color).withOpacity(0.08),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      product['color'] as Color,
                      (product['color'] as Color).withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: (product['color'] as Color).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(Icons.check_circle, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 24),
              Text(
                feature,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: (index * 100).ms)
        .slideY(begin: 0.3, end: 0);
  }
}
