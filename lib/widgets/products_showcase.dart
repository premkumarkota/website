import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

class ProductsShowcase extends StatefulWidget {
  const ProductsShowcase({Key? key}) : super(key: key);

  @override
  State<ProductsShowcase> createState() => _ProductsShowcaseState();
}

class _ProductsShowcaseState extends State<ProductsShowcase>
    with TickerProviderStateMixin {
  bool isVisible = false;
  int hoveredIndex = -1;
  late AnimationController _floatController;

  final List<Map<String, dynamic>> products = [
    {
      'id': 'hrms',
      'title': 'HR Management',
      'subtitle': 'HRMS',
      'description':
          'Optimize your HR operations with comprehensive employee management, payroll, and self-service portals.',
      'color': const Color(0xFFD946EF),
      'icon': Icons.people,
      'features': [
        'Employee Management',
        'Leave Tracking',
        'Payroll',
        'Claims',
      ],
    },
    {
      'id': 'crm',
      'title': 'Customer Relations',
      'subtitle': 'CRM',
      'description':
          'Elevate customer relationships with lead management, opportunities, and customizable quotations.',
      'color': const Color(0xFFEC4899),
      'icon': Icons.handshake,
      'features': [
        'Lead Management',
        'Opportunities',
        'Quotations',
        'Insights',
      ],
    },
    {
      'id': 'pms',
      'title': 'Project Management',
      'subtitle': 'PMS',
      'description':
          'Boost project efficiency with planning, BOM management, task tracking, and timeline visualization.',
      'color': const Color(0xFF3B82F6),
      'icon': Icons.assignment,
      'features': [
        'Project Planning',
        'Task Tracking',
        'Invoicing',
        'Escalation',
      ],
    },
    {
      'id': 'accounting',
      'title': 'Accounting',
      'subtitle': 'Finance',
      'description':
          'Simplify financial processes with invoicing, expense tracking, reporting, and tax compliance.',
      'color': const Color(0xFF10B981),
      'icon': Icons.account_balance,
      'features': ['Sales', 'Purchases', 'Accounts', 'Reporting'],
    },
    {
      'id': 'inventory',
      'title': 'Inventory',
      'subtitle': 'Stock',
      'description':
          'Track inventory effortlessly with adjustments, stock transfers, and warehouse management.',
      'color': const Color(0xFFF59E0B),
      'icon': Icons.warehouse,
      'features': ['Stock Tracking', 'Transfers', 'Adjustments', 'Warehouse'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1100;

    return VisibilityDetector(
      key: const Key('products-showcase'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !isVisible) {
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
            // Header
            Text(
              'OUR SOLUTIONS',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFEC4899),
                letterSpacing: 4,
              ),
            ).animate(target: isVisible ? 1 : 0).fadeIn(duration: 600.ms),

            const SizedBox(height: 16),

            Text(
                  'Five Pillars of Excellence',
                  style: TextStyle(
                    fontSize: isDesktop ? 48 : 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
                .animate(target: isVisible ? 1 : 0)
                .fadeIn(duration: 600.ms, delay: 100.ms)
                .slideY(begin: 0.3, end: 0),

            const SizedBox(height: 80),

            // Products Grid
            if (isDesktop) _buildDesktopGrid() else _buildMobileList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopGrid() {
    return SizedBox(
      height: 600,
      child: Row(
        children: List.generate(products.length, (index) {
          return Expanded(
            child: AnimatedBuilder(
              animation: _floatController,
              builder: (context, child) {
                final offset =
                    math.sin(
                      (_floatController.value * 2 * math.pi) + (index * 0.5),
                    ) *
                    10;

                return GestureDetector(
                  onTap: () => context.go('/product/${products[index]['id']}'),
                  child: MouseRegion(
                    onEnter: (_) => setState(() => hoveredIndex = index),
                    onExit: (_) => setState(() => hoveredIndex = -1),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      margin: EdgeInsets.symmetric(
                        horizontal: hoveredIndex == index ? 8 : 4,
                      ),
                      transform: Matrix4.identity()
                        ..translate(
                          0.0,
                          hoveredIndex == index ? -20.0 : offset,
                          0.0,
                        )
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(hoveredIndex == index ? 0.05 : 0),
                      child: _buildProductCard(products[index], index),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMobileList() {
    return Column(
      children: List.generate(products.length, (index) {
        return GestureDetector(
          onTap: () => context.go('/product/${products[index]['id']}'),
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: _buildProductCard(products[index], index),
          ),
        );
      }),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, int index) {
    final isHovered = hoveredIndex == index;
    final color = product['color'] as Color;

    return Container(
          height: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(isHovered ? 0.3 : 0.15),
                color.withOpacity(isHovered ? 0.1 : 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: color.withOpacity(isHovered ? 0.6 : 0.3),
              width: isHovered ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(isHovered ? 0.4 : 0.2),
                blurRadius: isHovered ? 60 : 30,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Stack(
              children: [
                // Animated background pattern
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isHovered ? 1 : 0,
                    child: CustomPaint(painter: GridPainter(color: color)),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Icon container
                              Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [color, color.withOpacity(0.7)],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: color.withOpacity(0.4),
                                          blurRadius: 20,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      product['icon'] as IconData,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  )
                                  .animate(target: isVisible ? 1 : 0)
                                  .scale(
                                    duration: 600.ms,
                                    delay: (index * 100).ms,
                                    curve: Curves.elasticOut,
                                  ),

                              const SizedBox(height: 24),

                              // Subtitle
                              Text(
                                product['subtitle'] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: color,
                                  letterSpacing: 2,
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Title
                              Text(
                                product['title'] as String,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Description
                              Text(
                                product['description'] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.7),
                                  height: 1.6,
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Features
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: (product['features'] as List<String>)
                                    .map((feature) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: color.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: color.withOpacity(0.3),
                                          ),
                                        ),
                                        child: Text(
                                          feature,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: color,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    })
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // CTA Button
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color, color.withOpacity(0.8)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: color.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Explore',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .animate(target: isVisible ? 1 : 0)
        .fadeIn(duration: 800.ms, delay: (index * 100).ms)
        .slideY(begin: 0.3, end: 0);
  }
}

class GridPainter extends CustomPainter {
  final Color color;

  GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.1)
      ..strokeWidth = 1;

    const spacing = 30.0;

    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
