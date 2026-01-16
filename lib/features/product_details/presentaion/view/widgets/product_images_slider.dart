import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flower_app/core/widgets/slider_indicator.dart';

class ProductImagesSlider extends StatefulWidget {
  final List<String> images;

  const ProductImagesSlider({super.key, required this.images});

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: widget.images.map((item) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.network(item, fit: BoxFit.cover),
            );
          }).toList(),
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.5,
            viewportFraction: 1.0,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: SliderIndicator(
            currentIndex: _currentImageIndex,
            count: widget.images.length,
          ),
        ),
      ],
    );
  }
}
