// To parse this JSON data, do
//
//     final userSignUpModel = userSignUpModelFromJson(jsonString);

import 'dart:convert';

UserSignUpModel userSignUpModelFromJson(String str) => UserSignUpModel.fromJson(json.decode(str));

String userSignUpModelToJson(UserSignUpModel data) => json.encode(data.toJson());

class UserSignUpModel {
  Verification? verification;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  bool? isEmailVerified;
  String? role;
  String? status;
  bool? isSocial;
  dynamic fcmToken;
  Profile? profile;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserSignUpModel({
    this.verification,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.isEmailVerified,
    this.role,
    this.status,
    this.isSocial,
    this.fcmToken,
    this.profile,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserSignUpModel.fromJson(Map<String, dynamic> json) => UserSignUpModel(
    verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phone: json["phone"],
    isEmailVerified: json["isEmailVerified"],
    role: json["role"],
    status: json["status"],
    isSocial: json["isSocial"],
    fcmToken: json["fcmToken"],
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "verification": verification?.toJson(),
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
    "isEmailVerified": isEmailVerified,
    "role": role,
    "status": status,
    "isSocial": isSocial,
    "fcmToken": fcmToken,
    "profile": profile?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Profile {
  String? id;
  String? address;
  DateTime? dateOfBirth;
  String? gender;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? user;

  Profile({
    this.id,
    this.address,
    this.dateOfBirth,
    this.gender,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.user,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["_id"],
    address: json["address"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    gender: json["gender"],
    image: json["image"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "address": address,
    "dateOfBirth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "image": image,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "user": user,
  };
}

class Verification {
  String? code;
  DateTime? expireDate;

  Verification({
    this.code,
    this.expireDate,
  });

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
    code: json["code"],
    expireDate: json["expireDate"] == null ? null : DateTime.parse(json["expireDate"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "expireDate": expireDate?.toIso8601String(),
  };
}
