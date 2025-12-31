import 'dart:async';

import 'package:flutter/material.dart';
import '/core/core.dart';
import '/shared/widgets/spaces/space_widget.dart';

class CarouselViewWidget extends StatefulWidget {
  final List<CarroselModel> banners;
  final bool isEmpty;
  final double height;
  final double width;
  const CarouselViewWidget({super.key, required this.banners, this.isEmpty = false, this.height = 200, this.width = double.infinity});

  @override
  State<CarouselViewWidget> createState() => _CarouselViewWidgetState();
}

class _CarouselViewWidgetState extends State<CarouselViewWidget> {
  late Timer _carouselTimer;
  final carouselController = CarouselController();
  int _currentIndex = 0;
  final double shrinkExtent = 200;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (widget.banners.isEmpty) return;

      _currentIndex = (_currentIndex + 1) % widget.banners.length;

      double offset = _currentIndex * shrinkExtent;

      carouselController.animateTo(offset, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _carouselTimer.cancel();
    carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return Container(
        constraints: BoxConstraints(maxHeight: widget.height, maxWidth: widget.width),
        decoration: BoxDecoration(color: context.theme.colorScheme.primary.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.image_not_supported, color: context.theme.colorScheme.outline, size: 48),
              SpaceWidget.extraSmall(),
              Text(
                context.text.noData,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: context.theme.colorScheme.outline),
              ),
            ],
          ),
        ),
      );
    }
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: widget.height, maxWidth: widget.width),
      child: CarouselView.weighted(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        controller: carouselController,
        itemSnapping: true,
        flexWeights: const <int>[10],
        shrinkExtent: 200,
        children: widget.banners.map((e) {
          // return CardImagesWidget(imageUrl: e.imageUrl, url: e.url, route: e.route, link: e.link);
          return Container();
        }).toList(),
      ),
    );
  }
}

class CarroselModel {
  final String imageUrl;
  final String? url;
  final String? route;
  final String? link;

  CarroselModel({required this.imageUrl, this.url, this.route, this.link});
}
