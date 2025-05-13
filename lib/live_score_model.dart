class LiveScoreModel {
  final String title;
  final String team1;
  final String team2;
  final int team1Score;
  final int team2Score;
  final String winnerTeam;
  final bool isRunning;

  LiveScoreModel(
      {required this.title,
      required this.team1,
      required this.team2,
      required this.team1Score,
      required this.team2Score,
      required this.winnerTeam,
      required this.isRunning});

  factory LiveScoreModel.fromJson(String docId, Map<String, dynamic> jsonData) {
    return LiveScoreModel(
      title: docId,
      team1: jsonData["team1"] ?? 'Unknown',
      team2: jsonData["team2"] ?? 'Unknown',
      team1Score: _parseInt(jsonData["team1_score"]),
      team2Score: _parseInt(jsonData["team2_score"]),
      winnerTeam: jsonData['winner_team'] ?? 'TBD',
      isRunning: jsonData['isRunning'] ?? false,
    );
  }
  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;

    return 0;
  }
}
