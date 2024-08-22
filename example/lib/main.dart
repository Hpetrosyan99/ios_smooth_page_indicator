import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ios_smooth_page_indicator/ios_smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late var dotsIndex = 0;

  final carouselController = CarouselSliderController();

  void onImageSlide(int index) {
    setState(() {
      dotsIndex = index;
      carouselController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sliderItems = <Image>[
      Image.asset('assets/images/image_1.jpg'),
      Image.asset('assets/images/image_2.jpg'),
      Image.asset('assets/images/image_3.jpg'),
      Image.asset('assets/images/image_4.jpg'),
      Image.asset('assets/images/image_5.jpg'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('IosSmoothPageIndicator'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CarouselSlider(
                  items: sliderItems,
                  carouselController: carouselController,
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      onImageSlide(index);
                    },
                    enlargeFactor: 0.35,
                    enableInfiniteScroll: false,
                    viewportFraction: 0.5,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                AbsorbPointer(
                  absorbing: false,
                  child: IosSmoothPageIndicator(
                      dotIndex: dotsIndex,
                      dotsCount: sliderItems.length,
                      dotBackgroundColor: Colors.grey.withOpacity(0.2),
                      onPageChanged: onImageSlide,
                      onDotTapped: (_) {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
