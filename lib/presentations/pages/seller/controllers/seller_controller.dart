import 'package:flutter/widgets.dart';
import 'package:geogestao_front/core/core.dart';

import '/domain/entities/entities.dart';
import '/domain/usecases/usecases.dart';
import '../states/seller_state.dart';

class SellerController extends BaseController<SellerStates> {
  final SellerUsecase sellerUsecase;
  SellerController(this.sellerUsecase) : super(SellerInitialStates());

  @override
  void init() {}
  TextEditingController codeController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Future<void> fetch() async {
    final result = await sellerUsecase(
      SellerParam(
        code: codeController.text,
        name: nameController.text,
        orgId: "value",
      ),
    );
    result.ways((successs) {}, (error) {});
  }
}
