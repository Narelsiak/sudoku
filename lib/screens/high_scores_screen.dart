
import 'package:flutter/material.dart';
import 'package:sudoku/models/high_scores/high_score_utils.dart';
import 'package:sudoku/utils/high_score/high_scores_manager.dart';

class HighScoresScreen extends StatefulWidget {
  @override
  State<HighScoresScreen> createState() => _HighScoresScreenState();
}

class _HighScoresScreenState extends State<HighScoresScreen> {
  List _stats = [];

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  List<Score> _generateScoresList(String type, List<int> topScores) {
    return [
      Score(type, topScores.isNotEmpty ? topScores[0].toString() : "N/D"),
      Score(type, topScores.length > 1 ? topScores[1].toString() : "N/D"),
      Score(type, topScores.length > 2 ? topScores[2].toString() : "N/D"),
    ];
  }
  Future<void> _loadStats() async {
    var data = await HighScoreManager().loadData();
    setState(() {
      _stats = [
        Stats(
          'Easy',
          data.easyCounter,
          data.easyAvg.toStringAsFixed(2),
          _generateScoresList('Easy', data.easyTop),
        ),
        Stats(
          'Medium',
          data.mediumCounter,
          data.mediumAvg.toStringAsFixed(2),
          _generateScoresList('Medium', data.mediumTop),
        ),
        Stats(
          'Hard',
          data.hardCounter,
          data.hardAvg.toStringAsFixed(2),
          _generateScoresList('Hard', data.hardTop),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scores'),
      ),
      body: ListView.builder(
        itemCount: _stats.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _stats[index].difficulty,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Levels: ${_stats[index].totalLevels}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Average Time: ${_stats[index].averageTime}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Top Scores:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < _stats[index].scores.length; i++)
                          Text(
                            '${i + 1}. ${_stats[index].scores[i].score}',
                            style: const TextStyle(fontSize: 16),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}