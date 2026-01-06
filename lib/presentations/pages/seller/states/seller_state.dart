import 'package:geogestao_front/core/core.dart';


abstract interface class SellerStates {}

class SellerInitialStates extends SellerStates {}

class SellerLoadingStates extends SellerStates {}

class SellerSuccessStates extends SellerStates {}

class SellerErrorStates extends SellerStates implements ErrorBaseState {
  @override
  final String message;

  SellerErrorStates({required this.message});
}

