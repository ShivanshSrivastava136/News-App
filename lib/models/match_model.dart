class MatchModel {
  final String id;
  final String opponent;
  final String opponentLogo;
  final DateTime matchDate;
  final String venue;
  final String matchType;
  final String status; // upcoming, live, completed
  final String? result;
  final int? kkrScore;
  final int? opponentScore;

  MatchModel({
    required this.id,
    required this.opponent,
    required this.opponentLogo,
    required this.matchDate,
    required this.venue,
    required this.matchType,
    required this.status,
    this.result,
    this.kkrScore,
    this.opponentScore,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] ?? '',
      opponent: json['opponent'] ?? '',
      opponentLogo: json['opponentLogo'] ?? '',
      matchDate: DateTime.parse(json['matchDate'] ?? DateTime.now().toIso8601String()),
      venue: json['venue'] ?? '',
      matchType: json['matchType'] ?? '',
      status: json['status'] ?? 'upcoming',
      result: json['result'],
      kkrScore: json['kkrScore'],
      opponentScore: json['opponentScore'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'opponent': opponent,
      'opponentLogo': opponentLogo,
      'matchDate': matchDate.toIso8601String(),
      'venue': venue,
      'matchType': matchType,
      'status': status,
      'result': result,
      'kkrScore': kkrScore,
      'opponentScore': opponentScore,
    };
  }
}