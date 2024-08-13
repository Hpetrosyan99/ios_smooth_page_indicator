import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/services.dart';

class IosSmoothPageIndicator extends StatefulWidget {
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
  State<IosSmoothPageIndicator> createState() => _IosSmoothPageIndicatorState();
}

class _IosSmoothPageIndicatorState extends State<IosSmoothPageIndicator> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.dotIndex;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) async {
        final effectiveDotWidth = widget.dotWidth + widget.dotSpacing;
        final tappedIndex = (details.localPosition.dx / effectiveDotWidth).floor();

        if (tappedIndex >= 0 && tappedIndex < widget.dotsCount) {
          if (widget.enableHapticFeedback && tappedIndex != _currentIndex) {
            await HapticFeedback.lightImpact();
          }
          if (tappedIndex != _currentIndex) {
            widget.onDotTapped(tappedIndex);
            widget.carouselController?.jumpToPage(tappedIndex);
            widget.onPageChanged?.call(tappedIndex);
            setState(() {
              _currentIndex = tappedIndex;
            });
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: widget.dotBackgroundColor,
        ),
        child: SmoothPageIndicator(
          controller: PageController(initialPage: widget.dotIndex),
          count: widget.dotsCount,
          effect: ScaleEffect(
            dotWidth: widget.dotWidth,
            spacing: widget.dotSpacing,
            dotHeight: widget.dotHeight,
            dotColor: widget.dotColor,
            activeDotColor: widget.activeDotColor,
            strokeWidth: 50,
          ),
          onDotClicked: (index) {
            if (widget.enableHapticFeedback) {
              HapticFeedback.lightImpact();
            }
            widget.carouselController?.animateToPage(index,
                duration: const Duration(
                  milliseconds: 300,
                ),
                curve: Curves.easeIn);
            widget.onDotTapped(index);
            widget.onPageChanged?.call(index);
          },
        ),
      ),
    );
  }
}
