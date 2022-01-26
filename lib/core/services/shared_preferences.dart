import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static SharedPreferences? _prefs;

  static const _keyUserToken = 'token';
  static const _keyFirstName = 'first_name';
  static const _keyLastName = 'last_name';
  static const _keyVerified = 'verified';

  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static Future setToken(String token) async =>
      await _prefs!.setString(_keyUserToken, token);

  static String? getToken() => _prefs!.getString(_keyUserToken);

  static Future setFirstName(String firstName) async =>
      await _prefs!.setString(_keyFirstName, firstName);

  static String? getFirstName() => _prefs!.getString(_keyFirstName);

  static Future setLastName(String lastName) async =>
      await _prefs!.setString(_keyLastName, lastName);

  static String? getLastName() => _prefs!.getString(_keyLastName);

  static Future setVerified(bool verified) async =>
      await _prefs!.setBool(_keyVerified, verified);

  static bool? getVerified() => _prefs!.getBool(_keyVerified);
}
