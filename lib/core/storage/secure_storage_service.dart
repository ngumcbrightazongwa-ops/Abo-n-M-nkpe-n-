class SecureStorageService {
  final Map<String, String> _store = {};

  Future<String?> read(String key) async => _store[key];

  Future<void> write(String key, String value) async {
    _store[key] = value;
  }

  Future<void> delete(String key) async {
    _store.remove(key);
  }
}
