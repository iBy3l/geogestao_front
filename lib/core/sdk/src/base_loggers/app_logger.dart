import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'base_logger.dart';

class AppLogger extends Logger {
  Logger logger = Logger();
  AppLogger() : super();
  final Future<void> _initialization = Future.value();

  @override
  Future<void> get init async => await _initialization;

  @override
  Future<void> close() {
    Logger.level = Level.off;
    return logger.close();
  }

  @override
  void d(message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    final log = Log(level: AppLevel.debug, message: message.toString());
    logs.add(log);
    logger.d(message, time: time, error: error, stackTrace: stackTrace);
    Log(level: AppLevel.debug, message: message.toString());
  }

  @override
  void e(message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    final log = Log(level: AppLevel.error, message: message.toString());
    logs.add(log);
    logger.e(message, time: time, error: error, stackTrace: stackTrace);
    Log(level: AppLevel.error, message: message.toString());
  }

  @override
  void f(message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    final log = Log(level: AppLevel.fatal, message: message.toString());
    logs.add(log);
    logger.f(message, time: time, error: error, stackTrace: stackTrace);
    Log(level: AppLevel.fatal, message: message.toString());
    log;
  }

  @override
  void i(message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    final log = Log(level: AppLevel.info, message: message.toString());
    logs.add(log);
    logger.i(message, time: time, error: error, stackTrace: stackTrace);
    Log(level: AppLevel.info, message: message.toString());
    log;
  }

  @override
  bool isClosed() {
    return true;
  }

  @override
  void log(Level level, message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    final log = Log(level: AppLevel.verbose, message: message.toString());

    logs.add(log);
    logger.log(level, message, time: time, error: error, stackTrace: stackTrace);
    Log(level: AppLevel.verbose, message: message.toString());
    log;
  }

  @override
  void t(message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    final log = Log(level: AppLevel.verbose, message: message.toString());
    logs.add(log);
    logger.t(message, time: time, error: error, stackTrace: stackTrace);
    Log(level: AppLevel.verbose, message: message.toString());
  }

  @override
  void w(message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    final log = Log(level: AppLevel.warning, message: message.toString());
    logs.add(log);
    logger.w(message, time: time, error: error, stackTrace: stackTrace);
    Log(level: AppLevel.warning, message: message.toString());
    log;
  }

  clearLogs() {
    return Logger.level = Level.off;
  }

  Future<void> openConsole(BuildContext context) async => Navigator.push(context, MaterialPageRoute(builder: (context) => const LogPage()));
}

List<Log> logs = [];
