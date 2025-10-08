import 'dart:convert';

PaymentHistoryModel paymentHistoryModelFromJson(String str) =>
    PaymentHistoryModel.fromJson(json.decode(str));

String paymentHistoryModelToJson(PaymentHistoryModel data) =>
    json.encode(data.toJson());

class PaymentHistoryModel {
  final String? id;
  final User? user;
  final String? purpose;
  final String? transactionId;
  final String? currency;
  final double? amount; // Amount should be double
  final String? paymentType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;

  PaymentHistoryModel({
    this.id,
    this.user,
    this.purpose,
    this.transactionId,
    this.currency,
    this.amount,
    this.paymentType,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  PaymentHistoryModel copyWith({
    String? id,
    User? user,
    String? purpose,
    String? transactionId,
    String? currency,
    double? amount,
    String? paymentType,
    DateTime? createdAt,
    DateTime? updatedAt,
    num? v,
  }) =>
      PaymentHistoryModel(
        id: id ?? this.id,
        user: user ?? this.user,
        purpose: purpose ?? this.purpose,
        transactionId: transactionId ?? this.transactionId,
        currency: currency ?? this.currency,
        amount: amount ?? this.amount,
        paymentType: paymentType ?? this.paymentType,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) =>
      PaymentHistoryModel(
        id: json["_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        purpose: json["purpose"],
        transactionId: json["transactionId"],
        currency: json["currency"],
        amount: json["amount"] is int
            ? (json["amount"] as int).toDouble() // Convert if it's int
            : json["amount"]?.toDouble(), // If it's already double, keep it
        paymentType: json["paymentType"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user?.toJson(),
    "purpose": purpose,
    "transactionId": transactionId,
    "currency": currency,
    "amount": amount,
    "paymentType": paymentType,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class User {
  final String? id;
  final String? firstName;
  final String? lastName;

  User({
    this.id,
    this.firstName,
    this.lastName,
  });

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
  }) =>
      User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
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