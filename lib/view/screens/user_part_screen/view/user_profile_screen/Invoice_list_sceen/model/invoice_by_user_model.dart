// To parse this JSON data, do
//
//     final invoiceByUserModel = invoiceByUserModelFromJson(jsonString);
import 'dart:convert';
InvoiceByUserModel invoiceByUserModelFromJson(String str) => InvoiceByUserModel.fromJson(json.decode(str));
String invoiceByUserModelToJson(InvoiceByUserModel data) => json.encode(data.toJson());

class InvoiceByUserModel {
  final User? user;
  final String? id;
  final Appointment? appointment;
  final String? invoiceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  InvoiceByUserModel({
    this.user,
    this.id,
    this.appointment,
    this.invoiceId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  InvoiceByUserModel copyWith({
    User? user,
    String? id,
    Appointment? appointment,
    String? invoiceId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      InvoiceByUserModel(
        user: user ?? this.user,
        id: id ?? this.id,
        appointment: appointment ?? this.appointment,
        invoiceId: invoiceId ?? this.invoiceId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory InvoiceByUserModel.fromJson(Map<String, dynamic> json) => InvoiceByUserModel(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    id: json["_id"],
    appointment: json["appointment"] == null ? null : Appointment.fromJson(json["appointment"]),
    invoiceId: json["invoiceId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "_id": id,
    "appointment": appointment?.toJson(),
    "invoiceId": invoiceId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Appointment {
  final FeeInfo? feeInfo;
  final String? id;
  final Therapist? therapist;
  final DateTime? date;
  final String? slot;

  Appointment({
    this.feeInfo,
    this.id,
    this.therapist,
    this.date,
    this.slot,
  });

  Appointment copyWith({
    FeeInfo? feeInfo,
    String? id,
    Therapist? therapist,
    DateTime? date,
    String? slot,
  }) =>
      Appointment(
        feeInfo: feeInfo ?? this.feeInfo,
        id: id ?? this.id,
        therapist: therapist ?? this.therapist,
        date: date ?? this.date,
        slot: slot ?? this.slot,
      );

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    feeInfo: json["feeInfo"] == null ? null : FeeInfo.fromJson(json["feeInfo"]),
    id: json["_id"],
    therapist: json["therapist"] == null ? null : Therapist.fromJson(json["therapist"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    slot: json["slot"],
  );

  Map<String, dynamic> toJson() => {
    "feeInfo": feeInfo?.toJson(),
    "_id": id,
    "therapist": therapist?.toJson(),
    "date": date?.toIso8601String(),
    "slot": slot,
  };
}

class FeeInfo {
  final BookedFee? bookedFee;
  final String? patientTransactionId;

  FeeInfo({
    this.bookedFee,
    this.patientTransactionId,
  });

  FeeInfo copyWith({
    BookedFee? bookedFee,
    String? patientTransactionId,
  }) =>
      FeeInfo(
        bookedFee: bookedFee ?? this.bookedFee,
        patientTransactionId: patientTransactionId ?? this.patientTransactionId,
      );

  factory FeeInfo.fromJson(Map<String, dynamic> json) => FeeInfo(
    bookedFee: json["bookedFee"] == null ? null : BookedFee.fromJson(json["bookedFee"]),
    patientTransactionId: json["patientTransactionId"],
  );

  Map<String, dynamic> toJson() => {
    "bookedFee": bookedFee?.toJson(),
    "patientTransactionId": patientTransactionId,
  };
}

class BookedFee {
  final int? amount;
  final String? currency;

  BookedFee({
    this.amount,
    this.currency,
  });

  BookedFee copyWith({
    int? amount,
    String? currency,
  }) =>
      BookedFee(
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
      );

  factory BookedFee.fromJson(Map<String, dynamic> json) => BookedFee(
    amount: json["amount"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
  };
}

class Therapist {
  final String? id;
  final String? firstName;
  final String? lastName;

  Therapist({
    this.id,
    this.firstName,
    this.lastName,
  });

  Therapist copyWith({
    String? id,
    String? firstName,
    String? lastName,
  }) =>
      Therapist(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  factory Therapist.fromJson(Map<String, dynamic> json) => Therapist(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
  };
}

class User {
  final String? type;
  final Id? id;

  User({
    this.type,
    this.id,
  });

  User copyWith({
    String? type,
    Id? id,
  }) =>
      User(
        type: type ?? this.type,
        id: id ?? this.id,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    type: json["type"],
    id: json["id"] == null ? null : Id.fromJson(json["id"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id?.toJson(),
  };
}

class Id {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;

  Id({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
  });

  Id copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) =>
      Id(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
  };
}
