import 'dart:convert';

InvoiceListModel invoiceListModelFromJson(String str) =>
    InvoiceListModel.fromJson(json.decode(str));

String invoiceListModelToJson(InvoiceListModel data) =>
    json.encode(data.toJson());

class InvoiceListModel {
  final User? user;
  final String? id;
  final Appointment? appointment; // Updated to Appointment model
  final String? invoiceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  InvoiceListModel({
    this.user,
    this.id,
    this.appointment,  // Updated to Appointment model
    this.invoiceId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  InvoiceListModel copyWith({
    User? user,
    String? id,
    Appointment? appointment, // Updated to Appointment model
    String? invoiceId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      InvoiceListModel(
        user: user ?? this.user,
        id: id ?? this.id,
        appointment: appointment ?? this.appointment, // Updated to Appointment model
        invoiceId: invoiceId ?? this.invoiceId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory InvoiceListModel.fromJson(Map<String, dynamic> json) =>
      InvoiceListModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        id: json["_id"],
        appointment: json["appointment"] == null
            ? null
            : Appointment.fromJson(json["appointment"]), // Updated to Appointment model
        invoiceId: json["invoiceId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "_id": id,
    "appointment": appointment?.toJson(), // Updated to Appointment model
    "invoiceId": invoiceId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
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

  Id({
    this.id,
    this.firstName,
    this.lastName,
  });

  Id copyWith({
    String? id,
    String? firstName,
    String? lastName,
  }) =>
      Id(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  factory Id.fromJson(Map<String, dynamic> json) => Id(
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
    feeInfo: json["feeInfo"] == null
        ? null
        : FeeInfo.fromJson(json["feeInfo"]),
    id: json["_id"],
    therapist: json["therapist"] == null
        ? null
        : Therapist.fromJson(json["therapist"]),
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
  final MainFee? mainFee;
  final String? patientTransactionId;

  FeeInfo({
    this.mainFee,
    this.patientTransactionId,
  });

  FeeInfo copyWith({
    MainFee? mainFee,
    String? patientTransactionId,
  }) =>
      FeeInfo(
        mainFee: mainFee ?? this.mainFee,
        patientTransactionId: patientTransactionId ?? this.patientTransactionId,
      );

  factory FeeInfo.fromJson(Map<String, dynamic> json) => FeeInfo(
    mainFee: json["mainFee"] == null
        ? null
        : MainFee.fromJson(json["mainFee"]),
    patientTransactionId: json["patientTransactionId"],
  );

  Map<String, dynamic> toJson() => {
    "mainFee": mainFee?.toJson(),
    "patientTransactionId": patientTransactionId,
  };
}

class MainFee {
  final double? amount;
  final String? currency;

  MainFee({
    this.amount,
    this.currency,
  });

  MainFee copyWith({
    double? amount,
    String? currency,
  }) =>
      MainFee(
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
      );

  factory MainFee.fromJson(Map<String, dynamic> json) => MainFee(
    amount: json["amount"]?.toDouble(),
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