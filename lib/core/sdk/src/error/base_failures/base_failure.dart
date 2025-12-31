import '/core/core.dart';

class BaseFailure {
  final String title;
  final String message;
  final Object? objectError;
  final StackTrace? stackTrace;

  BaseFailure({required this.title, required this.message, this.objectError, this.stackTrace}) {
    final AppLogger logger = AppLogger();
    logger.e('$runtimeType: $title \n$message ${objectError != null ? '\nClasse: $objectError' : ''} \nStackTrace: $stackTrace');
  }
}

class ServerFailure extends BaseFailure {
  final ServerException serverException;
  ServerFailure({super.title = 'Erro de servidor', required super.message, required super.stackTrace, required this.serverException});
}

class CastFailure extends BaseFailure {
  CastFailure({super.title = 'Erro de conversão', super.message = 'Parece que houve um erro de conversão de dados', super.objectError, required super.stackTrace});
}

class NoConnectionFailure extends BaseFailure {
  NoConnectionFailure({super.title = 'Erro de conexão', super.message = 'Parece que você não está conectado à internet', required super.stackTrace});
}

class UnauthorizedFailure extends BaseFailure {
  UnauthorizedFailure({super.title = 'Erro de autenticação', super.message = 'Parece que você não está autenticado', required super.stackTrace});
}

class SupabseFailure extends BaseFailure {
  SupabseFailure({super.title = 'Erro de autenticação', super.message = 'Parece que você não está autenticado', required super.stackTrace});
}

class DataPersistenceFailure extends BaseFailure {
  DataPersistenceFailure({super.title = 'Erro de Persistência de Dados', super.message = 'Houve um problema ao acessar ou persistir os dados.', required super.stackTrace});
}

class UnknownFailure extends BaseFailure {
  UnknownFailure({super.title = 'Erro desconhecido', super.message = 'Parece que houve um erro desconhecido', required super.stackTrace});
}
