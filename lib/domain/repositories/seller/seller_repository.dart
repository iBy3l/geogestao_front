import 'package:geogestao_front/core/core.dart';

import '../../../domain/entities/entities.dart';

abstract class SellerRepository extends BaseRepository{
  Future<BaseWhich<BaseFailure, SellerEntity>> createSeller({required SellerParam param});
}

