import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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

        // Premium floating placement (Light Theme)
        return Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutQuart,
            width: isDesktop
                ? (isScrolled ? size.width * 0.6 : size.width * 0.85)
                : size.width * 0.92,
            margin: EdgeInsets.only(top: isScrolled ? 20 : 30),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(isScrolled ? 0.85 : 0.6),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.black.withOpacity(0.05),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 10),
                ),
                // Subtle shine
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  blurRadius: 0,
                  spreadRadius: 0,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
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
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFD946EF),
                                    Color(0xFFFB923C),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFFD946EF,
                                    ).withOpacity(0.4),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Jenveda',
                              style: GoogleFonts.outfit(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1F2937), // Dark text
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Desktop Navigation
                      if (isDesktop)
                        Row(
                          children: List.generate(navItems.length, (index) {
                            final item = navItems[index];
                            final hasDropdown = item.containsKey('dropdown');

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: hasDropdown
                                  ? _buildDropdownNavItem(item, index)
                                  : _buildNavItem(item, index),
                            );
                          }),
                        ),

                      // Action Button / Mobile Menu
                      if (isDesktop)
                        GestureDetector(
                          onTap: () => context.go('/contact'),
                          child:
                              Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 28,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFD946EF),
                                          Color(0xFFFB923C),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFFD946EF,
                                          ).withOpacity(0.4),
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
                                        fontSize: 14,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  )
                                  .animate(
                                    onPlay: (c) => c.repeat(reverse: true),
                                  )
                                  .shimmer(
                                    duration: 3000.ms,
                                    color: Colors.white.withOpacity(0.4),
                                    delay: 2000.ms,
                                  ),
                        )
                      else
                        IconButton(
                          icon: const Icon(
                            Icons.menu_rounded,
                            color: Color(0xFF1F2937),
                            size: 28,
                          ),
                          onPressed: () => Scaffold.of(context).openEndDrawer(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
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
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: isHovered
                ? Colors.black.withOpacity(0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            item['title'] as String,
            style: GoogleFonts.plusJakartaSans(
              color: isHovered ? Colors.black : const Color(0xFF4B5563),
              fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownNavItem(Map<String, dynamic> item, int index) {
    return _HoverDropdownMenu(
      title: item['title'] as String,
      items: item['dropdown'] as List<Map<String, dynamic>>,
      isHovered: hoveredIndex == index,
      onHover: (hovering) {
        setState(() {
          hoveredIndex = hovering ? index : -1;
        });
      },
    );
  }
}

class _HoverDropdownMenu extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final bool isHovered;
  final Function(bool) onHover;

  const _HoverDropdownMenu({
    Key? key,
    required this.title,
    required this.items,
    required this.isHovered,
    required this.onHover,
  }) : super(key: key);

  @override
  State<_HoverDropdownMenu> createState() => _HoverDropdownMenuState();
}

class _HoverDropdownMenuState extends State<_HoverDropdownMenu> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isMenuHovered = false;

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _updateOverlay() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (widget.isHovered || _isMenuHovered) {
        if (_overlayEntry == null) _showOverlay();
      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (!mounted) return;
          if (!widget.isHovered && !_isMenuHovered) {
            _hideOverlay();
          }
        });
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: 200,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 10),
          child: MouseRegion(
            onEnter: (_) {
              _isMenuHovered = true;
              widget.onHover(true);
            },
            onExit: (_) {
              _isMenuHovered = false;
              widget.onHover(false);
              _updateOverlay();
            },
            child:
                Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(
                            0.95,
                          ), // Light Theme Background
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 30,
                              offset: const Offset(0, 15),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.black.withOpacity(0.05),
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: widget.items.map((dropItem) {
                                return _DropdownItem(
                                  title: dropItem['title'] as String,
                                  onTap: () {
                                    context.go(dropItem['route'] as String);
                                    _hideOverlay();
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 300.ms, curve: Curves.easeOut)
                    .slideY(
                      begin: -0.1,
                      end: 0,
                      duration: 300.ms,
                      curve: Curves.easeOut,
                    ),
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(_HoverDropdownMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateOverlay();
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => widget.onHover(true),
        onExit: (_) => widget.onHover(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isHovered
                ? Colors.black.withOpacity(0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.plusJakartaSans(
                  color: widget.isHovered
                      ? Colors.black
                      : const Color(0xFF4B5563),
                  fontWeight: widget.isHovered
                      ? FontWeight.w600
                      : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: widget.isHovered ? 0.5 : 0,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: widget.isHovered
                      ? Colors.black
                      : const Color(0xFF4B5563),
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropdownItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _DropdownItem({Key? key, required this.title, required this.onTap})
    : super(key: key);

  @override
  State<_DropdownItem> createState() => _DropdownItemState();
}

class _DropdownItemState extends State<_DropdownItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFFD946EF).withOpacity(0.1)
                : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: _isHovered
                    ? const Color(0xFFD946EF)
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: _isHovered
                      ? const Color(0xFFD946EF)
                      : const Color(0xFF374151),
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
