class PlayerModel {
  final String id;
  final String name;
  final String profileImage;
  final String position;
  final String nationality;
  final int age;
  final String battingStyle;
  final String bowlingStyle;
  final Map<String, dynamic> stats;
  final String socialMediaHandle;

  PlayerModel({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.position,
    required this.nationality,
    required this.age,
    required this.battingStyle,
    required this.bowlingStyle,
    required this.stats,
    required this.socialMediaHandle,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      profileImage: json['profileImage'] ?? '',
      position: json['position'] ?? '',
      nationality: json['nationality'] ?? '',
      age: json['age'] ?? 0,
      battingStyle: json['battingStyle'] ?? '',
      bowlingStyle: json['bowlingStyle'] ?? '',
      stats: json['stats'] ?? {},
      socialMediaHandle: json['socialMediaHandle'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profileImage': profileImage,
      'position': position,
      'nationality': nationality,
      'age': age,
      'battingStyle': battingStyle,
      'bowlingStyle': bowlingStyle,
      'stats': stats,
      'socialMediaHandle': socialMediaHandle,
    };
  }
}