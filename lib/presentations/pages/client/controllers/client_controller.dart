import 'package:flutter/material.dart';
import 'package:geogestao_front/core/core.dart';
import 'package:geogestao_front/presentations/pages/client/controllers/import_clients_controller.dart';
import 'package:geogestao_front/presentations/pages/maps/controller/cep_controller.dart';

import '/domain/entities/entities.dart';
import '/domain/usecases/usecases.dart';
import '../states/client_state.dart';

class ClientController extends BaseController<ClientStates> {
  final CreateClientUsecaseImpl clientUsecase;
  final GetListClientsUsecaseImpl getListClientsUsecase;
  final DeleteClientUsecase deleteClientUsecase;
  final UpdateClientUsecase updateClientUsecase;
  ClientController(
    this.clientUsecase,
    this.getListClientsUsecase,
    this.deleteClientUsecase,
    this.updateClientUsecase,
  ) : super(ClientInitialStates());
  ImportClientsController importClientsController =
      Modular.get<ImportClientsController>();
  CepController cepController = Modular.get<CepController>();
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
    emit(ClientLoadingStates());

    final result = await getListClientsUsecase();
    return result.ways(
      (l) {
        clients = l;

        emit(ListClientsSuccessStates(clients: l));
        notifyListeners();

        return l;
      },
      (r) {
        emit(ClientErrorStates(message: r.message));
        return [];
      },
    );
  }

  bool _isClientsPanelOpen = true;
  bool get isClientsPanelOpen => _isClientsPanelOpen;

  void toggleClientsPanel() {
    _isClientsPanelOpen = !_isClientsPanelOpen;
    notifyListeners();
  }

  Future<void> importClients(List<ClientParam> clients) async {
    await importClientsController.importInBatches(clients);
    Modular.to.pop();

    await getAllClients();
  }

  Future<void> deleteClient(String clientId) async {
    final result = await deleteClientUsecase(clientId: clientId);
    result.ways((success) async {
      await getAllClients();
    }, (error) {});
  }

  Future<void> updateClient(
    String clientId,
    String address,
    String latitude,
    String longitude,
  ) async {
    final result = await updateClientUsecase(
      clientId: clientId,
      param: ClientParam(
        address: address,
        cnpj: cnpjController.text,
        latitude: latitude,
        longitude: longitude,
        name: nameController.text,
        status: selectedStatus,
      ),
    );
    result.ways((success) async {
      await getAllClients();
    }, (error) {});
  }

  void clearControllers() {
    ownerNameController.clear();
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    cnpjController.clear();
    selectedStatus = ClientStatus.active;

    cepController.streetController.clear();
    cepController.numberController.clear();
    cepController.neighborhoodController.clear();
    cepController.cityController.clear();
    cepController.stateController.clear();
    cepController.cepController.clear();

    notifyListeners();
  }

  void fillForEdit(ClientEntity client) {
    ownerNameController.text = client.ownerName ?? '';
    nameController.text = client.name;
    phoneController.text = client.phone ?? '';
    emailController.text = client.email ?? '';
    cnpjController.text = client.cnpj;
    selectedStatus = client.status;

    final parsed = parseAddress(client.address);

    cepController.streetController.text = parsed.street;
    cepController.numberController.text = parsed.number;
    cepController.neighborhoodController.text = parsed.neighborhood;
    cepController.cityController.text = parsed.city;
    cepController.stateController.text = parsed.state;
    cepController.cepController.text = parsed.cep;

    notifyListeners();
  }

  ParsedAddress parseAddress(String address) {
    // Rua do Bosque, 136 - Barra Funda, São Paulo - SP, CEP: 01136000

    final cepMatch = RegExp(r'CEP:\s*(\d{5}-?\d{3})').firstMatch(address);
    final cep = cepMatch?.group(1) ?? '';

    final cleaned = address.replaceAll(RegExp(r',?\s*CEP:.*'), '');

    final parts = cleaned.split(' - ');
    final streetAndNumber = parts[0]; // Rua do Bosque, 136
    final neighborhoodAndCity = parts.length > 1 ? parts[1] : '';
    final cityAndState = parts.length > 2 ? parts[2] : '';

    final streetParts = streetAndNumber.split(',');
    final street = streetParts[0].trim();
    final number = streetParts.length > 1 ? streetParts[1].trim() : '';

    final neighborhoodCityParts = neighborhoodAndCity.split(',');
    final neighborhood = neighborhoodCityParts[0].trim();
    final city = neighborhoodCityParts.length > 1
        ? neighborhoodCityParts[1].trim()
        : '';

    final cityStateParts = cityAndState.split(',');
    final state = cityStateParts.isNotEmpty
        ? cityStateParts.last.replaceAll('-', '').trim()
        : '';

    return ParsedAddress(
      street: street,
      number: number,
      neighborhood: neighborhood,
      city: city,
      state: state,
      cep: cep,
    );
  }
}
