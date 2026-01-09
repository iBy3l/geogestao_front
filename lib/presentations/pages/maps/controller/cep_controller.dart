import 'package:flutter/material.dart';
import 'package:geogestao_front/domain/entities/entities.dart';
import 'package:geogestao_front/domain/usecases/maps/cep_address_usecase.dart';

class CepController extends ChangeNotifier {
  final CepAddressUsecase usecase;

  CepController(this.usecase);

  final TextEditingController cepController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController complementController = TextEditingController();

  AddressModel? address;
  bool isLoading = false;
  String? error;

  Future<void> getAddress(String cep) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await usecase(cep);

    result.ways(
      (ifResult) {
        address = ifResult;

        _fillControllers(ifResult);

        isLoading = false;
        notifyListeners();
      },
      (error) {
        this.error = error.message;
        isLoading = false;
        notifyListeners();
      },
    );
  }

  void _fillControllers(AddressModel address) {
    streetController.text = address.street;
    neighborhoodController.text = address.neighborhood;
    cityController.text = address.city;
    stateController.text = address.state;
  }

  @override
  void dispose() {
    cepController.dispose();
    streetController.dispose();
    neighborhoodController.dispose();
    cityController.dispose();
    stateController.dispose();
    numberController.dispose();
    complementController.dispose();
    super.dispose();
  }
}
