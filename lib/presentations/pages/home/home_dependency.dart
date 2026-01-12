import 'package:geogestao_front/presentations/pages/maps/maps_module.dart';

import '/core/core.dart';
import '/presentations/presentations.dart';

class HomeDependency extends Module {
  static const String routeName = '/home/';

  @override
  List<Module> get imports => [CoreModule(), MapsModule(), ClientDependency()];

  @override
  void binds(Injector i) {
    i.addLazySingleton(HomeController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (context) => HomePage(controller: context.read<HomeController>()),
    );
  }
}
