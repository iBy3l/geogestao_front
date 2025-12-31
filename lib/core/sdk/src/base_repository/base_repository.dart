import '/core/core.dart';

abstract class BaseRepository {
  final AppLogger _logger = AppLogger();
  Future<BaseWhich<BaseFailure, E>> tryExecute<E>(
    Future<E> Function() exec, {
    BaseFailure Function(NoConnectionException e)? onNoConnectionException,
    BaseFailure Function(DataPersistenceException e)? onDataPersistenceException,
    BaseFailure Function(ServerException e)? onServerException,
    BaseFailure Function(UnauthorizedException e)? onUnauthorizedException,
    BaseFailure Function(SupabaseException e)? onSupabseException,
    BaseFailure Function(Exception e)? onOtherException,
    BaseFailure Function(UnknownException e)? onUnknownException,
    BaseFailure Function(CastFailure e)? onCastFailure,
  }) async {
    try {
      E result = await exec();
      return IsResult(result);
    } on NoConnectionException catch (e, stackTrace) {
      if (onNoConnectionException != null) {
        return IsError(onNoConnectionException(e));
      }
      _logErrorResponse(IsError(NoConnectionFailure(stackTrace: stackTrace)));
      return IsError(NoConnectionFailure(stackTrace: stackTrace));
    } on DataPersistenceException catch (e, stackTrace) {
      if (onDataPersistenceException != null) {
        return IsError(onDataPersistenceException(e));
      }
      _logErrorResponse(IsError(DataPersistenceFailure(stackTrace: stackTrace)));
      return IsError(DataPersistenceFailure(stackTrace: stackTrace));
    } on ServerException catch (e, stackTrace) {
      if (onServerException != null) {
        return IsError(onServerException(e));
      }
      final errorMessage = e.dataMessage ?? e.statusMessage ?? 'Erro desconhecido';
      _logErrorResponse(IsError(ServerFailure(message: errorMessage, stackTrace: stackTrace, serverException: e)));
      return IsError(ServerFailure(message: errorMessage, stackTrace: stackTrace, serverException: e));
    } on UnauthorizedException catch (e, stackTrace) {
      if (onUnauthorizedException != null) {
        return IsError(onUnauthorizedException(e));
      }
      return IsError(UnauthorizedFailure(stackTrace: stackTrace));
    } on SupabaseException catch (e, stackTrace) {
      if (onSupabseException != null) {
        return IsError(onSupabseException(e));
      }
      return IsError(SupabseFailure(stackTrace: stackTrace, message: e.message ?? ''));
    } on Exception catch (e, stackTrace) {
      if (onOtherException != null) {
        return IsError(onOtherException(e));
      }
      _logger.e('[ERROR RESPONSE REPOSITORY]: $e');
      return IsError(UnknownFailure(message: e.toString(), stackTrace: stackTrace));
    } on UnknownException catch (e, stackTrace) {
      if (onUnknownException != null) {
        return IsError(onUnknownException(e));
      }
      return IsError(UnknownFailure(stackTrace: stackTrace));
    } catch (e, stackTrace) {
      if (onCastFailure != null && e is CastFailure) {
        return IsError(onCastFailure(e));
      }
      _logger.e('[UNEXPECTED ERROR]: $e');
      return IsError(UnknownFailure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  void _logErrorResponse(IsError response) {
    _logger.e('[ERROR RESPONSE REPOSITORY]: ${response.value.message} ');
  }
}
