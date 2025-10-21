import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const _soundKey = 'soundOn';
  static const _notificationKey = 'notificationOn';
  static const _vibrationKey = 'vibrationOn';
  static const _bestScoreKey = 'bestScore';
  static const _lastScoreKey = 'lastScore';

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

  String get avatarPath => _prefs.getString('avatarPath') ?? '';

  Future<void> setUsername(String value) async => await _prefs.setString('username', value);
  Future<void> setEmail(String value) async => await _prefs.setString('email', value);

  String _normalizeAvatarPath(String inputPath) {
    var path = inputPath.trim();

    const prefix = 'assets/images/';
    if (path.startsWith(prefix)) {
      path = path.substring(prefix.length);
    }

    return path;
  }

  Future<void> setAvatarPath(String path) async {
    final normalized = _normalizeAvatarPath(path);
    await _prefs.setString('avatarPath', normalized);
  }

}
