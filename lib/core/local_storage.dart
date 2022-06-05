import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static FlutterSecureStorage localStorage = FlutterSecureStorage();

  void save(String key, String value) {
    localStorage.write(key: key, value: value);
  }

  void delete(String key) {
    localStorage.delete(key: key);
  }

  Future<String?> read(String key) async {
    if (await isSaved(key)) {
      return await localStorage.read(key: key);
    }
  }

  Future<bool> isSaved(String key) async {
    return await localStorage.containsKey(key: key);
  }
}
