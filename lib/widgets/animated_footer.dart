import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class AnimatedFooter extends StatelessWidget {
  const AnimatedFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width > 1000 ? 120 : 24,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, const Color(0xFF1a1a2e)],
        ),
      ),
      child: Column(
        children: [
          // Top section
          if (size.width > 800)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBrandColumn(),
                _buildLinksColumn('Products', [
                  'HRMS',
                  'CRM',
                  'PMS',
                  'Accounting',
                  'Inventory',
                ]),
                _buildLinksColumn('Company', [
                  'About Us',
                  'Careers',
                  'Contact',
                  'Blog',
                ]),
                _buildLinksColumn('Resources', [
                  'Documentation',
                  'Help Center',
                  'API Reference',
                  'Status',
                ]),
                _buildNewsletterColumn(),
              ],
            )
          else
            Column(
              children: [
                _buildBrandColumn(),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 40,
                  runSpacing: 40,
                  children: [
                    _buildLinksColumn('Products', [
                      'HRMS',
                      'CRM',
                      'PMS',
                      'Accounting',
                      'Inventory',
                    ]),
                    _buildLinksColumn('Company', [
                      'About Us',
                      'Careers',
                      'Contact',
                      'Blog',
                    ]),
                  ],
                ),
                const SizedBox(height: 40),
                _buildNewsletterColumn(),
              ],
            ),

          const SizedBox(height: 60),
          const Divider(color: Colors.white24),
          const SizedBox(height: 40),

          // Bottom section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2024 Jenveda Technologies. All rights reserved.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  _buildSocialIcon(FontAwesomeIcons.twitter),
                  _buildSocialIcon(FontAwesomeIcons.linkedin),
                  _buildSocialIcon(FontAwesomeIcons.github),
                  _buildSocialIcon(FontAwesomeIcons.instagram),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrandColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFFEC4899)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'J',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              'Jenveda',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: Text(
            'Transforming businesses with next-generation ERP solutions.',
            style: TextStyle(color: Colors.white.withOpacity(0.6), height: 1.6),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildLinksColumn(String title, List<String> links) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            ...links.map((link) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    link,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }),
          ],
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: 100.ms)
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildNewsletterColumn() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stay Updated',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7C3AED), Color(0xFFEC4899)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: 200.ms)
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Icon(icon, color: Colors.white.withOpacity(0.7), size: 20),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(begin: const Offset(0, 0), end: const Offset(1, 1));
  }
}
