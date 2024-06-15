import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/screens/high_scores_screen.dart';
import 'package:sudoku/screens/settings_screen.dart';
import 'package:sudoku/screens/sudoku_screen.dart';
import 'package:sudoku/utils/settings/settings_manager.dart';
import 'package:sudoku/widgets/menu/menu_button.dart';
import 'package:sudoku/widgets/menu/menu_exit.dart';
 
class MenuScreenButtons extends StatelessWidget {
  final BuildContext context;
  const MenuScreenButtons({required this.context});
 
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MenuButton(
          text: 'menu.play'.tr(),
          onPressed: () {
            _loadGame();
          },
        ),
        const SizedBox(height: 20),
        MenuButton(
          text: 'High Scores',
          onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HighScoresScreen()),
            );
          },
        ),
        const SizedBox(height: 20),
        MenuButton(
          text: 'Settings',
          onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          },
        ),
        const SizedBox(height: 20),
        MenuButton(
          text: 'Exit',
          onPressed: () {
            DialogUtils.showExitDialog(context);
          },
        ),
      ],
    );
  }
    void _loadGame() async {
    int lives = SettingsManager().isUnlimitedLivesEnabled() ? -1 : 3;
    String difficulty = SettingsManager().getSelectedDifficulty();
    bool music = SettingsManager().areSoundsEnabled();
    bool vibration = SettingsManager().areVibrationEnabled();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SudokuScreen(lives, difficulty, music, vibration)),
      );
    }
}