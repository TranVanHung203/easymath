import 'package:math/common/extension/share_prefs_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharePrefsKey { accessToken, searchHistory, refreshToken }

class SharePrefsService {
  final SharedPreferences _prefs;
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  // static const String _keySaveSession = 'save_session';

  SharePrefsService({required SharedPreferences prefs}) : _prefs = prefs;
  // Future<void> saveSearchHistory(List<String> searches) async {
  //   await _prefs.setStringList(SharePrefsKey.searchHistory.getKey, searches);
  // }

  // List<String> getSearchHistory() {
  //   return _prefs.getStringList(SharePrefsKey.searchHistory.getKey) ?? [];
  // }

  Future<void> saveAccessToken(String? token) async {
    if (token == null) {
      await _prefs.remove(_keyAccessToken);
    } else {
      await _prefs.setString(_keyAccessToken, token);
    }
  }

  String? getAccessToken() {
    return _prefs.getString(_keyAccessToken);
  }

  Future<void> saveRefreshToken(String? token) async {
    if (token == null) {
      await _prefs.remove(_keyRefreshToken);
    } else {
      await _prefs.setString(_keyRefreshToken, token);
    }
  }

  String? getRefreshToken() {
    return _prefs.getString(_keyRefreshToken);
  }
  // Future<void> saveSession(bool isSaveSession) async {
  //   await _prefs.setBool(_keySaveSession, isSaveSession);
  // }

  // bool? getSaveSession() {
  //   return _prefs.getBool(_keySaveSession);
  // }

  // Future<void> setString(SharePrefsKey key, String value) async {
  //   await _prefs.setString(key.getKey, value);
  // }

  // String? getString(SharePrefsKey key) {
  //   return _prefs.getString(key.getKey);
  // }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
