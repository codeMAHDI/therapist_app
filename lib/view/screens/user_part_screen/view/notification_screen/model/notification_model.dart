// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  final Content? content;
  final String? id;
  final String? consumer;
  final bool? isDismissed;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  NotificationModel({
    this.content,
    this.id,
    this.consumer,
    this.isDismissed,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  NotificationModel copyWith({
    Content? content,
    String? id,
    String? consumer,
    bool? isDismissed,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      NotificationModel(
        content: content ?? this.content,
        id: id ?? this.id,
        consumer: consumer ?? this.consumer,
        isDismissed: isDismissed ?? this.isDismissed,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    content: json["content"] == null ? null : Content.fromJson(json["content"]),
    id: json["_id"],
    consumer: json["consumer"],
    isDismissed: json["isDismissed"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "content": content?.toJson(),
    "_id": id,
    "consumer": consumer,
    "isDismissed": isDismissed,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Content {
  final Source? source;
  final String? title;
  final String? message;

  Content({
    this.source,
    this.title,
    this.message,
  });

  Content copyWith({
    Source? source,
    String? title,
    String? message,
  }) =>
      Content(
        source: source ?? this.source,
        title: title ?? this.title,
        message: message ?? this.message,
      );

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    source: json["source"] == null ? null : Source.fromJson(json["source"]),
    title: json["title"],
    message: json["message"],

  );

  Map<String, dynamic> toJson() => {
    "source": source?.toJson(),
    "title": title,
    "message": message,
  };
}

class Source {
  final String? type;
  final String? id;

  Source({
    this.type,
    this.id,
  });

  Source copyWith({
    String? type,
    String? id,
  }) =>
      Source(
        type: type ?? this.type,
        id: id ?? this.id,
      );

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    type: json["type"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
  };
}
