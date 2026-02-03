import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ClientsShowcase extends StatefulWidget {
  const ClientsShowcase({Key? key}) : super(key: key);

  @override
  State<ClientsShowcase> createState() => _ClientsShowcaseState();
}

class _ClientsShowcaseState extends State<ClientsShowcase> {
  bool isVisible = false;

  static const List<Map<String, String>> clients = [
    {'name': 'Varahi Silks', 'location': 'Retail'},
    {'name': 'Malla Reddy University', 'location': 'Education'},
    {'name': 'Srividya Schools', 'location': 'Education'},
    {'name': 'Santosh Maruti', 'location': 'Vijayawada'},
    {'name': 'Pruthvi Toyota', 'location': 'Vijayawada'},
    {'name': 'Lakshmi Toyota', 'location': 'Automotive'},
    {'name': 'Sai Balaji Techno', 'location': 'Ballery'},
    {'name': 'M V R CONSTRUCTIONS', 'location': 'Infrastructure'},
    {'name': 'Elite Post Tension', 'location': 'Bangalore'},
    {'name': 'Elite Bridge Bearing', 'location': 'Bangalore'},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    return VisibilityDetector(
      key: const Key('clients-showcase-pop'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !isVisible) {
          if (mounted) setState(() => isVisible = true);
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
            Text(
              'TRUSTED BY INDUSTRY TITANS',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Color(0xFFD946EF),
                letterSpacing: 5,
              ),
            ).animate(target: isVisible ? 1 : 0).fadeIn().scale(),
            const SizedBox(height: 80),

            // Client Grid with Popping Animation
            Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: clients.asMap().entries.map((entry) {
                final index = entry.key;
                final client = entry.value;

                return _PoppingClientCard(
                  name: client['name']!,
                  index: index,
                  isVisible: isVisible,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PoppingClientCard extends StatefulWidget {
  final String name;
  final int index;
  final bool isVisible;

  const _PoppingClientCard({
    Key? key,
    required this.name,
    required this.index,
    required this.isVisible,
  }) : super(key: key);

  @override
  State<_PoppingClientCard> createState() => _PoppingClientCardState();
}

class _PoppingClientCardState extends State<_PoppingClientCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      isHovered
                          ? const Color(0xFFD946EF)
                          : Colors.white.withOpacity(0.05),
                      isHovered
                          ? const Color(0xFFFB923C)
                          : Colors.white.withOpacity(0.02),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isHovered
                        ? Colors.white
                        : Colors.white.withOpacity(0.1),
                    width: 1.5,
                  ),
                  boxShadow: [
                    if (isHovered)
                      BoxShadow(
                        color: const Color(0xFF7C3AED).withOpacity(0.4),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                  ],
                ),
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              )
              .animate(target: widget.isVisible ? 1 : 0)
              .fadeIn(duration: 400.ms, delay: (widget.index * 100).ms)
              .scale(
                begin: const Offset(0.3, 0.3),
                end: const Offset(1.0, 1.0),
                curve: Curves.easeOutBack,
                delay: (widget.index * 100).ms,
              ),
    );
  }
}
