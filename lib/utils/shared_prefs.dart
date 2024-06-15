import 'package:shared_preferences/shared_preferences.dart';
 
class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  late SharedPreferences _preferences;
 
  SharedPreferencesManager._internal();
 
  factory SharedPreferencesManager() {
    _instance ??= SharedPreferencesManager._internal();
    return _instance!;
  }
 
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }
 
  void setString(String key, String value) {
    _preferences.setString(key, value);
  }
  
  SharedPreferences get preferences => _preferences;
}
