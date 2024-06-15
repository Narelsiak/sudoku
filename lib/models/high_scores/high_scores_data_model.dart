class HighScoreData {
  int easyCounter;
  int mediumCounter;
  int hardCounter;
  double easyAvg;
  double mediumAvg;
  double hardAvg;
  List<int> easyTop;
  List<int> mediumTop;
  List<int> hardTop;

  HighScoreData({
    required this.easyCounter,
    required this.mediumCounter,
    required this.hardCounter,
    required this.easyAvg,
    required this.mediumAvg,
    required this.hardAvg,
    required this.easyTop,
    required this.mediumTop,
    required this.hardTop,
  });

  HighScoreData copyWith({
    int? easyCounter,
    int? mediumCounter,
    int? hardCounter,
    double? easyAvg,
    double? mediumAvg,
    double? hardAvg,
    List<int>? easyTop,
    List<int>? mediumTop,
    List<int>? hardTop,
  }) {
    return HighScoreData(
      easyCounter: easyCounter ?? this.easyCounter,
      mediumCounter: mediumCounter ?? this.mediumCounter,
      hardCounter: hardCounter ?? this.hardCounter,
      easyAvg: easyAvg ?? this.easyAvg,
      mediumAvg: mediumAvg ?? this.mediumAvg,
      hardAvg: hardAvg ?? this.hardAvg,
      easyTop: easyTop ?? this.easyTop,
      mediumTop: mediumTop ?? this.mediumTop,
      hardTop: hardTop ?? this.hardTop,
    );
  }

  factory HighScoreData.fromJson(Map<String, dynamic> json) {
    return HighScoreData(
      easyCounter: json['easy_counter'] ?? 0,
      mediumCounter: json['medium_counter'] ?? 0,
      hardCounter: json['hard_counter'] ?? 0,
      easyAvg: json['easy_avg'] ?? 0.0,
      mediumAvg: json['medium_avg'] ?? 0.0,
      hardAvg: json['hard_avg'] ?? 0.0,
      easyTop: List<int>.from(json['easy_top'] ?? []),
      mediumTop: List<int>.from(json['medium_top'] ?? []),
      hardTop: List<int>.from(json['hard_top'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'easy_counter': easyCounter,
      'medium_counter': mediumCounter,
      'hard_counter': hardCounter,
      'easy_avg': easyAvg,
      'medium_avg': mediumAvg,
      'hard_avg': hardAvg,
      'easy_top': easyTop,
      'medium_top': mediumTop,
      'hard_top': hardTop,
    };
  }
}