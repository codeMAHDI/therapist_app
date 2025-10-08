// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  final int? wordCount;
  final String? id;
  final String? conversation;
  final Sender? sender;
  final String? type;
  final String? content;
  final List<dynamic>? attachment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  MessageModel({
    this.wordCount,
    this.id,
    this.conversation,
    this.sender,
    this.type,
    this.content,
    this.attachment,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  MessageModel copyWith({
    int? wordCount,
    String? id,
    String? conversation,
    Sender? sender,
    String? type,
    String? content,
    List<dynamic>? attachment,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      MessageModel(
        wordCount: wordCount ?? this.wordCount,
        id: id ?? this.id,
        conversation: conversation ?? this.conversation,
        sender: sender ?? this.sender,
        type: type ?? this.type,
        content: content ?? this.content,
        attachment: attachment ?? this.attachment,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    wordCount: json["wordCount"],
    id: json["_id"],
    conversation: json["conversation"],
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    type: json["type"],
    content: json["content"],
    attachment: json["attachment"] == null ? [] : List<dynamic>.from(json["attachment"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "wordCount": wordCount,
    "_id": id,
    "conversation": conversation,
    "sender": sender?.toJson(),
    "type": type,
    "content": content,
    "attachment": attachment == null ? [] : List<dynamic>.from(attachment!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Sender {
  final String? id;

  Sender({
    this.id,
  });

  Sender copyWith({
    String? id,
  }) =>
      Sender(
        id: id ?? this.id,
      );

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
  };
}
