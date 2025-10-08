// // To parse this JSON data, do
// //
// //     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

class UserProfileModel {
  final Verification? verification;
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final bool? isEmailVerified;
  final String? role;
  final String? status;
  final bool? isSocial;
  final dynamic fcmToken;
  final Profile? profile;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  UserProfileModel({
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

  factory UserProfileModel.fromRawJson(String str) =>
      UserProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        verification: json["verification"] == null
            ? null
            : Verification.fromJson(json["verification"]),
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
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
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
  final String? id;
  final String? address;
  final DateTime? dateOfBirth;
  final String? gender;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? user;
  final String? image;

  Profile({
    this.id,
    this.address,
    this.dateOfBirth,
    this.gender,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.user,
    this.image,
  });

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"],
        address: json["address"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        gender: json["gender"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        user: json["user"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "address": address,
        "dateOfBirth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "user": user,
        "image": image,
      };
}

class Verification {
  final dynamic code;
  final dynamic expireDate;

  Verification({
    this.code,
    this.expireDate,
  });

  factory Verification.fromRawJson(String str) =>
      Verification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
        code: json["code"],
        expireDate: json["expireDate"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "expireDate": expireDate,
      };
}

// import 'dart:convert';

// UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

// String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

// class UserProfileModel {
//   final Verification? verification;
//   final String? id;
//   final String? firstName;
//   final String? lastName;
//   final String? email;
//   final String? phone;
//   final bool? isEmailVerified;
//   final String? role;
//   final String? status;
//   final bool? isSocial;
//   final dynamic fcmToken;
//   final Profile? profile;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;

//   UserProfileModel({
//     this.verification,
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.phone,
//     this.isEmailVerified,
//     this.role,
//     this.status,
//     this.isSocial,
//     this.fcmToken,
//     this.profile,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   UserProfileModel copyWith({
//     Verification? verification,
//     String? id,
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? phone,
//     bool? isEmailVerified,
//     String? role,
//     String? status,
//     bool? isSocial,
//     dynamic fcmToken,
//     Profile? profile,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     int? v,
//   }) =>
//       UserProfileModel(
//         verification: verification ?? this.verification,
//         id: id ?? this.id,
//         firstName: firstName ?? this.firstName,
//         lastName: lastName ?? this.lastName,
//         email: email ?? this.email,
//         phone: phone ?? this.phone,
//         isEmailVerified: isEmailVerified ?? this.isEmailVerified,
//         role: role ?? this.role,
//         status: status ?? this.status,
//         isSocial: isSocial ?? this.isSocial,
//         fcmToken: fcmToken ?? this.fcmToken,
//         profile: profile ?? this.profile,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         v: v ?? this.v,
//       );

//   factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
//     verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
//     id: json["_id"],
//     firstName: json["firstName"],
//     lastName: json["lastName"],
//     email: json["email"],
//     phone: json["phone"],
//     isEmailVerified: json["isEmailVerified"],
//     role: json["role"],
//     status: json["status"],
//     isSocial: json["isSocial"],
//     fcmToken: json["fcmToken"],
//     profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//   );

//   Map<String, dynamic> toJson() => {
//     "verification": verification?.toJson(),
//     "_id": id,
//     "firstName": firstName,
//     "lastName": lastName,
//     "email": email,
//     "phone": phone,
//     "isEmailVerified": isEmailVerified,
//     "role": role,
//     "status": status,
//     "isSocial": isSocial,
//     "fcmToken": fcmToken,
//     "profile": profile?.toJson(),
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "__v": v,
//   };
// }

// class Profile {
//   final String? id;
//   final String? address;
//   final DateTime? dateOfBirth;
//   final String? gender;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;
//   final String? user;

//   Profile({
//     this.id,
//     this.address,
//     this.dateOfBirth,
//     this.gender,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.user,
//   });

//   Profile copyWith({
//     String? id,
//     String? address,
//     DateTime? dateOfBirth,
//     String? gender,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     int? v,
//     String? user,
//   }) =>
//       Profile(
//         id: id ?? this.id,
//         address: address ?? this.address,
//         dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//         gender: gender ?? this.gender,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         v: v ?? this.v,
//         user: user ?? this.user,
//       );

//   factory Profile.fromJson(Map<String, dynamic> json) => Profile(
//     id: json["_id"],
//     address: json["address"],
//     dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
//     gender: json["gender"],
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//     user: json["user"],
//   );

//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "address": address,
//     "dateOfBirth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
//     "gender": gender,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "__v": v,
//     "user": user,
//   };
// }

// class Verification {
//   final String? code;
//   final DateTime? expireDate;

//   Verification({
//     this.code,
//     this.expireDate,
//   });

//   Verification copyWith({
//     String? code,
//     DateTime? expireDate,
//   }) =>
//       Verification(
//         code: code ?? this.code,
//         expireDate: expireDate ?? this.expireDate,
//       );

//   factory Verification.fromJson(Map<String, dynamic> json) => Verification(
//     code: json["code"],
//     expireDate: json["expireDate"] == null ? null : DateTime.parse(json["expireDate"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "code": code,
//     "expireDate": expireDate?.toIso8601String(),
//   };
// }
