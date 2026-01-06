import 'package:flutter/material.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/map_widget.dart';

import '/presentations/pages/home/controllers/home_controller.dart';
import '/shared/shared.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;
  const HomePage({super.key, required this.controller});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      metas: widget.controller.meta,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(128),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          height: double.infinity,
          width: double.infinity,
          child: MapPage(controller: widget.controller.mapController),
        ),
      ),
    );
  }
}
