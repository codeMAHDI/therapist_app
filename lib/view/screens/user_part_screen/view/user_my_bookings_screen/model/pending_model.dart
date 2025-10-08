// To parse this JSON data, do
//
//     final pendingModel = pendingModelFromJson(jsonString);

import 'dart:convert';

PendingModel pendingModelFromJson(String str) => PendingModel.fromJson(json.decode(str));

String pendingModelToJson(PendingModel data) => json.encode(data.toJson());

class PendingModel {
  final Duration? duration;
  final FeeInfo? feeInfo;
  final dynamic rescheduleReason;
  final String? id;
  final String? patient;
  final Therapist? therapist;
  final DateTime? date;
  final String? slot;
  final String? reason;
  final String? description;
  final bool? isAvailableInWallet;
  final String? status;
  final dynamic cancelReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PendingModel({
    this.duration,
    this.feeInfo,
    this.rescheduleReason,
    this.id,
    this.patient,
    this.therapist,
    this.date,
    this.slot,
    this.reason,
    this.description,
    this.isAvailableInWallet,
    this.status,
    this.cancelReason,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  PendingModel copyWith({
    Duration? duration,
    FeeInfo? feeInfo,
    dynamic rescheduleReason,
    String? id,
    String? patient,
    Therapist? therapist,
    DateTime? date,
    String? slot,
    String? reason,
    String? description,
    bool? isAvailableInWallet,
    String? status,
    dynamic cancelReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      PendingModel(
        duration: duration ?? this.duration,
        feeInfo: feeInfo ?? this.feeInfo,
        rescheduleReason: rescheduleReason ?? this.rescheduleReason,
        id: id ?? this.id,
        patient: patient ?? this.patient,
        therapist: therapist ?? this.therapist,
        date: date ?? this.date,
        slot: slot ?? this.slot,
        reason: reason ?? this.reason,
        description: description ?? this.description,
        isAvailableInWallet: isAvailableInWallet ?? this.isAvailableInWallet,
        status: status ?? this.status,
        cancelReason: cancelReason ?? this.cancelReason,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory PendingModel.fromJson(Map<String, dynamic> json) => PendingModel(
    duration: json["duration"] == null ? null : Duration.fromJson(json["duration"]),
    feeInfo: json["feeInfo"] == null ? null : FeeInfo.fromJson(json["feeInfo"]),
    rescheduleReason: json["rescheduleReason"],
    id: json["_id"],
    patient: json["patient"],
    therapist: json["therapist"] == null ? null : Therapist.fromJson(json["therapist"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    slot: json["slot"],
    reason: json["reason"],
    description: json["description"],
    isAvailableInWallet: json["isAvailableInWallet"],
    status: json["status"],
    cancelReason: json["cancelReason"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "duration": duration?.toJson(),
    "feeInfo": feeInfo?.toJson(),
    "rescheduleReason": rescheduleReason,
    "_id": id,
    "patient": patient,
    "therapist": therapist?.toJson(),
    "date": date?.toIso8601String(),
    "slot": slot,
    "reason": reason,
    "description": description,
    "isAvailableInWallet": isAvailableInWallet,
    "status": status,
    "cancelReason": cancelReason,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Duration {
  final int? value;
  final String? unit;

  Duration({
    this.value,
    this.unit,
  });

  Duration copyWith({
    int? value,
    String? unit,
  }) =>
      Duration(
        value: value ?? this.value,
        unit: unit ?? this.unit,
      );

  factory Duration.fromJson(Map<String, dynamic> json) => Duration(
    value: json["value"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "unit": unit,
  };
}

class FeeInfo {
  final DFee? bookedFee;
  final DFee? holdFee;
  final String? patientTransactionId;
  final String? feeStatus;

  FeeInfo({
    this.bookedFee,
    this.holdFee,
    this.patientTransactionId,
    this.feeStatus,
  });

  FeeInfo copyWith({
    DFee? bookedFee,
    DFee? holdFee,
    String? patientTransactionId,
    String? feeStatus,
  }) =>
      FeeInfo(
        bookedFee: bookedFee ?? this.bookedFee,
        holdFee: holdFee ?? this.holdFee,
        patientTransactionId: patientTransactionId ?? this.patientTransactionId,
        feeStatus: feeStatus ?? this.feeStatus,
      );

  factory FeeInfo.fromJson(Map<String, dynamic> json) => FeeInfo(
    bookedFee: json["bookedFee"] == null ? null : DFee.fromJson(json["bookedFee"]),
    holdFee: json["holdFee"] == null ? null : DFee.fromJson(json["holdFee"]),
    patientTransactionId: json["patientTransactionId"],
    feeStatus: json["feeStatus"],
  );

  Map<String, dynamic> toJson() => {
    "bookedFee": bookedFee?.toJson(),
    "holdFee": holdFee?.toJson(),
    "patientTransactionId": patientTransactionId,
    "feeStatus": feeStatus,
  };
}

class DFee {
  final int? amount;
  final String? currency;

  DFee({
    this.amount,
    this.currency,
  });

  DFee copyWith({
    int? amount,
    String? currency,
  }) =>
      DFee(
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
      );

  factory DFee.fromJson(Map<String, dynamic> json) => DFee(
    amount: json["amount"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
  };
}

class Therapist {
  final Verification? verification;
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final bool? isEmailVerified;
  final String? role;
  final String? status;
  final Profile? profile;

  Therapist({
    this.verification,
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.isEmailVerified,
    this.role,
    this.status,
    this.profile,
  });

  Therapist copyWith({
    Verification? verification,
    String? id,
    String? firstName,
    String? lastName,
    String? phone,
    bool? isEmailVerified,
    String? role,
    String? status,
    Profile? profile,
  }) =>
      Therapist(
        verification: verification ?? this.verification,
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        role: role ?? this.role,
        status: status ?? this.status,
        profile: profile ?? this.profile,
      );

  factory Therapist.fromJson(Map<String, dynamic> json) => Therapist(
    verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phone: json["phone"],
    isEmailVerified: json["isEmailVerified"],
    role: json["role"],
    status: json["status"],
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "verification": verification?.toJson(),
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "isEmailVerified": isEmailVerified,
    "role": role,
    "status": status,
    "profile": profile?.toJson(),
  };
}

class Profile {
  final String? id;
  final String? image;
  final Speciality? speciality;

  Profile({
    this.id,
    this.image,
    this.speciality,
  });

  Profile copyWith({
    String? id,
    String? image,
    Speciality? speciality,
  }) =>
      Profile(
        id: id ?? this.id,
        image: image ?? this.image,
        speciality: speciality ?? this.speciality,
      );

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["_id"],
    image: json["image"],
    speciality: json["speciality"] == null ? null : Speciality.fromJson(json["speciality"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "speciality": speciality?.toJson(),
  };
}

class Speciality {
  final String? id;
  final String? name;

  Speciality({
    this.id,
    this.name,
  });

  Speciality copyWith({
    String? id,
    String? name,
  }) =>
      Speciality(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Speciality.fromJson(Map<String, dynamic> json) => Speciality(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

class Verification {
  final String? code;
  final DateTime? expireDate;

  Verification({
    this.code,
    this.expireDate,
  });

  Verification copyWith({
    String? code,
    DateTime? expireDate,
  }) =>
      Verification(
        code: code ?? this.code,
        expireDate: expireDate ?? this.expireDate,
      );

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
    code: json["code"],
    expireDate: json["expireDate"] == null ? null : DateTime.parse(json["expireDate"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "expireDate": expireDate?.toIso8601String(),
  };
} 


