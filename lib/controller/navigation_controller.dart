import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class NavigationController extends GetxController {
  final scrollController = ScrollController();
  final currentIndex = 0.obs;
  final isScrolled = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    isScrolled.value = scrollController.offset > 100;
  }

  void scrollToSection(int index) {
    currentIndex.value = index;
    // Scroll logic implemented in specific screens
  }

  void navigateTo(String route, {BuildContext? context}) {
    if (context != null) {
      context.go(route);
    } else {
      Get.context?.go(route);
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
