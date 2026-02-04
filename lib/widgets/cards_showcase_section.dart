import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '3d_card_widget.dart';

class CardsShowcaseSection extends StatefulWidget {
  const CardsShowcaseSection({Key? key}) : super(key: key);

  @override
  State<CardsShowcaseSection> createState() => _CardsShowcaseSectionState();
}

class _CardsShowcaseSectionState extends State<CardsShowcaseSection> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1100;

    return VisibilityDetector(
      key: const Key('cards-showcase-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !isVisible) {
          setState(() => isVisible = true);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 120 : 24,
          vertical: 100,
        ),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Text(
                  'OUR CORE MODULES',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6366F1),
                    letterSpacing: 4,
                  ),
                )
                .animate(target: isVisible ? 1 : 0)
                .fadeIn()
                .slideY(begin: 0.3, end: 0),
            const SizedBox(height: 16),
            Text(
                  'Integrated Solutions for Every\nBusiness Need',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isDesktop ? 48 : 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E293B),
                    height: 1.2,
                  ),
                )
                .animate(target: isVisible ? 1 : 0)
                .fadeIn(delay: 200.ms)
                .slideY(begin: 0.3, end: 0),
            const SizedBox(height: 60),
            _build3DCarousel()
                .animate(target: isVisible ? 1 : 0)
                .fadeIn(duration: 800.ms, delay: 400.ms)
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  curve: Curves.easeOutBack,
                )
                .moveY(begin: 100, end: 0, duration: 800.ms),
          ],
        ),
      ),
    );
  }

  Widget _build3DCarousel() {
    const cards = <CardData>[
      CardData(
        color: Color(0xFFD946EF),
        icon: Icons.people,
        title: 'HRMS',
        imageUrl:
            'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=400',
      ),
      CardData(
        color: Color(0xFF3B82F6),
        icon: Icons.assignment,
        title: 'PMS',
        imageUrl:
            'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=400',
      ),
      CardData(
        color: Color(0xFF10B981),
        icon: Icons.account_balance,
        title: 'Accounting',
        imageUrl:
            'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?w=400',
      ),
    ];

    return const Card3DCarousel(
      cards: cards,
      height: 600,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 4),
      autoPlayAnimationDuration: Duration(milliseconds: 1000),
      autoPlayCurve: Curves.easeInOutCubic,
      showIndicators: true,
      maxFlipAngle: 1.4,
    );
  }
}
