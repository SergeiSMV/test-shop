

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget productImageIndicator(List images, PageController pageController) {
    return SizedBox(
      height: 8,
      child: SmoothPageIndicator(
        controller: pageController,
        count: images.length,
        effect: WormEffect(
          dotHeight: 6,
          dotWidth: 6,
          type: WormType.thin,
          activeDotColor: Colors.black54,
          dotColor: Colors.grey.shade300
        ),
      ),
    );
  }