class LocalStorageService {
  final Map<String, Object?> _store = {};

  T? get<T>(String key) => _store[key] as T?;

  Future<void> set<T>(String key, T value) async {
    _store[key] = value;
  }

  Future<void> remove(String key) async {
    _store.remove(key);
  }
}
