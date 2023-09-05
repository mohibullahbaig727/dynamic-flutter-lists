class User {
  final int userId;
  final String username;
  final int gender;
  final String dateOfBirth;
  final String municipality;
  final String province;
  final String pictureUrl;

  User({
    required this.userId,
    required this.username,
    required this.gender,
    required this.dateOfBirth,
    required this.municipality,
    required this.province,
    required this.pictureUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      username: json['username'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      municipality: json['municipality'],
      province: json['province'],
      pictureUrl: json['pictureUrl'],
    );
  }
}
