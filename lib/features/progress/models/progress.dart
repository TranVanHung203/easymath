import 'package:equatable/equatable.dart';

class Progress extends Equatable {
  const Progress({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.progressName,
    required this.content,
  });

  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final String? progressName;
  final List<Content> content;

  Progress copyWith({
    int? page,
    int? perPage,
    int? total,
    int? totalPages,
    String? progressName,
    List<Content>? content,
  }) {
    return Progress(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
      totalPages: totalPages ?? this.totalPages,
      progressName: progressName ?? this.progressName,
      content: content ?? this.content,
    );
  }

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      page: json["page"],
      perPage: json["perPage"],
      total: json["total"],
      totalPages: json["totalPages"],
      progressName: json["progressName"],
      content: json["content"] == null
          ? []
          : List<Content>.from(
              json["content"]!.map((x) => Content.fromJson(x)),
            ),
    );
  }

  @override
  List<Object?> get props => [
    page,
    perPage,
    total,
    totalPages,
    progressName,
    content,
  ];
}

class Content extends Equatable {
  const Content({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.voiceDescription,
    required this.url,
    required this.totalQuestion,
    required this.progressId,
    required this.isCompleted,
    required this.isLocked,
  });

  final String? id;
  final String? type;
  final String? title;
  final String? description;
  final String? voiceDescription;
  final String? url;
  final dynamic totalQuestion;
  final String? progressId;
  final bool? isCompleted;
  final bool? isLocked;

  Content copyWith({
    String? id,
    String? type,
    String? title,
    String? description,
    String? voiceDescription,
    String? url,
    dynamic totalQuestion,
    String? progressId,
    bool? isCompleted,
    bool? isLocked,
  }) {
    return Content(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      voiceDescription: voiceDescription ?? this.voiceDescription,
      url: url ?? this.url,
      totalQuestion: totalQuestion ?? this.totalQuestion,
      progressId: progressId ?? this.progressId,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json["_id"],
      type: json["type"],
      title: json["title"],
      description: json["description"],
      voiceDescription: json["voiceDescription"],
      url: json["url"],
      totalQuestion: json["totalQuestion"],
      progressId: json["progressId"],
      isCompleted: json["isCompleted"],
      isLocked: json["isLocked"],
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    title,
    description,
    voiceDescription,
    url,
    totalQuestion,
    progressId,
    isCompleted,
    isLocked,
  ];
}
