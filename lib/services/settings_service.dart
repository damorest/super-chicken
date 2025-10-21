import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends ChangeNotifier {
  static const _soundKey = 'soundOn';
  static const _notificationKey = 'notificationOn';
  static const _vibrationKey = 'vibrationOn';
  static const _bestScoreKey = 'bestScore';
  static const _lastScoreKey = 'lastScore';
  static const _balanceKey = 'balance';
  static const _selectedEggKey = 'selectedEgg';

  final SharedPreferences _prefs;

  SettingsService(this._prefs);

  bool get soundOn => _prefs.getBool(_soundKey) ?? true;
  bool get notificationOn => _prefs.getBool(_notificationKey) ?? true;
  bool get vibrationOn => _prefs.getBool(_vibrationKey) ?? true;

  Future<void> setSound(bool value) => _prefs.setBool(_soundKey, value);
  Future<void> setNotification(bool value) => _prefs.setBool(_notificationKey, value);
  Future<void> setVibration(bool value) => _prefs.setBool(_vibrationKey, value);

  Future<void> saveSettings({bool? sound, bool? notification, bool? vibration}) async {
    if (sound != null) await setSound(sound);
    if (notification != null) await setNotification(notification);
    if (vibration != null) await setVibration(vibration);
  }

  String get username => _prefs.getString('username') ?? '';
  String get email => _prefs.getString('email') ?? '';

  int get bestScore => _prefs.getInt(_bestScoreKey) ?? 0;
  int get lastScore => _prefs.getInt(_lastScoreKey) ?? 0;

  Future<void> setBestScore(int value) async => _prefs.setInt(_bestScoreKey, value);
  Future<void> setLastScore(int value) async => _prefs.setInt(_lastScoreKey, value);

  Future<void> updateBestScore(int score) async {
    final current = bestScore;
    if (score > current) {
      await setBestScore(score);
    }
    await setLastScore(score);
  }

  int get balance => _prefs.getInt(_balanceKey) ?? 1000;
  String get selectedEgg => _prefs.getString(_selectedEggKey) ?? 'default_egg.png';

  Future<void> updateBalance(int newBalance) async {
    await _prefs.setInt(_balanceKey, newBalance);
    notifyListeners();
  }

  Future<void> updateSelectedEgg(String eggAsset) async {
    final newEggAsset = _normalizePath(eggAsset);
    await _prefs.setString(_selectedEggKey, newEggAsset);
    notifyListeners();
  }

  String get avatarPath => _prefs.getString('avatarPath') ?? 'default_chicken.png';

  Future<void> setUsername(String value) async => await _prefs.setString('username', value);
  Future<void> setEmail(String value) async => await _prefs.setString('email', value);

  String _normalizePath(String inputPath) {
    var path = inputPath.trim();

    const prefix = 'assets/images/';
    if (path.startsWith(prefix)) {
      path = path.substring(prefix.length);
    }

    return path;
  }

  Future<void> setAvatarPath(String path) async {
    final normalized = _normalizePath(path);
    await _prefs.setString('avatarPath', normalized);
  }

}
