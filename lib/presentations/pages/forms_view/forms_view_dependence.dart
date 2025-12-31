import '/presentations/pages/home/home_dependency.dart';
import '../../../core/core.dart';
import '../../../data/datasources/datasources.dart';
import '../../../data/repositories/repositories.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../domain/usecases/usecases.dart';
import 'controllers/forms_view_controller.dart';
import 'forms_view_page.dart';

class FormsViewDependency extends Module {
  static const String routeName = '/forms_view';

  static const String routePath = '${HomeDependency.routeName}$routeName';
  @override
  List<Module> get imports => [CoreModule()];
  @override
  void binds(Injector i) {
    i.addLazySingleton<FormsViewDatasource>(FormsViewDatasourceImpl.new);
    i.addLazySingleton<FormsViewRepository>(FormsViewRepositoryImpl.new);
    i.addLazySingleton<FormsViewUsecase>(FormsViewUsecaseImpl.new);
    i.addLazySingleton(FormsViewController.new);
  }

  @override
  void routes(RouteManager r) {
    // id
    r.child('/:id', child: (context) => FormsViewScreen(controller: context.read()));
  }
}
