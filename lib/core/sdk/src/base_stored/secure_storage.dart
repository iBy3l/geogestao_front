import '/core/core.dart';

class SecureStorage extends BaseStorageSecure {
  final FlutterSecureStorage _storage;
  SecureStorage(this._storage) : super();

  @override
  Future<bool> containsKey<T>({required String key}) {
    return _storage.containsKey(key: key);
  }

  @override
  Future<void> delete<T>({required String key}) {
    return _storage.delete(key: key);
  }

  @override
  Future<T> get<T>({required String key}) async {
    return await _storage.read(key: key) as T;
  }

  @override
  Future<List<T>>? getAll<T>() {
    return null;
  }

  @override
  Future<void> post<T>({required String key, required value}) {
    return _storage.write(key: key, value: value as String);
  }

  @override
  Future<void> put<T>({required String key, required T value}) {
    return _storage.write(key: key, value: value as String);
  }
}
