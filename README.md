# IosSmoothPageIndicator

[![pub package](https://img.shields.io/badge/pub-1.0.9-blue)](https://pub.dev/packages/ios_smooth_page_indicator)

IosSmoothPageIndicator is a customizable and easy-to-use page indicator widget designed to replicate the smooth and stylish page indicators commonly seen in iOS applications. This widget is built for Flutter and provides a modern and flexible solution for managing page indicators in your Flutter apps.

![dots_gesture](https://github.com/user-attachments/assets/907aead2-6165-44e8-85a0-73a756370609)  ![slider_gesture](https://github.com/user-attachments/assets/9f9fc398-b7a4-4b84-b6a8-12198e65f998)

## Features
* Customizable Appearance: Easily modify the dot color, active dot color, dot size, spacing, and background color to fit your app’s design.

* Haptic Feedback Support: Optionally enable haptic feedback when the user interacts with the dots, providing a more tactile user experience.

* Smooth Animation: The widget provides a smooth animation effect for transitioning between pages, enhancing the overall UX.

* Page Controller Integration: Seamlessly integrates with Flutter's PageController to update the page indicator as the user scrolls.

* Dot Tap Support: Users can tap on any dot to navigate directly to the corresponding page.

* Lightweight and Efficient: Designed to be lightweight, ensuring minimal impact on app performance.

## Usage
````
IosSmoothPageIndicator(
currentIndex: _currentIndex,
totalDots: _totalDots,
dotColor: Colors.grey,
activeDotColor: Colors.blue,
dotBackgroundColor: Colors.grey.withOpacity(0.1),
dotWidth: 8.0,
dotHeight: 8.0,
dotSpacing: 12.0,
onDotTapped: (index) {
// Handle dot tap
_pageController.jumpToPage(index);
},
pageController: _pageController,
enableHapticFeedback: true,
),
Customization Options
currentIndex: The current active page index.
totalDots: Total number of pages (dots) to display.
dotColor: The color of inactive dots.
activeDotColor: The color of the active dot.
dotBackgroundColor: Background color surrounding the dots (defaults to a subtle grey with opacity).
dotWidth and dotHeight: Dimensions of the dots.
dotSpacing: Space between each dot.
onDotTapped: Callback when a dot is tapped, providing the tapped index.
onPageChanged: Optional callback when the page changes, providing the new page index.
pageController: The PageController that controls the associated page view.
enableHapticFeedback: Option to enable or disable haptic feedback on dot tap.
````
Installation
Add the following to your pubspec.yaml:

````
dependencies:
ios_smooth_page_indicator: ^1.0.9
````
Then, run flutter pub get to install the package.

License
This package is distributed under the MIT License. See the LICENSE file for more details.
