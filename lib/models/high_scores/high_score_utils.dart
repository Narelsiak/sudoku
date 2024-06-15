class Score {
  final String difficulty;
  final String score;

  Score(this.difficulty, this.score);
}

class Stats {
  final String difficulty;
  final int totalLevels;
  final String averageTime;
  final List scores;
  Stats(this.difficulty, this.totalLevels, this.averageTime, this.scores);
}