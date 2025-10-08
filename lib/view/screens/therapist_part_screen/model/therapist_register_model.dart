// To parse this JSON data, do
//
//     final therapistRegisterModel = therapistRegisterModelFromJson(jsonString);
import 'dart:convert';

TherapistRegisterModel therapistRegisterModelFromJson(String str) =>
    TherapistRegisterModel.fromJson(json.decode(str));

String therapistRegisterModelToJson(TherapistRegisterModel data) =>
    json.encode(data.toJson());

class TherapistRegisterModel {
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
  final num? v;

  TherapistRegisterModel({
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

  factory TherapistRegisterModel.fromJson(Map<String, dynamic> json) =>
      TherapistRegisterModel(
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

  // ========= MISSING METHOD ADDED BACK ========
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
// ============================================
}

class Profile {
  final num? chargePerHour;
  final String? id;
  final String? speciality;
  final String? subSpecialty;
  final String? professionalSummary;
  final String? experience;
  final String? curriculumVitae;
  final List<String>? certificates;
  final String? brandLogo;
  final String? image;
  final List<Availability>? availabilities;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;
  final String? user;

  Profile({
    this.chargePerHour,
    this.id,
    this.speciality,
    this.subSpecialty,
    this.professionalSummary,
    this.experience,
    this.curriculumVitae,
    this.certificates,
    this.brandLogo,
    this.image,
    this.availabilities,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.user,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    chargePerHour: _parseChargePerHour(json["chargePerHour"]),
    id: json["_id"],
    speciality: json["speciality"],
    subSpecialty: json["subSpecialty"],
    professionalSummary: json["professionalSummary"],
    experience: json["experience"],
    curriculumVitae: json["curriculumVitae"],
    certificates: json["certificates"] == null
        ? []
        : List<String>.from(json["certificates"]!.map((x) => x)),
    brandLogo: json["brandLogo"],
    image: json["image"],
    availabilities: json["availabilities"] == null
        ? []
        : List<Availability>.from(
        json["availabilities"]!.map((x) => Availability.fromJson(x))),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    user: json["user"],
  );

  // ========= MISSING METHOD ADDED BACK ========
  Map<String, dynamic> toJson() => {
    "chargePerHour": chargePerHour,
    "_id": id,
    "speciality": speciality,
    "subSpecialty": subSpecialty,
    "professionalSummary": professionalSummary,
    "experience": experience,
    "curriculumVitae": curriculumVitae,
    "certificates": certificates == null
        ? []
        : List<dynamic>.from(certificates!.map((x) => x)),
    "brandLogo": brandLogo,
    "image": image,
    "availabilities": availabilities == null
        ? []
        : List<dynamic>.from(availabilities!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "user": user,
  };
// ============================================

  // Helper method to parse chargePerHour from different formats
  static num? _parseChargePerHour(dynamic value) {
    if (value == null) return null;
    
    // If it's already a number, return it
    if (value is num) return value;
    
    // If it's a Map (object), try to extract the amount
    if (value is Map<String, dynamic>) {
      final amount = value['amount'];
      if (amount is num) return amount;
      if (amount is String) return num.tryParse(amount);
    }
    
    // If it's a string, try to parse it
    if (value is String) return num.tryParse(value);
    
    return null;
  }
}

class Availability {
  final String? dayName;
  final num? dayIndex;
  final String? startTime;
  final String? endTime;
  final num? appointmentLimit;
  final List<String>? slotsPerDay;
  final bool? isClosed;
  final String? id;

  Availability({
    this.dayName,
    this.dayIndex,
    this.startTime,
    this.endTime,
    this.appointmentLimit,
    this.slotsPerDay,
    this.isClosed,
    this.id,
  });

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    dayName: json["dayName"],
    dayIndex: _parseNum(json["dayIndex"]),
    startTime: json["startTime"],
    endTime: json["endTime"],
    appointmentLimit: _parseNum(json["appointmentLimit"]),
    slotsPerDay: json["slotsPerDay"] == null
        ? []
        : List<String>.from(json["slotsPerDay"]!.map((x) => x)),
    isClosed: json["isClosed"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "dayName": dayName,
    "dayIndex": dayIndex,
    "startTime": startTime,
    "endTime": endTime,
    "appointmentLimit": appointmentLimit,
    "slotsPerDay": slotsPerDay == null
        ? []
        : List<dynamic>.from(slotsPerDay!.map((x) => x)),
    "isClosed": isClosed,
    "_id": id,
  };

  // Helper method to parse numeric values safely
  static num? _parseNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
    return null;
  }
}

class Verification {
  final String? code;
  final DateTime? expireDate;

  Verification({
    this.code,
    this.expireDate,
  });

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
    code: json["code"],
    expireDate: json["expireDate"] == null
        ? null
        : DateTime.parse(json["expireDate"]),
  );

  // ========= MISSING METHOD ADDED BACK ========
  Map<String, dynamic> toJson() => {
    "code": code,
    "expireDate": expireDate?.toIso8601String(),
  };
// ============================================
}
