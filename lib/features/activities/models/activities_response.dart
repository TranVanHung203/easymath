import 'package:equatable/equatable.dart';

class ActivitiesResponse extends Equatable {
  const ActivitiesResponse({
    required this.message,
    required this.userActivity,
    required this.bonusEarned,
    required this.nextStep,
    required this.isCheck,
    required this.isDone,
  });

  final String? message;
  final UserActivity? userActivity;
  final int? bonusEarned;
  final int? nextStep;
  final bool? isCheck;
  final bool? isDone;

  ActivitiesResponse copyWith({
    String? message,
    UserActivity? userActivity,
    int? bonusEarned,
    int? nextStep,
    bool? isCheck,
    bool? isDone,
  }) {
    return ActivitiesResponse(
      message: message ?? this.message,
      userActivity: userActivity ?? this.userActivity,
      bonusEarned: bonusEarned ?? this.bonusEarned,
      nextStep: nextStep ?? this.nextStep,
      isCheck: isCheck ?? this.isCheck,
      isDone: isDone ?? this.isDone,
    );
  }

  factory ActivitiesResponse.fromJson(Map<String, dynamic> json) {
    return ActivitiesResponse(
      message: json["message"],
      userActivity: json["userActivity"] == null
          ? null
          : UserActivity.fromJson(json["userActivity"]),
      bonusEarned: json["bonusEarned"],
      nextStep: json["nextStep"],
      isCheck: json["isCheck"],
      isDone: json["isDone"],
    );
  }

  @override
  List<Object?> get props => [
    message,
    userActivity,
    bonusEarned,
    nextStep,
    isCheck,
    isDone,
  ];
}

class UserActivity extends Equatable {
  const UserActivity({
    required this.id,
    required this.userId,
    required this.progressId,
    required this.contentType,
    required this.score,
    required this.isCompleted,
    required this.bonusEarned,
    required this.completedAt,
    required this.v,
  });

  final String? id;
  final String? userId;
  final String? progressId;
  final String? contentType;
  final int? score;
  final bool? isCompleted;
  final int? bonusEarned;
  final DateTime? completedAt;
  final int? v;

  UserActivity copyWith({
    String? id,
    String? userId,
    String? progressId,
    String? contentType,
    int? score,
    bool? isCompleted,
    int? bonusEarned,
    DateTime? completedAt,
    int? v,
  }) {
    return UserActivity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      progressId: progressId ?? this.progressId,
      contentType: contentType ?? this.contentType,
      score: score ?? this.score,
      isCompleted: isCompleted ?? this.isCompleted,
      bonusEarned: bonusEarned ?? this.bonusEarned,
      completedAt: completedAt ?? this.completedAt,
      v: v ?? this.v,
    );
  }

  factory UserActivity.fromJson(Map<String, dynamic> json) {
    return UserActivity(
      id: json["_id"],
      userId: json["userId"],
      progressId: json["progressId"],
      contentType: json["contentType"],
      score: json["score"],
      isCompleted: json["isCompleted"],
      bonusEarned: json["bonusEarned"],
      completedAt: DateTime.tryParse(json["completedAt"] ?? ""),
      v: json["__v"],
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    progressId,
    contentType,
    score,
    isCompleted,
    bonusEarned,
    completedAt,
    v,
  ];
}
