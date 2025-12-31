import 'dart:async';

import '/core/core.dart';

class BaseStoredImpl implements BaseStorage {
  static final BaseStoredImpl _instance = BaseStoredImpl._internal();
  static bool _isInitialized = false;
  static Completer<void>? _initCompleter;

  final String boxId = 'vexpress_data';
  final AppLogger _logger = AppLogger();

  factory BaseStoredImpl() {
    return _instance;
  }

  BaseStoredImpl._internal();

  @override
  Future<void> init() async {
    if (_isInitialized) return;

    _initCompleter = Completer<void>();

    try {
      _logger.d("Initializing Hive...");
      final appDir = await getApplicationDocumentsDirectory();
      Hive.init(appDir.path);
      registerAdaptersHive(Hive);

      _logger.d("Opening Hive box...");
      await Hive.openBox(boxId);

      _isInitialized = true;
      _initCompleter!.complete();
      _logger.d("Hive initialization completed successfully");
    } catch (e) {
      _logger.d("Hive initialization failed: $e");
      _initCompleter!.completeError(e);
      rethrow;
    }
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      if (_initCompleter == null) {
        await init();
      } else {
        await _initCompleter!.future;
      }
    }
  }

  void registerAdaptersHive(HiveInterface hive) {
    if (!hive.isAdapterRegistered(0)) {
      AddRegisterAdapter().registerAdapter(hive);
    }
  }

  @override
  Future<T?> get<T>({required String dataId}) async {
    await _ensureInitialized();
    final box = Hive.box(boxId);
    final value = box.get(dataId);
    _logOperation('GET', dataId, value: value);
    return box.get(dataId);
  }

  @override
  Future<void> put<T>({required String dataId, required T data}) async {
    await _ensureInitialized();
    final box = Hive.box(boxId);
    _logOperation('PUT', dataId, value: data);
    await box.put(dataId, data);
  }

  @override
  Future<void> delete<T>({required String key}) async {
    await _ensureInitialized();
    final box = Hive.box(boxId);
    _logOperation('DELETE', key);
    await box.delete(key);
  }

  @override
  Future<bool> containsKey<T>({required String key}) async {
    await _ensureInitialized();
    final box = Hive.box(boxId);
    _logOperation('CONTAINS_KEY', key);
    return box.containsKey(key);
  }

  @override
  Future<List<T>> getAll<T>(String key) async {
    await _ensureInitialized();
    final box = Hive.box(boxId);
    _logOperation('GET_ALL', key);
    final List<T> result = [];
    final data = box.get(key);
    if (data != null) {
      if (data is List<T>) {
        result.addAll(data);
      } else if (data is T) {
        result.add(data);
      }
    }
    return result;
  }

  void _logOperation(String operation, String key, {dynamic value}) {
    _logger.d('Storage Operation: $operation | Key: $key | Value: ${value is Object ? value.toPrint() : 'null'}');
  }

  Future<void> close() async {
    if (_isInitialized) {
      await Hive.close();
      _isInitialized = false;
    }
  }

  @override
  Future<void> post<T>({required String key, required T value}) async {
    await _ensureInitialized();
    final box = Hive.box(boxId);
    _logOperation('POST', key, value: value?.toPrint());
    await box.put(key, value);
  }
}

// Print print object
extension T on Object {
  String toPrint() {
    // Map <String, dynamic>
    if (this is String) {
      return 'String: $runtimeType | Value: $this';
    } else if (this is int) {
      return 'int: $runtimeType | Value: $this';
    } else if (this is double) {
      return 'double: $runtimeType | Value: $this';
    } else if (this is bool) {
      return 'bool: $runtimeType | Value: $this';
    } else if (this is DateTime) {
      return 'DateTime: $runtimeType | Value: $this';
    } else if (this is List<String>) {
      return 'List<String>: $runtimeType | Values: $this';
    } else if (this is List<int>) {
      return 'List<int>: $runtimeType | Values: $this';
    } else if (this is List<double>) {
      return 'List<double>: $runtimeType | Values: $this';
    } else if (this is List<bool>) {
      return 'List<bool>: $runtimeType | Values: $this';
    } else if (this is List<DateTime>) {
      return 'List<DateTime>: $runtimeType | Values: $this';
    } else if (this is Map<String, dynamic>) {
      return 'Map<String, dynamic>: $runtimeType | Values: $this';
    } else if (this is List<Map<String, dynamic>>) {
      return 'List<Map<String, dynamic>>: $runtimeType | Values: $this';
    } else {
      return 'Unknown type: $runtimeType | Value: $this';
    }
  }
}
