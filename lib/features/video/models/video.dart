import 'package:equatable/equatable.dart';

class Video extends Equatable {
  const Video({
    required this.id,
    required this.title,
    required this.url,
    required this.duration,
    required this.description,
    required this.createdAt,
    required this.v,
  });

  final String? id;
  final String? title;
  final String? url;
  final int? duration;
  final String? description;
  final DateTime? createdAt;
  final int? v;

  Video copyWith({
    String? id,
    String? title,
    String? url,
    int? duration,
    String? description,
    DateTime? createdAt,
    int? v,
  }) {
    return Video(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      v: v ?? this.v,
    );
  }

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json["_id"],
      title: json["title"],
      url: json["url"],
      duration: json["duration"],
      description: json["description"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "url": url,
    "duration": duration,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
  };

  @override
  List<Object?> get props => [
    id,
    title,
    url,
    duration,
    description,
    createdAt,
    v,
  ];
}
