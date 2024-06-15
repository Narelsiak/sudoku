import 'dart:convert';
import 'package:sudoku/models/high_scores/high_scores_data_model.dart';
import 'package:sudoku/utils/shared_prefs.dart';

class HighScoreManager {
  final prefs = SharedPreferencesManager().preferences;
  static const String _key = 'highScoreData';

  HighScoreManager();

  Future<void> saveData(HighScoreData data) async {
    final String jsonData = jsonEncode(data.toJson());
    await prefs.setString(_key, jsonData);
  }

  Future<HighScoreData> loadData() async {
    final String? jsonData = prefs.getString(_key);
    if (jsonData != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonData);
      return HighScoreData.fromJson(jsonMap);
    } else {
      return HighScoreData(
        easyCounter: 0,
        mediumCounter: 0,
        hardCounter: 0,
        easyAvg: 0.0,
        mediumAvg: 0.0,
        hardAvg: 0.0,
        easyTop: [],
        mediumTop: [],
        hardTop: [],
      );
    }
  }

  Future<void> updateStats(String difficulty, int levelsCompleted, int timeTaken) async {
    HighScoreData data = await loadData();

    switch (difficulty) {
      case 'easy':
        data.easyCounter += levelsCompleted;
        data.easyAvg = (data.easyAvg * (data.easyCounter - levelsCompleted) + timeTaken * levelsCompleted) / data.easyCounter;
        _updateTopScores(data.easyTop, timeTaken);
        break;
      case 'medium':
        data.mediumCounter += levelsCompleted;
        data.mediumAvg = (data.mediumAvg * (data.mediumCounter - levelsCompleted) + timeTaken * levelsCompleted) / data.mediumCounter;
        _updateTopScores(data.mediumTop, timeTaken);
        break;
      case 'hard':
        data.hardCounter += levelsCompleted;
        data.hardAvg = (data.hardAvg * (data.hardCounter - levelsCompleted) + timeTaken * levelsCompleted) / data.hardCounter;
        _updateTopScores(data.hardTop, timeTaken);
        break;
      default:
        throw Exception('Invalid difficulty');
    }

    await saveData(data);
  }

  void _updateTopScores(List<int> scores, int newScore) {
    scores.add(newScore);
    scores.sort();
    if (scores.length > 3) {
      scores = scores.sublist(0, 3);
    }
  }
}