import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const _soundKey = 'soundOn';
  static const _notificationKey = 'notificationOn';
  static const _vibrationKey = 'vibrationOn';

  final SharedPreferences _prefs;

  SettingsService(this._prefs);

  bool get soundOn => _prefs.getBool(_soundKey) ?? true;
  bool get notificationOn => _prefs.getBool(_notificationKey) ?? true;
  bool get vibrationOn => _prefs.getBool(_vibrationKey) ?? true;

  Future<void> setSound(bool value) => _prefs.setBool(_soundKey, value);
  Future<void> setNotification(bool value) => _prefs.setBool(_notificationKey, value);
  Future<void> setVibration(bool value) => _prefs.setBool(_vibrationKey, value);

  Future<void> save({bool? sound, bool? notification, bool? vibration}) async {
    if (sound != null) await setSound(sound);
    if (notification != null) await setNotification(notification);
    if (vibration != null) await setVibration(vibration);
  }
}
