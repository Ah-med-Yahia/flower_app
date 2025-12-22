import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SharedPreferencesModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

@lazySingleton
class CacheHelper {
  final SharedPreferences _prefs;

  CacheHelper(this._prefs);

  Future<bool> saveData({required String key, required Object value}) async {
    if (value is String) return await _prefs.setString(key, value);
    if (value is int) return await _prefs.setInt(key, value);
    if (value is bool) return await _prefs.setBool(key, value);
    if (value is double) return await _prefs.setDouble(key, value);
    if (value is List<String>) return await _prefs.setStringList(key, value);
    throw Exception("Unsupported value type: ${value.runtimeType}");
  }

  T? getData<T>({required String key}) {
    final value = _prefs.get(key);
    if (value == null) return null;

    try {
      return value as T;
    } catch (e) {
      print('CacheHelper: Failed to cast value for key "$key" to $T');
      return null;
    }
  }

  String? getString(String key) => _prefs.getString(key);
  int? getInt(String key) => _prefs.getInt(key);
  bool? getBool(String key) => _prefs.getBool(key);
  double? getDouble(String key) => _prefs.getDouble(key);
  List<String>? getStringList(String key) => _prefs.getStringList(key);

  Future<bool> remove(String key) => _prefs.remove(key);

  Future<bool> clear() => _prefs.clear();

  bool containsKey(String key) => _prefs.containsKey(key);

  Set<String> getKeys() => _prefs.getKeys();

  Future<bool> saveEnum<T>(String key, T value) async {
    return await _prefs.setString(key, value.toString());
  }

  T? getEnum<T>(String key, List<T> values) {
    final stringValue = _prefs.getString(key);
    if (stringValue == null) return null;

    try {
      return values.firstWhere((e) => e.toString() == stringValue);
    } catch (e) {
      return null;
    }
  }
}
