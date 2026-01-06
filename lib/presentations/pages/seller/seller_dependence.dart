import 'package:geogestao_front/core/core.dart';

import '../../../data/datasources/datasources.dart';
import '../../../data/repositories/repositories.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../domain/usecases/usecases.dart';
import 'controllers/seller_controller.dart';
import 'seller_page.dart';

class SellerDependency extends Module {
  static const String routeName = '/seller';

  @override
  List<Module> get imports => [CoreModule()];
  @override
  void binds(Injector i) {
    i.addLazySingleton<SellerDatasource>(SellerDatasourceImpl.new);
    i.addLazySingleton<SellerRepository>(SellerRepositoryImpl.new);
    i.addLazySingleton<SellerUsecase>(SellerUsecaseImpl.new);
    i.addLazySingleton(SellerController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => const SellerPage());
  }
}
