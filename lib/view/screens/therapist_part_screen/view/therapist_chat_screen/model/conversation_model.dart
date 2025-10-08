import 'dart:convert';

class ConvarsationModel {
    final Patient? patient;
    final Therapist? therapist;
    final LastMessage? lastMessage;
    final String? id;
    final String? appointment;
    final bool? isMarkAsCompleted;
    final int? memberCounts;
    final int? characterNewCount;
    final String? createdAt;
    final DateTime? updatedAt;
    final int? v;

    ConvarsationModel({
        this.patient,
        this.therapist,
        this.lastMessage,
        this.id,
        this.appointment,
        this.isMarkAsCompleted,
        this.memberCounts,
        this.characterNewCount,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory ConvarsationModel.fromRawJson(String str) => ConvarsationModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ConvarsationModel.fromJson(Map<String, dynamic> json) => ConvarsationModel(
        patient: json["patient"] == null ? null : Patient.fromJson(json["patient"]),
        therapist: json["therapist"] == null ? null : Therapist.fromJson(json["therapist"]),
        lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
        id: json["_id"],
        appointment: json["appointment"],
        isMarkAsCompleted: json["isMarkAsCompleted"],
        memberCounts: json["memberCounts"],
        characterNewCount: json["characterNewCount"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "patient": patient?.toJson(),
        "therapist": therapist?.toJson(),
        "lastMessage": lastMessage?.toJson(),
        "_id": id,
        "appointment": appointment,
        "isMarkAsCompleted": isMarkAsCompleted,
        "memberCounts": memberCounts,
        "characterNewCount": characterNewCount,
        "createdAt": createdAt,
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class LastMessage {
    final dynamic content;
    final Id? id;

    LastMessage({
        this.content,
        this.id,
    });

    factory LastMessage.fromRawJson(String str) => LastMessage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        content: json["content"],
        id: json["id"] == null ? null : Id.fromJson(json["id"]),
    );

    Map<String, dynamic> toJson() => {
        "content": content,
        "id": id?.toJson(),
    };
}

class Id {
    final String? id;
    final String? type;
    final String? content;
    final String? updatedAt;

    Id({
        this.id,
        this.type,
        this.content,
        this.updatedAt,
    });

    factory Id.fromRawJson(String str) => Id.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Id.fromJson(Map<String, dynamic> json) => Id(
        id: json["_id"],
        type: json["type"],
        content: json["content"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "content": content,
        "updatedAt": updatedAt,
    };
}

class Patient {
    final String? name;
    final TUserId? patientUserId;
    final String? profileImage; // Make sure this field exists

    Patient({
        this.name,
        this.patientUserId,
        this.profileImage, // Make sure this is in constructor
    });

    factory Patient.fromRawJson(String str) => Patient.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        name: json["name"],
        patientUserId: json["patientUserId"] == null ? null : TUserId.fromJson(json["patientUserId"]),
        profileImage: json["profileImage"], // Make sure this is parsed from JSON
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "patientUserId": patientUserId?.toJson(),
        "profileImage": profileImage, // Make sure this is in JSON output
    };

    Patient copyWith({
        String? name,
        TUserId? patientUserId,
        String? profileImage,
    }) {
        return Patient(
            name: name ?? this.name,
            patientUserId: patientUserId ?? this.patientUserId,
            profileImage: profileImage ?? this.profileImage,
        );
    }
}

class TUserId {
    final String? id;
    final String? firstName;
    final String? lastName;
    final String? role;

    TUserId({
        this.id,
        this.firstName,
        this.lastName,
        this.role,
    });

    factory TUserId.fromRawJson(String str) => TUserId.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TUserId.fromJson(Map<String, dynamic> json) => TUserId(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "role": role,
    };
}

class Therapist {
    final String? name;
    final TUserId? therapistUserId;

    Therapist({
        this.name,
        this.therapistUserId,
    });

    factory Therapist.fromRawJson(String str) => Therapist.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Therapist.fromJson(Map<String, dynamic> json) => Therapist(
        name: json["name"],
        therapistUserId: json["therapistUserId"] == null ? null : TUserId.fromJson(json["therapistUserId"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "therapistUserId": therapistUserId?.toJson(),
    };
}
