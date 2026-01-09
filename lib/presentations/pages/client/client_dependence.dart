import 'package:geogestao_front/core/core.dart';

import '../../../data/datasources/datasources.dart';
import '../../../data/repositories/repositories.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../domain/usecases/usecases.dart';
import 'controllers/client_controller.dart';

class ClientDependency extends Module {
  static const String routeName = '/client';

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<ClientDatasource>(ClientDatasourceImpl.new);
    i.addLazySingleton<ClientRepository>(ClientRepositoryImpl.new);
    i.addLazySingleton(CreateClientUsecaseImpl.new);
    i.addLazySingleton(GetListClientsUsecaseImpl.new);
    i.addLazySingleton(ImportClientsUsecase.new);
    i.addLazySingleton(ClientController.new);
  }

  @override
  void routes(RouteManager r) {}
}
