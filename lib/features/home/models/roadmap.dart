import 'package:equatable/equatable.dart';

class Roadmap extends Equatable {
  const Roadmap({required this.chapter, required this.skills});

  final Chapter? chapter;
  final List<Skill> skills;

  Roadmap copyWith({Chapter? chapter, List<Skill>? skills}) {
    return Roadmap(
      chapter: chapter ?? this.chapter,
      skills: skills ?? this.skills,
    );
  }

  factory Roadmap.fromJson(Map<String, dynamic> json) {
    return Roadmap(
      chapter: json["chapter"] == null
          ? null
          : Chapter.fromJson(json["chapter"]),
      skills: json["skills"] == null
          ? []
          : List<Skill>.from(json["skills"]!.map((x) => Skill.fromJson(x))),
    );
  }

  @override
  List<Object?> get props => [chapter, skills];
}

class Chapter extends Equatable {
  const Chapter({
    required this.id,
    required this.chapterName,
    required this.description,
    required this.order,
  });

  final String? id;
  final String? chapterName;
  final String? description;
  final int? order;

  Chapter copyWith({
    String? id,
    String? chapterName,
    String? description,
    int? order,
  }) {
    return Chapter(
      id: id ?? this.id,
      chapterName: chapterName ?? this.chapterName,
      description: description ?? this.description,
      order: order ?? this.order,
    );
  }

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json["_id"],
      chapterName: json["chapterName"],
      description: json["description"],
      order: json["order"],
    );
  }

  @override
  List<Object?> get props => [id, chapterName, description, order];
}

class Skill extends Equatable {
  const Skill({
    required this.id,
    required this.skillName,
    required this.skillVoice,
    required this.description,
    required this.order,
    required this.isCompleted,
    required this.progresses,
  });

  final String? id;
  final String? skillName;
  final String? skillVoice;
  final String? description;
  final int? order;
  final bool? isCompleted;
  final List<Progress> progresses;

  Skill copyWith({
    String? id,
    String? skillName,
    String? skillVoice,
    String? description,
    int? order,
    bool? isCompleted,
    List<Progress>? progresses,
  }) {
    return Skill(
      id: id ?? this.id,
      skillName: skillName ?? this.skillName,
      skillVoice: skillVoice ?? this.skillVoice,
      description: description ?? this.description,
      order: order ?? this.order,
      isCompleted: isCompleted ?? this.isCompleted,
      progresses: progresses ?? this.progresses,
    );
  }

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json["_id"],
      skillName: json["skillName"],
      skillVoice: json["skillVoice"],
      description: json["description"],
      order: json["order"],
      isCompleted: json["isCompleted"],
      progresses: json["progresses"] == null
          ? []
          : List<Progress>.from(
              json["progresses"]!.map((x) => Progress.fromJson(x)),
            ),
    );
  }

  @override
  List<Object?> get props => [
    id,
    skillName,
    skillVoice,
    description,
    order,
    isCompleted,
    progresses,
  ];
}

class Progress extends Equatable {
  const Progress({
    required this.id,
    required this.progressName,
    required this.stepNumber,
    required this.contentType,
    required this.isCompleted,
    required this.totalVideo,
    required this.isCurrent,
  });

  final String? id;
  final String? progressName;
  final int? stepNumber;
  final String? contentType;
  final bool? isCompleted;
  final int? totalVideo;
  final bool? isCurrent;

  Progress copyWith({
    String? id,
    String? progressName,
    int? stepNumber,
    String? contentType,
    bool? isCompleted,
    int? totalVideo,
    bool? isCurrent,
  }) {
    return Progress(
      id: id ?? this.id,
      progressName: progressName ?? this.progressName,
      stepNumber: stepNumber ?? this.stepNumber,
      contentType: contentType ?? this.contentType,
      isCompleted: isCompleted ?? this.isCompleted,
      totalVideo: totalVideo ?? this.totalVideo,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json["_id"],
      progressName: json["progressName"],
      stepNumber: json["stepNumber"],
      contentType: json["contentType"],
      isCompleted: json["isCompleted"],
      totalVideo: json["totalVideo"],
      isCurrent: json["isCurrent"],
    );
  }

  @override
  List<Object?> get props => [
    id,
    progressName,
    stepNumber,
    contentType,
    isCompleted,
    totalVideo,
    isCurrent,
  ];
}
