import 'package:geogestao_front/core/core.dart';
import 'package:geogestao_front/domain/domain.dart';

abstract interface class ClientStates {}

class ClientInitialStates extends ClientStates {}

class ClientLoadingStates extends ClientStates {}

class ClientSuccessStates extends ClientStates {}

class ListClientsSuccessStates extends ClientStates {
  final List<ClientEntity> clients;

  ListClientsSuccessStates({required this.clients});
}

class ClientErrorStates extends ClientStates implements ErrorBaseState {
  @override
  final String message;

  ClientErrorStates({required this.message});
}
