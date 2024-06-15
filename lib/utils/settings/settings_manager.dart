import 'package:sudoku/utils/shared_prefs.dart';
 
class SettingsManager {
  final _prefs = SharedPreferencesManager().preferences;
 
  String getSelectedDifficulty() {
    return _prefs.getString('difficulty') ?? 'easy';
  }
 
  Future<void> setSelectedDifficulty(String difficulty) async {
    await _prefs.setString('difficulty', difficulty);
  }
 
  String getSelectedLanguage() {
    return _prefs.getString('language') ?? 'english';
  }
 
  Future<void> setSelectedLanguage(String language) async {
    await _prefs.setString('language', language);
  }
 
  bool isUnlimitedLivesEnabled() {
    return _prefs.getBool('unlimitedLivesEnabled') ?? false;
  }
 
  Future<void> setUnlimitedLivesEnabled(bool enabled) async {
    await _prefs.setBool('unlimitedLivesEnabled', enabled);
  }
 
  bool areSoundsEnabled() {
    return _prefs.getBool('soundsEnabled') ?? false;
  }
 
  Future<void> setSoundsEnabled(bool enabled) async {
    await _prefs.setBool('soundsEnabled', enabled);
  }
 
  bool areVibrationEnabled() {
    return _prefs.getBool('vibrationEnabled') ?? false;
  }
 
  Future<void> setVibrationEnabled(bool enabled) async {
    await _prefs.setBool('vibrationEnabled', enabled);
  }
}
