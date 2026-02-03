import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/animated_navbar.dart';
import '../utils/constants.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with TickerProviderStateMixin {
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: const Duration(seconds: 6),
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

    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      body: CustomScrollView(
        slivers: [
          const AnimatedNavbar(),

          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width > 1000 ? 120 : 24,
                vertical: 80,
              ),
              child: Column(
                children: [
                  // Mission section
                  Text(
                    'OUR MISSION',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF7C3AED),
                      letterSpacing: 4,
                    ),
                  ).animate().fadeIn(duration: 600.ms),

                  const SizedBox(height: 24),

                  Text(
                        'Empowering Businesses Through Innovation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width > 1000 ? 48 : 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 100.ms)
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 40),

                  Text(
                    'The JenVeda digital platform provides comprehensive HRMS solutions and project management services tailored for Micro, Small, and Medium Enterprises (MSMEs) in the Architectural, Engineering, and Construction sectors.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.7),
                      height: 1.8,
                      fontWeight: FontWeight.w300,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),

                  const SizedBox(height: 80),

                  // Products overview
                  Wrap(
                    spacing: 32,
                    runSpacing: 32,
                    alignment: WrapAlignment.center,
                    children: AppData.products.map((product) {
                      return _buildProductOverview(product);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductOverview(Map<String, dynamic> product) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (product['color'] as Color).withOpacity(0.1),
            (product['color'] as Color).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: (product['color'] as Color).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (product['color'] as Color).withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              product['icon'] as IconData,
              color: product['color'] as Color,
              size: 32,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            product['title'] as String,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            product['fullDesc'] as String,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.7),
              height: 1.6,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0);
  }
}
