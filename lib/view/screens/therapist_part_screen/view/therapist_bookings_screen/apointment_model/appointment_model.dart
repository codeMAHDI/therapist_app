class PendingModelByTherapist {
  final DurationModel? duration;
  final FeeInfo? feeInfo;
  final String? id;
  final Patient? patient;
  final String? therapist;
  final DateTime? date;
  final String? slot;
  final String? reason;
  final String? description;
  final bool? isAvailableInWallet;
  final String? status;
  final String? cancelReason;
  final String? rescheduleReason;
  final String? appointmentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PendingModelByTherapist({
    this.duration,
    this.feeInfo,
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
    this.rescheduleReason,
    this.appointmentId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PendingModelByTherapist.fromJson(Map<String, dynamic> json) {
    return PendingModelByTherapist(
      duration: json["duration"] is Map<String, dynamic>
          ? DurationModel.fromJson(json["duration"])
          : null,
      feeInfo: json["feeInfo"] is Map<String, dynamic>
          ? FeeInfo.fromJson(json["feeInfo"])
          : null,
      id: json["_id"]?.toString(),
      patient: json["patient"] is Map<String, dynamic>
          ? Patient.fromJson(json["patient"])
          : null,
      therapist: json["therapist"]?.toString(),
      date: json["date"] != null ? DateTime.tryParse(json["date"]) : null,
      slot: json["slot"]?.toString(),
      reason: json["reason"]?.toString(),
      description: json["description"]?.toString(),
      isAvailableInWallet: json["isAvailableInWallet"] as bool?,
      status: json["status"]?.toString(),
      cancelReason: json["cancelReason"]?.toString(), // Fixed
      rescheduleReason: json["rescheduleReason"]?.toString(), // Fixed
      appointmentId: json["appointmentId"]?.toString(),
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"])
          : null,
      v: json["__v"] as int?,
    );
  }
}

class DurationModel {
  final int value;
  final String unit;

  DurationModel({required this.value, required this.unit});

  factory DurationModel.fromJson(Map<String, dynamic> json) {
    return DurationModel(
      value: json["value"] as int,
      unit: json["unit"] as String,
    );
  }
}

class FeeInfo {
  final Fee mainFee;
  final Fee bookedFee;
  final Fee holdFee;
  final Fee dueFee;
  final String patientTransactionId;
  final String feeStatus;

  FeeInfo({
    required this.mainFee,
    required this.bookedFee,
    required this.holdFee,
    required this.dueFee,
    required this.patientTransactionId,
    required this.feeStatus,
  });

  factory FeeInfo.fromJson(Map<String, dynamic> json) {
    return FeeInfo(
      mainFee: Fee.fromJson(json["mainFee"]),
      bookedFee: Fee.fromJson(json["bookedFee"]),
      holdFee: Fee.fromJson(json["holdFee"]),
      dueFee: Fee.fromJson(json["dueFee"]),
      patientTransactionId: json["patientTransactionId"] as String,
      feeStatus: json["feeStatus"] as String,
    );
  }
}

class Fee {
  final double amount;
  final String currency;

  Fee({required this.amount, required this.currency});

  factory Fee.fromJson(Map<String, dynamic> json) {
    return Fee(
      amount: (json["amount"] as num).toDouble(),
      currency: json["currency"] as String,
    );
  }
}

class Patient {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String role;
  final String status;
  final Profile profile;

  Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.role,
    required this.status,
    required this.profile,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json["_id"] as String,
      firstName: json["firstName"] as String,
      lastName: json["lastName"] as String,
      phone: json["phone"] as String,
      role: json["role"] as String,
      status: json["status"] as String,
      profile: Profile.fromJson(json["profile"]),
    );
  }
}

class Profile {
  final String id;
  final String dateOfBirth;
  final String gender;
  final String? image; // Fixed to nullable since it might not exist

  Profile({
    required this.id,
    required this.dateOfBirth,
    required this.gender,
    this.image,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json["_id"] as String,
      dateOfBirth: json["dateOfBirth"] as String,
      gender: json["gender"] as String,
      image: json["image"]?.toString(), // Fixed to prevent null type errors
    );
  }
}
