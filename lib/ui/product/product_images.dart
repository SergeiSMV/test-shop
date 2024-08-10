
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget productImages(List images, PageController pageController, double height) {
  final Image emptyImage = Image.asset('lib/images/empty.png');
  return SizedBox(
    width: double.infinity,
    height: height,
    child: images.isEmpty ? emptyImage : 
    PageView.builder(
      controller: pageController,
      itemCount: images.length,
      itemBuilder: (context, index) {
        final String picURL = images[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FittedBox(
            fit: BoxFit.contain,
            child: CachedNetworkImage(
              imageUrl: picURL,
              errorWidget: (context, url, error) => emptyImage,
            ),
          ),
        );
      },
    ),
  );
}