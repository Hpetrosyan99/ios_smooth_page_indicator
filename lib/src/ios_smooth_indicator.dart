import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/services.dart';

class IosSmoothPageIndicator extends StatelessWidget {
  final int dotIndex;
  final int dotsCount;
  final Color dotColor;
  final Color activeDotColor;
  final Color dotBackgroundColor;
  final double dotWidth;
  final double dotHeight;
  final double dotSpacing;
  final ValueChanged<int> onDotTapped;
  final Function(int)? onPageChanged;
  final CarouselSliderController? carouselController;
  final bool enableHapticFeedback;

  const IosSmoothPageIndicator({
    super.key,
    required this.dotIndex,
    required this.dotsCount,
    this.dotColor = const Color(0xFF4d4d4d),
    this.activeDotColor = const Color(0xFFE87E57),
    this.dotBackgroundColor = const Color(0xFF4F6486),
    this.dotWidth = 8.0,
    this.dotHeight = 8.0,
    this.dotSpacing = 12.0,
    required this.onDotTapped,
    this.onPageChanged,
    this.carouselController,
    this.enableHapticFeedback = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) async {
        final effectiveDotWidth = dotWidth + dotSpacing;
        final tappedIndex =
            (details.localPosition.dx / effectiveDotWidth).floor();

        if (tappedIndex >= 0 && tappedIndex < dotsCount) {
          if (enableHapticFeedback && tappedIndex != dotIndex) {
            await HapticFeedback.lightImpact();
          }
          onDotTapped(tappedIndex);
          carouselController?.jumpToPage(tappedIndex);
          onPageChanged?.call(tappedIndex);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: dotBackgroundColor,
        ),
        child: SmoothPageIndicator(
          controller: PageController(initialPage: dotIndex),
          count: dotsCount,
          effect: ScaleEffect(
            dotWidth: dotWidth,
            spacing: dotSpacing,
            dotHeight: dotHeight,
            dotColor: dotColor,
            activeDotColor: activeDotColor,
            strokeWidth: 50,
          ),
          onDotClicked: (index) {
            if (enableHapticFeedback) {
              HapticFeedback.lightImpact();
            }
            carouselController?.animateToPage(index,
                duration: const Duration(
                  milliseconds: 300,
                ),
                curve: Curves.easeIn);
            onDotTapped(index);
            onPageChanged?.call(index);
          },
        ),
      ),
    );
  }
}
