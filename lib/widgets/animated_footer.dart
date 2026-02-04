import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedFooter extends StatelessWidget {
  const AnimatedFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      child: Stack(
        children: [
          // Decorative Background Shapes
          Positioned(
            left: -100,
            top: -50,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFD946EF).withOpacity(0.03),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 120 : 24,
              vertical: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 2, child: _buildBrandColumn()),
                      Expanded(child: _buildProductsColumn()),
                      Expanded(flex: 2, child: _buildContactColumn()),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBrandColumn(),
                      const SizedBox(height: 40),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Expanded(child: _buildProductsColumn())],
                      ),
                      const SizedBox(height: 40),
                      _buildContactColumn(),
                    ],
                  ),

                const SizedBox(height: 40),

                // Bottom Copyright Line
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.white.withOpacity(0.2),
                ),
                const SizedBox(height: 12),

                Text(
                  '© 2024 Jenveda Technologies. All rights reserved.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Premium Serif Logo
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFD946EF), Color(0xFFFB923C)],
          ).createShader(bounds),
          child: const Text(
            'Jenveda',
            style: TextStyle(
              color: Colors.black, // Base color for mask
              fontSize: 48,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 340,
          child: Text(
            'We create digital experiences for brands and companies by using technology.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              height: 1.7,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildSocialLink(FontAwesomeIcons.facebookF),
            _buildSocialLink(FontAwesomeIcons.instagram),
            _buildSocialLink(FontAwesomeIcons.youtube),
            _buildSocialLink(FontAwesomeIcons.linkedinIn),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.05, end: 0);
  }

  Widget _buildSocialLink(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 28),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildProductsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Our Products',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        ...['HRMS', 'PMS', 'Accounting', 'Inventory'].map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              item,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }),
      ],
    ).animate().fadeIn(duration: 800.ms, delay: 200.ms);
  }

  Widget _buildContactColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 350,
          child: Text(
            'Jenveda Technologies Private Limited 201, Padmaja Jansi Enclave, Opp. k.s Bakers, bhagyanagar Colony, Kphb main road (In Kalamandir Bus Stop), Hyderabad, Telangana 500072',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              height: 1.8,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '(+91) 72077 76559',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'jenvedatech@gmail.com',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 800.ms, delay: 400.ms);
  }
}
