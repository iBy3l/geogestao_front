import 'package:flutter/material.dart';
import 'package:geogestao_front/core/core.dart';

import '/domain/entities/entities.dart';
import '/domain/usecases/usecases.dart';
import '../states/client_state.dart';

class ClientController extends BaseController<ClientStates> {
  final CreateClientUsecaseImpl clientUsecase;
  final GetListClientsUsecaseImpl getListClientsUsecase;
  ClientController(this.clientUsecase, this.getListClientsUsecase)
    : super(ClientInitialStates());

  @override
  void init() async {
    await getAllClients();
  }

  TextEditingController searchController = TextEditingController();
  seacrhClients(String query) {
    final filteredClients = clients.where((client) {
      final nameLower = client.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
    emit(ListClientsSuccessStates(clients: filteredClients));
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController cnpjController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  ClientStatus selectedStatus = ClientStatus.active;
  List<ClientStatus> get values => ClientStatus.values;

  selectStatus(ClientStatus? status) {
    if (status != null) {
      selectedStatus = status;
      notifyListeners();
    }
  }

  Future<void> fetch(String address, String latitude, String longitude) async {
    final result = await clientUsecase(
      ClientParam(
        address: address,
        cnpj: cnpjController.text,
        latitude: latitude,
        longitude: longitude,
        name: nameController.text,
        status: selectedStatus,
      ),
    );
    result.ways((successs) async {
      await getAllClients();
    }, (error) {});
  }

  List<ClientEntity> clients = [];
  Future<List<ClientEntity>> getAllClients() async {
    final result = await getListClientsUsecase();
    return result.ways((l) {
      clients = l;
      notifyListeners();
      emit(ListClientsSuccessStates(clients: l));
      return l;
    }, (r) => []);
  }

  bool _isClientsPanelOpen = true;
  bool get isClientsPanelOpen => _isClientsPanelOpen;

  void toggleClientsPanel() {
    _isClientsPanelOpen = !_isClientsPanelOpen;
    notifyListeners();
  }
}
