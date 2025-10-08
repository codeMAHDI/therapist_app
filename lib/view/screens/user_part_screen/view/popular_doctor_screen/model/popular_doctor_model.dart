import 'dart:convert';

PopularDoctorsModel popularDoctorsModelFromJson(String str) =>
    PopularDoctorsModel.fromJson(json.decode(str));

String popularDoctorsModelToJson(PopularDoctorsModel data) =>
    json.encode(data.toJson());

class PopularDoctorsModel {
  final String? id;
  final Therapist? therapist;
  final int? consumeCount;
  final bool? isPremium;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PopularDoctorsModel({
    this.id,
    this.therapist,
    this.consumeCount,
    this.isPremium,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PopularDoctorsModel.fromJson(Map<String, dynamic> json) =>
      PopularDoctorsModel(
        id: json["_id"],
        therapist: json["therapist"] == null
            ? null
            : Therapist.fromJson(json["therapist"]),
        consumeCount: json["consumeCount"],
        isPremium: json["isPremium"],
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
        "therapist": therapist?.toJson(),
        "consumeCount": consumeCount,
        "isPremium": isPremium,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Therapist {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? role;
  final String? status;
  final Profile? profile;
  final int? v;

  Therapist({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.status,
    this.profile,
    this.v,
  });

  factory Therapist.fromJson(Map<String, dynamic> json) => Therapist(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        status: json["status"],
        profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "role": role,
        "status": status,
        "profile": profile?.toJson(),
        "__v": v,
      };
}

class Profile {
  final ChargePerHour? chargePerHour;
  final String? id;
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
  final int? v;
  final String? user;
  final dynamic speciality; // Can be a String or a Speciality object

  Profile({
    this.chargePerHour,
    this.id,
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
    this.speciality,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        chargePerHour: json["chargePerHour"] == null
            ? null
            : json["chargePerHour"] is Map<String, dynamic>
                ? ChargePerHour.fromJson(json["chargePerHour"])
                : ChargePerHour(amount: json["chargePerHour"], currency: "USD"),
        id: json["_id"],
        subSpecialty: json["subSpecialty"],
        professionalSummary: json["professionalSummary"],
        experience: json["experience"],
        curriculumVitae: json["curriculumVitae"],
        certificates: json["certificates"] == null
            ? []
            : json["certificates"] is List
                ? List<String>.from(json["certificates"].map((x) => x.toString()))
                : [],
        brandLogo: json["brandLogo"],
        image: json["image"],
        availabilities: json["availabilities"] == null
            ? []
            : json["availabilities"] is List
                ? List<Availability>.from(
                    json["availabilities"].map((x) => Availability.fromJson(x)))
                : [],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        user: json["user"],
        speciality: json["speciality"] is String
            ? json["speciality"]
            : json["speciality"] == null
                ? null
                : Speciality.fromJson(json["speciality"]),
      );

  Map<String, dynamic> toJson() => {
        "chargePerHour": chargePerHour?.toJson(),
        "_id": id,
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
        "speciality":
            speciality is Speciality ? (speciality as Speciality).toJson() : speciality,
      };
}

class Availability {
  final String? dayName;
  final int? dayIndex;
  final String? startTime;
  final String? endTime;
  final int? appointmentLimit;
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
        dayIndex: json["dayIndex"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        appointmentLimit: json["appointmentLimit"],
        slotsPerDay: json["slotsPerDay"] == null
            ? []
            : List<String>.from(json["slotsPerDay"].map((x) => x)),
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
}

class ChargePerHour {
  final int? amount;
  final String? currency;

  ChargePerHour({this.amount, this.currency});

  factory ChargePerHour.fromJson(Map<String, dynamic> json) => ChargePerHour(
        amount: json["amount"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency": currency,
      };
}

class Speciality {
  final String? id;
  final String? name;
  final String? image;

  Speciality({this.id, this.name, this.image});

  factory Speciality.fromJson(Map<String, dynamic> json) => Speciality(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
      };
}
