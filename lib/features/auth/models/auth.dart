import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  const Auth({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  final String? message;
  final String? accessToken;
  final String? refreshToken;
  final User? user;

  Auth copyWith({
    String? message,
    String? accessToken,
    String? refreshToken,
    User? user,
  }) {
    return Auth(
      message: message ?? this.message,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
    );
  }

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      message: json["message"],
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "user": user?.toJson(),
  };

  @override
  List<Object?> get props => [message, accessToken, refreshToken, user];
}

class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.classId,
  });

  final String? id;
  final String? username;
  final String? email;
  final String? fullName;
  final dynamic classId;

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? fullName,
    dynamic classId,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      classId: classId ?? this.classId,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      fullName: json["fullName"],
      classId: json["classId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "fullName": fullName,
    "classId": classId,
  };

  @override
  List<Object?> get props => [id, username, email, fullName, classId];
}
