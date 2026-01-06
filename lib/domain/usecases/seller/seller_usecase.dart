import 'package:geogestao_front/core/core.dart';

import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

abstract class SellerUsecase extends BaseUsecase<SellerParam, SellerEntity> {}

class SellerUsecaseParams {
  // final Example example;
  // final Example2 example2;

  // SellerUsecaseParams({required this.example, required this.example2});
}

class SellerUsecaseImpl extends SellerUsecase {
  final SellerRepository repository;

  SellerUsecaseImpl(this.repository);

  @override
  Future<BaseWhich<BaseFailure, SellerEntity>> call(SellerParam param) async {
    return await repository.createSeller(param: param);
  }
}
