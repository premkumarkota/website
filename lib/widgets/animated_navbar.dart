import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../controller/navigation_controller.dart';

class AnimatedNavbar extends StatefulWidget {
  const AnimatedNavbar({Key? key}) : super(key: key);

  @override
  State<AnimatedNavbar> createState() => _AnimatedNavbarState();
}

class _AnimatedNavbarState extends State<AnimatedNavbar> {
  final NavigationController navController = Get.find();
  int hoveredIndex = -1;

  final List<Map<String, dynamic>> navItems = [
    {'title': 'Home', 'route': '/'},
    {'title': 'About', 'route': '/about'},
    {
      'title': 'Products',
      'route': '/products',
      'dropdown': [
        {'title': 'HRMS', 'route': '/product/hrms'},
        // {'title': 'CRM', 'route': '/product/crm'},
        {'title': 'PMS', 'route': '/product/pms'},
        {'title': 'Accounting', 'route': '/product/accounting'},
        {'title': 'Inventory', 'route': '/product/inventory'},
      ],
    },
    {'title': 'Contact', 'route': '/contact'},
  ];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() {
        final isScrolled = navController.isScrolled.value;

        final size = MediaQuery.of(context).size;
        final isDesktop = size.width > 1100;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? (isScrolled ? 60 : 120) : 24,
            vertical: isScrolled ? 12 : 24,
          ),
          decoration: BoxDecoration(
            color: isScrolled
                ? const Color(0xFF0a0a0a).withOpacity(0.95)
                : Colors.transparent,
            border: isScrolled
                ? Border(
                    bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
                  )
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              GestureDetector(
                onTap: () => context.go('/'),
                child: Row(
                  children: [
                    Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFD946EF), Color(0xFFFB923C)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFD946EF).withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'J',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(
                          duration: 3000.ms,
                          color: Colors.white.withOpacity(0.3),
                        ),

                    const SizedBox(width: 16),

                    const Text(
                      'Jenveda',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Navigation
              if (isDesktop)
                Row(
                  children: List.generate(navItems.length, (index) {
                    final item = navItems[index];
                    final hasDropdown = item.containsKey('dropdown');

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: hasDropdown
                          ? _buildDropdownNavItem(item, index)
                          : _buildNavItem(item, index),
                    );
                  }),
                ),

              // CTA Button or Mobile Menu
              if (isDesktop)
                Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7C3AED), Color(0xFFEC4899)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF7C3AED).withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .scale(begin: const Offset(0.9, 0.9))
              else
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white, size: 32),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildNavItem(Map<String, dynamic> item, int index) {
    final isHovered = hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = -1),
      child: GestureDetector(
        onTap: () => context.go(item['route'] as String),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isHovered
                ? Colors.white.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item['title'] as String,
                style: TextStyle(
                  color: isHovered
                      ? Colors.white
                      : Colors.white.withOpacity(0.8),
                  fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(top: 4),
                height: 2,
                width: isHovered ? 20 : 0,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD946EF), Color(0xFFFB923C)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownNavItem(Map<String, dynamic> item, int index) {
    final isHovered = hoveredIndex == index;
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      color: const Color(0xFF1a1a2e),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => hoveredIndex = index),
        onExit: (_) => setState(() => hoveredIndex = -1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isHovered
                ? Colors.white.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item['title'] as String,
                style: TextStyle(
                  color: isHovered
                      ? Colors.white
                      : Colors.white.withOpacity(0.8),
                  fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: isHovered ? 0.5 : 0,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: isHovered
                      ? Colors.white
                      : Colors.white.withOpacity(0.8),
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      itemBuilder: (context) {
        final dropdownItems = item['dropdown'] as List<Map<String, dynamic>>;
        return dropdownItems.map((dropItem) {
          return PopupMenuItem<String>(
            onTap: () => context.go(dropItem['route'] as String),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFD946EF), Color(0xFFFB923C)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  dropItem['title'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
