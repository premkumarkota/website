import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ClientsShowcase extends StatefulWidget {
  const ClientsShowcase({Key? key}) : super(key: key);

  @override
  State<ClientsShowcase> createState() => _ClientsShowcaseState();
}

class _ClientsShowcaseState extends State<ClientsShowcase> {
  bool isVisible = false;

  static final List<Map<String, String>> clients = [
    {'name': 'Varahi Silks', 'logo': 'assets/images/varahi.webp'},
    {'name': 'Malla Reddy University', 'logo': 'assets/images/mallareddy.png'},
    {'name': 'Srividya Schools', 'logo': 'assets/images/srividya.jfif'},
    {'name': 'Santosh Maruti', 'logo': 'assets/images/santhosh_maruthi.jfif'},
    {'name': 'Pruthvi Toyota', 'logo': 'assets/images/prutvi_toyata.jfif'},
    {'name': 'Lakshmi Toyota', 'logo': 'assets/images/lakshmi_toyata.png'},
    {'name': 'Sai Balaji Techno', 'logo': 'assets/images/sribalajitechno.png'},
    {
      'name': 'M V R CONSTRUCTIONS',
      'logo': 'assets/images/mvr_constructions.jfif',
    },
    {'name': 'Elite Post Tension', 'logo': 'assets/images/elite_bridge.png'},
    {'name': 'Elite Bridge Bearing', 'logo': 'assets/images/elite_bridge.png'},
    {'name': 'Pixelin Sciences', 'logo': 'assets/images/pixelinsciences.jfif'},
    {'name': '3T Infotech', 'logo': 'assets/images/3tinfotech.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    return VisibilityDetector(
      key: const Key('clients-showcase-premium'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !isVisible) {
          if (mounted) setState(() => isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.transparent),
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 120 : 24,
          vertical: 100,
        ),
        child: Column(
          children: [
            // Section Header
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TRUSTED BY ',
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
                        'INDUSTRY TITANS',
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
                .animate(target: isVisible ? 1 : 0)
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.2, end: 0),
            const SizedBox(height: 80),

            // Client Grid
            LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  spacing: 40,
                  runSpacing: 40,
                  alignment: WrapAlignment.center,
                  children: clients.asMap().entries.map((entry) {
                    final index = entry.key;
                    final client = entry.value;

                    return _PremiumClientCard(
                      name: client['name']!,
                      logo: client['logo']!,
                      isNetwork: client['isNetwork'] == 'true',
                      index: index,
                      isVisible: isVisible,
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PremiumClientCard extends StatefulWidget {
  final String name;
  final String logo;
  final bool isNetwork;
  final int index;
  final bool isVisible;

  const _PremiumClientCard({
    Key? key,
    required this.name,
    required this.logo,
    required this.isNetwork,
    required this.index,
    required this.isVisible,
  }) : super(key: key);

  @override
  State<_PremiumClientCard> createState() => _PremiumClientCardState();
}

class _PremiumClientCardState extends State<_PremiumClientCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isHovered ? 0.1 : 0.05),
                      blurRadius: isHovered ? 40 : 20,
                      offset: isHovered
                          ? const Offset(0, 15)
                          : const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                    color: isHovered
                        ? const Color(0xFFD946EF).withOpacity(0.3)
                        : const Color(0xFFE5E7EB),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: widget.isNetwork
                        ? CachedNetworkImage(
                            imageUrl: widget.logo,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFFD946EF),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                _buildFallbackLogo(),
                          )
                        : Image.asset(
                            widget.logo,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildFallbackLogo(),
                          ),
                  ),
                ),
              )
              .animate(target: widget.isVisible ? 1 : 0)
              .fadeIn(duration: 600.ms, delay: (widget.index * 100).ms)
              .scale(
                begin: const Offset(0.5, 0.5),
                curve: Curves.easeOutBack,
                delay: (widget.index * 100).ms,
              ),
          const SizedBox(height: 16),
          AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isHovered ? 1.0 : 0.7,
                child: Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isHovered
                        ? const Color(0xFFD946EF)
                        : const Color(0xFF4B5563),
                  ),
                ),
              )
              .animate(target: widget.isVisible ? 1 : 0)
              .fadeIn(duration: 600.ms, delay: (widget.index * 100 + 200).ms),
        ],
      ),
    );
  }

  Widget _buildFallbackLogo() {
    return Center(
      child: Icon(
        Icons.business_rounded,
        color: const Color(0xFFE5E7EB),
        size: 40,
      ),
    );
  }
}
