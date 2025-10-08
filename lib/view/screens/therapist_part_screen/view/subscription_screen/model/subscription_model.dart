// To parse this JSON data, do
//
//     final subScriptionModel = subScriptionModelFromJson(jsonString);

import 'dart:convert';

SubScriptionModel subScriptionModelFromJson(String str) => SubScriptionModel.fromJson(json.decode(str));

String subScriptionModelToJson(SubScriptionModel data) => json.encode(data.toJson());

class SubScriptionModel {
  final Price? price;
  final Validity? validity;
  final String? id;
  final String? name;
  final List<String>? features;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  SubScriptionModel({
    this.price,
    this.validity,
    this.id,
    this.name,
    this.features,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  SubScriptionModel copyWith({
    Price? price,
    Validity? validity,
    String? id,
    String? name,
    List<String>? features,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      SubScriptionModel(
        price: price ?? this.price,
        validity: validity ?? this.validity,
        id: id ?? this.id,
        name: name ?? this.name,
        features: features ?? this.features,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory SubScriptionModel.fromJson(Map<String, dynamic> json) => SubScriptionModel(
    price: json["price"] == null ? null : Price.fromJson(json["price"]),
    validity: json["validity"] == null ? null : Validity.fromJson(json["validity"]),
    id: json["_id"],
    name: json["name"],
    features: json["features"] == null ? [] : List<String>.from(json["features"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "price": price?.toJson(),
    "validity": validity?.toJson(),
    "_id": id,
    "name": name,
    "features": features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Price {
  final String? currency;
  final int? amount;

  Price({
    this.currency,
    this.amount,
  });

  Price copyWith({
    String? currency,
    int? amount,
  }) =>
      Price(
        currency: currency ?? this.currency,
        amount: amount ?? this.amount,
      );

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    currency: json["currency"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "amount": amount,
  };
}

class Validity {
  final String? type;
  final int? value;

  Validity({
    this.type,
    this.value,
  });

  Validity copyWith({
    String? type,
    int? value,
  }) =>
      Validity(
        type: type ?? this.type,
        value: value ?? this.value,
      );

  factory Validity.fromJson(Map<String, dynamic> json) => Validity(
    type: json["type"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
  };
}
