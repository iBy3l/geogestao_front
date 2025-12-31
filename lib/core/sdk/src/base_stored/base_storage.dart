abstract class BaseStorage {
  init();

  Future<T?> get<T>({required String dataId});
  // Future<T?> get<T>({required String dataId});
  Future<bool> containsKey<T>({required String key});
  Future<List<T>>? getAll<T>(String key);
  Future<void> put<T>({required String dataId, required T data});
  Future<void> post<T>({required String key, required T value});
  Future<void> delete<T>({required String key});
}

abstract class BaseStorageSecure {
  Future<T>? get<T>({required String key});
  Future<bool> containsKey<T>({required String key});
  Future<List<T>>? getAll<T>();
  Future<void> put<T>({required String key, required T value});
  Future<void> post<T>({required String key, required T value});
  Future<void> delete<T>({required String key});
}
