import '../../../core/core.dart';
import '../../../data/datasources/datasources.dart';
import '../../../data/repositories/repositories.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../domain/usecases/usecases.dart';
import '../home/home.dart';
import 'controllers/create_forms_controller.dart';
import 'create_forms_page.dart';

class CreateFormsDependency extends Module {
  static const String routeName = 'create-form/';
  static const String routePath = '${HomeDependency.routeName}$routeName';
  @override
  List<Module> get imports => [CoreModule()];
  @override
  void binds(Injector i) {
    i.addLazySingleton<FormsDatasource>(FormsDatasourceImpl.new);
    i.addLazySingleton<FormsRepository>(FormsRepositoryImpl.new);
    i.addLazySingleton<CreateFormsUsecase>(CreateFormsUsecaseImpl.new);
    i.addLazySingleton<UpdateFormsUsecase>(UpdateFormsUsecaseImpl.new);
    i.addLazySingleton<FormsViewDatasource>(FormsViewDatasourceImpl.new);
    i.addLazySingleton<FormsViewRepository>(FormsViewRepositoryImpl.new);

    i.addLazySingleton<FormsViewUsecase>(FormsViewUsecaseImpl.new);
    i.addLazySingleton(CreateFormsController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/:id', child: (context) => CreateFormsPage(controller: context.read<CreateFormsController>()));
  }
}
