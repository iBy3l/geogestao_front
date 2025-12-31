import '/core/core.dart';
import '../../../data/datasources/datasources.dart';
import '../../../data/repositories/repositories.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../domain/usecases/usecases.dart';
import 'controllers/update_file_controller.dart';
import 'update_file_page.dart';

class UpdateFileDependency extends Module {
  static const String routeName = '/upload_file';

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<UpdateFileDatasource>(UpdateFileDatasourceImpl.new);
    i.addLazySingleton<UpdateFileRepository>(UpdateFileRepositoryImpl.new);
    i.addLazySingleton<UpdateFileUsecase>(UpdateFileUsecaseImpl.new);
    i.addLazySingleton(UpdateFileController.new);
  }

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const UpdateFilePage());
  }
}
