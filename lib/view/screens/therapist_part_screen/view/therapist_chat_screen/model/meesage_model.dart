
import 'dart:convert';

class MessageModel2 {
    final String? id;
    final String? conversation;
    final Sender? sender;
    final String? senderRole;
    final String? type;
    final String? content;
    final List<String>? attachment;
    final String? createdAt;
    final DateTime? updatedAt;
    final int? v;

    MessageModel2({
        this.id,
        this.conversation,
        this.sender,
        this.senderRole,
        this.type,
        this.content,
        this.attachment,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory MessageModel2.fromRawJson(String str) => MessageModel2.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MessageModel2.fromJson(Map<String, dynamic> json) => MessageModel2(
        id: json["_id"],
        conversation: json["conversation"],
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        senderRole: json["senderRole"],
        type: json["type"],
        content: json["content"],
        attachment: json["attachment"] == null ? [] : List<String>.from(json["attachment"]!.map((x) => x)),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "conversation": conversation,
        "sender": sender?.toJson(),
        "senderRole": senderRole,
        "type": type,
        "content": content,
        "attachment": attachment == null ? [] : List<String>.from(attachment!.map((x) => x)),
        "createdAt": createdAt,
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Sender {
    final String? id;

    Sender({
        this.id,
    });

    factory Sender.fromRawJson(String str) => Sender.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
    };
}
