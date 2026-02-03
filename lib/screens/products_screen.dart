import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../utils/constants.dart';
import '../widgets/animated_navbar.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      body: CustomScrollView(
        slivers: [
          const AnimatedNavbar(),

          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 120 : 24,
              vertical: 80,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(
                    'OUR SOLUTIONS',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF7C3AED),
                      letterSpacing: 4,
                    ),
                  ).animate().fadeIn(duration: 600.ms),

                  const SizedBox(height: 24),

                  Text(
                        'Five Pillars of Excellence',
                        style: TextStyle(
                          fontSize: isDesktop ? 48 : 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 100.ms)
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 80),

                  // Products list
                  ...List.generate(AppData.products.length, (index) {
                    return _buildProductItem(
                      AppData.products[index],
                      index,
                      isDesktop,
                      context,
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(
    Map<String, dynamic> product,
    int index,
    bool isDesktop,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => context.go('/product/${product['id']}'),
      child:
          Container(
                margin: const EdgeInsets.only(bottom: 40),
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      (product['color'] as Color).withOpacity(0.15),
                      (product['color'] as Color).withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: (product['color'] as Color).withOpacity(0.3),
                  ),
                ),
                child: isDesktop
                    ? Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  product['color'] as Color,
                                  (product['color'] as Color).withOpacity(0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Icon(
                              product['icon'] as IconData,
                              color: Colors.white,
                              size: 48,
                            ),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['title'] as String,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  product['shortDesc'] as String,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withOpacity(0.7),
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: product['color'] as Color,
                            size: 32,
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      product['color'] as Color,
                                      (product['color'] as Color).withOpacity(
                                        0.7,
                                      ),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  product['icon'] as IconData,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  product['title'] as String,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            product['shortDesc'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
              )
              .animate()
              .fadeIn(duration: 800.ms, delay: (index * 100).ms)
              .slideX(begin: index % 2 == 0 ? -0.3 : 0.3, end: 0),
    );
  }
}
