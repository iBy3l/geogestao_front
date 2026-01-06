import 'package:flutter/material.dart';
import 'package:geogestao_front/core/core.dart';

import 'controllers/seller_controller.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends BasePage<SellerPage, SellerController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BaseBuilder(
          controller: controller,
          build: (context, state) {
            return const Column();
          }),
    );
  }
}

