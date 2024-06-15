import 'package:flutter/material.dart';
import 'package:sudoku/utils/settings/settings_manager.dart';
import 'package:sudoku/utils/shared_prefs.dart';
import 'package:sudoku/widgets/settings/dropdown_setting.dart';
import 'package:sudoku/widgets/settings/switch_setting.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>{
  String _selectedDifficulty = 'easy';
  String _selectedLanguage = 'english';
  bool _unlimitedLivesEnabled = false;
  bool _soundsEnabled = false;
  bool _vibrationEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    setState((){  
      _selectedDifficulty = SettingsManager().getSelectedDifficulty();
      _selectedLanguage = SettingsManager().getSelectedLanguage();
      _unlimitedLivesEnabled = SettingsManager().isUnlimitedLivesEnabled();
      _soundsEnabled = SettingsManager().areSoundsEnabled();
      _vibrationEnabled = SettingsManager().areVibrationEnabled();
    });
  }

  void _resetData() async {
    await SharedPreferencesManager().preferences.remove('highScoreData');
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          DropdownSetting(
            title: 'Default Difficulty',
            value: _selectedDifficulty,
            onChanged: (String value) {
              setState(() {
                _selectedDifficulty = value;
              });
              SettingsManager().setSelectedDifficulty(_selectedDifficulty);
            },
            items: ['easy', 'medium', 'hard'],
          ),
          DropdownSetting(
            title: 'Language',
            value: _selectedLanguage,
            onChanged: (String value) {
              setState(() {
                _selectedLanguage = value;
              });
              SettingsManager().setSelectedLanguage(_selectedLanguage);
            },
            items: ['english', 'polish'],
          ),
          SwitchSetting(
            title: 'Sounds',
            value: _soundsEnabled,
            onChanged: (bool value) {
              setState(() {
                _soundsEnabled = value;
              });
              SettingsManager().setSoundsEnabled(_soundsEnabled);
            },
          ),
          SwitchSetting(
            title: 'Vibration',
            value: _vibrationEnabled,
            onChanged: (bool value) {
              setState(() {
                _vibrationEnabled = value;
              });
              SettingsManager().setVibrationEnabled(_vibrationEnabled);
            },
          ),
          SwitchSetting(
            title: 'Unlimited lives',
            value: _unlimitedLivesEnabled,
            onChanged: (bool value) {
              setState(() {
                _unlimitedLivesEnabled = value;
              });
              SettingsManager().setUnlimitedLivesEnabled(_unlimitedLivesEnabled);
            },
          ),
          ElevatedButton(
            onPressed: _resetData,
            child: Text('Reset data'),
          ),
        ],
      ),
    );
  }
}