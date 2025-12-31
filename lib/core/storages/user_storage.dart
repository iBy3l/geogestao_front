import 'package:flutter/material.dart';

import '/core/core.dart';

abstract class UserStorage {
  // Future<UserEntity?> getUserData();
  // Future<void> saveUserData(UserEntity user);
  // Future<void> removeUserData();

  Future<String?> getToken();
  Future<void> removeToken();
  Future<void> saveToken(String token);

  // uuid
  Future<String?> getUuid();
  Future<void> removeUuid();
  Future<void> saveUuid(String uuid);

  // refleshToken
  Future<String?> getRefreshToken();
  Future<void> removeRefreshToken();
  Future<void> saveRefreshToken(String token);

  // Future<void> saveUnit(SelectUnitEntity value);
  // Future<SelectUnitEntity?> getUnit();
  // Future<void> removeUnit();

  // // Progrmas
  // Future<void> savePrograms(List<ProgramEntity> value);
  // Future<void> removePrograms();
  // Future<List<ProgramEntity>> getPrograms();

  Future<bool> isLogged();
  Future<void> removeAll();
}

class UserStorageImpl implements UserStorage {
  final BaseStorage storage;
  final BaseStorageSecure secureStorage;

  UserStorageImpl(this.storage, this.secureStorage);

  // @override
  // Future<UserEntity?> getUserData() async {
  //   final result = await storage.get<UserEntity?>(dataId: 'user');
  //   if (result == null) {
  //     return UserEntity.fromJson({});
  //   }
  //   return result;
  // }

  // @override
  // Future<void> saveUserData(UserEntity user) async {
  //   final result = await storage.put(dataId: 'user', data: user);
  //   return result;
  // }

  // @override
  // Future<void> removeUserData() async {
  //   await storage.delete(key: 'user');
  // }

  @override
  Future<String?> getToken() async {
    final result = await secureStorage.get(key: 'access_token');
    return result;
  }

  @override
  Future<void> removeToken() async {
    await secureStorage.delete(key: 'access_token');
  }

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.put(key: 'access_token', value: token);
  }

  @override
  Future<String?> getUuid() async {
    final result = await secureStorage.get(key: 'uuid');
    return result;
  }

  @override
  Future<void> removeUuid() async {
    await secureStorage.delete(key: 'uuid');
  }

  @override
  Future<void> saveUuid(String uuid) async {
    await secureStorage.put(key: 'uuid', value: uuid);
  }

  @override
  Future<String?> getRefreshToken() async {
    final result = await secureStorage.get(key: 'refresh_token');
    return result;
  }

  @override
  Future<void> removeRefreshToken() async {
    await secureStorage.delete(key: 'refresh_token');
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await secureStorage.put(key: 'refresh_token', value: token);
  }

  // @override
  // Future<void> saveUnit(SelectUnitEntity value) async {
  //   await storage.put(dataId: 'select_unit', data: value);
  // }

  // @override
  // Future<SelectUnitEntity?> getUnit() async {
  //   final result = storage.get<SelectUnitEntity?>(dataId: 'select_unit');
  //   return result;
  // }

  // @override
  // Future<void> removeUnit() async {
  //   await storage.delete(key: 'select_unit');
  // }

  @override
  Future<bool> isLogged() async {
    return false;
  }

  @override
  Future<void> removeAll() async {}

  // @override
  // Future<void> savePrograms(List<ProgramEntity> value) async {
  //   await storage.put(dataId: 'programs', data: value.map((e) => e.toJson()).toList());
  // }

  // @override
  // Future<List<ProgramEntity>> getPrograms() async {
  //   final result = await storage.get(dataId: 'programs');
  //   if (result != null && result is List) {
  //     return result.map((e) => ProgramEntity.fromJson(Map<String, dynamic>.from(e))).toList();
  //   }
  //   return [];
  // }

  // @override
  // Future<void> removePrograms() async {
  //   await storage.delete(key: 'programs');
  // }
}

class Storage {
  final UserStorage userStorage;

  late String token;
  late String uuid;
  late String refreshToken;

  Storage._(this.userStorage) {
    initialize();
  }

  static final Storage _instance = Storage._(Modular.get<UserStorage>());

  factory Storage() {
    return _instance;
  }

  Future<void> initialize() async {
    try {
      token = await userStorage.getToken() ?? '';
      uuid = await userStorage.getUuid() ?? '';
      refreshToken = await userStorage.getUuid() ?? '';
    } catch (e) {
      debugPrint('Error initializing storage: $e');
      // user = UserEntity.fromJson({});
      // selectedUnit = SelectUnitEntity.fromJson({});
      // token = '';
      // isLogged = false;
      // programs = [];
      // getPrograms = [];
    }
  }

  cleanAll() {
    userStorage.removeAll();
  }
}
