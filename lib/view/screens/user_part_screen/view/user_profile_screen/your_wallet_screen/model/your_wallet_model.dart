// To parse this JSON data, do
//
//     final yourWalletModel = yourWalletModelFromJson(jsonString);
import 'dart:convert';
YourWalletModel yourWalletModelFromJson(String str) => YourWalletModel.fromJson(json.decode(str));
String yourWalletModelToJson(YourWalletModel data) => json.encode(data.toJson());

class YourWalletModel {
  final User? user;
  final Balance? balance;
  final Balance? holdBalance;
  final String? id;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  YourWalletModel({
    this.user,
    this.balance,
    this.holdBalance,
    this.id,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  YourWalletModel copyWith({
    User? user,
    Balance? balance,
    Balance? holdBalance,
    String? id,
    int? v,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      YourWalletModel(
        user: user ?? this.user,
        balance: balance ?? this.balance,
        holdBalance: holdBalance ?? this.holdBalance,
        id: id ?? this.id,
        v: v ?? this.v,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory YourWalletModel.fromJson(Map<String, dynamic> json) => YourWalletModel(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    balance: json["balance"] == null ? null : Balance.fromJson(json["balance"]),
    holdBalance: json["holdBalance"] == null ? null : Balance.fromJson(json["holdBalance"]),
    id: json["_id"],
    v: json["__v"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "balance": balance?.toJson(),
    "holdBalance": holdBalance?.toJson(),
    "_id": id,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Balance {
  final int? amount;
  final String? currency;

  Balance({
    this.amount,
    this.currency,
  });

  Balance copyWith({
    int? amount,
    String? currency,
  }) =>
      Balance(
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
      );

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
    amount: json["amount"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
  };
}

class User {
  final String? type;
  final String? id;

  User({
    this.type,
    this.id,
  });

  User copyWith({
    String? type,
    String? id,
  }) =>
      User(
        type: type ?? this.type,
        id: id ?? this.id,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    type: json["type"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
  };
}
