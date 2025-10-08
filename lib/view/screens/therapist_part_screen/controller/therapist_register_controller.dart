// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'dart:io';
import 'package:counta_flutter_app/service/api_check.dart';
import 'package:counta_flutter_app/utils/ToastMsg/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../service/api_client.dart';
import '../../../../service/api_url.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../user_part_screen/model/category_list_model.dart';
import '../model/therapist_register_model.dart';
import 'therapist_profile_controller.dart';

class TherapistRegisterController extends GetxController {
  final therapistProfileController = Get.find<TherapistProfileController>();

  //============= Edit Appointment=========\\
  RxBool editAppointmentLoading = false.obs;

  Future<void> editAppointment() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);
    editAppointmentLoading.value = true;
    refresh();

    Map<String, dynamic> updatedData = {
      "chargePerHour":
      double.tryParse(therapistAppointmentFee.text) ?? 0.0, // CORRECTED: .value removed
      "role": "therapist",
    };

    final apiUrl = ApiUrl.updateTherapistProfile(userId: userId);
    debugPrint("️API URL: $apiUrl");
    debugPrint("API Body: ${jsonEncode(updatedData)}");

    try {
      var response = await ApiClient.patchData(apiUrl, jsonEncode(updatedData));

      if (response.statusCode == 200 || response.statusCode == 201) {
        await getTherapistRegister();
        Get.back();
        showCustomSnackBar("Appointment fee updated successfully.",
            isError: false);
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      debugPrint("Appointment Update Error: $e");
      showCustomSnackBar("An unexpected error occurred.", isError: true);
    } finally {
      editAppointmentLoading.value = false;
    }
  }

  ///====================== User Profile ======================
  Rx<File?> therapistProfileRegesterImage = Rx<File?>(null);
  Rx<String> imagePath = Rx<String>("");

  Future<void> getFileImage() async {
    debugPrint("=============================> image Click");
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      debugPrint("=============================> image path ${image.path}");
      therapistProfileRegesterImage.value = File(image.path);
      imagePath.value = image.path;
      update();
    }
  }

  Rx<File?> therapistProfileImageFile = Rx<File?>(null);

  Future<void> getProfileFileImage() async {
    debugPrint("=============================> image Click");
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      debugPrint("=============================> image path ${image.path}");
      therapistProfileImageFile.value = File(image.path);
      update();
    }
  }

  ///========================= Image Picker User & Therapist ===========================
  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  //================ THERAPIST METHOD (TextEditingControllers) ===========//
  // CORRECTED: .obs wrapper removed from all TextEditingControllers
  final therapistFirstName = TextEditingController();
  final therapistLastName = TextEditingController();
  final therapistPhoneNumber = TextEditingController();
  final therapistEmail = TextEditingController();

  //=======Step - 1 =====//
  final therapistSpecialization = TextEditingController();
  final therapistSpecializationID = TextEditingController();
  final therapistSubSpecialization = TextEditingController();
  final therapistProSummery = TextEditingController();

  //=======Step - 2 =====//
  final therapistExperience = TextEditingController();
  final therapistAppointmentFee = TextEditingController();

  //=======Step - 3 (Other observables) =====//
  RxString therapistCV = "".obs;
  RxList<String> therapistCertificate = <String>[].obs;
  RxString therapistProfileImage = "".obs;
  RxString therapistBrandLogo = "".obs;
  RxList<String> therapistAvailabilityTime = <String>[].obs;

  String get specializationName {
    final String specId = therapistSpecializationID.text; // CORRECTED: .value removed
    if (specId.isEmpty) return "Not Set";

    try {
      final category = therapistProfileController.categoryList.firstWhere((cat) => cat.id == specId);
      return category.name ?? "Unknown";
    } catch (e) {
      return specId;
    }
  }

  bool _isEditScreenInitialized = false;

  void initializeForEdit(TherapistRegisterModel model, List<CategoryListModel> categoryList) {
    if (!_isEditScreenInitialized) {
      final String specialityIdFromModel = model.profile?.speciality ?? '';
      String initialSpecialityName = 'Not Set';

      if (categoryList.isNotEmpty && specialityIdFromModel.isNotEmpty) {
        try {
          final initialCategory = categoryList.firstWhere((category) => category.id == specialityIdFromModel);
          initialSpecialityName = initialCategory.name ?? 'Not Set';
        } catch (e) {
          initialSpecialityName = 'Not Found';
          debugPrint("Error finding initial category: $e");
        }
      }

      // CORRECTED: .value removed from all controller assignments
      therapistSpecialization.text = initialSpecialityName;
      therapistSpecializationID.text = specialityIdFromModel;
      therapistSubSpecialization.text = model.profile?.subSpecialty ?? '';
      therapistProSummery.text = model.profile?.professionalSummary ?? '';
      _isEditScreenInitialized = true;
    }
  }

  void resetEditScreenFlags() {
    _isEditScreenInitialized = false;
  }

  ///========== THERAPIST PROFILE GET API ===========
  final therapistLoading = Status.loading.obs;
  void setSetRegisterStatus(Status status) => therapistLoading.value = status;
  Rx<TherapistRegisterModel> therapistRegisterModel = TherapistRegisterModel().obs;

  Future<void> getTherapistRegister() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);
    setSetRegisterStatus(Status.loading);

    try {
      var response = await ApiClient.getData(ApiUrl.getTherapistRegister(userId: userId));

      if (response.statusCode == 200) {
        try {
          var data = response.body['data'];
          therapistRegisterModel.value = TherapistRegisterModel.fromJson(data);

          // --- Populate Basic Info --- (CORRECTED: .value removed)
          therapistFirstName.text = therapistRegisterModel.value.firstName ?? "";
          therapistLastName.text = therapistRegisterModel.value.lastName ?? "";
          therapistPhoneNumber.text = therapistRegisterModel.value.phone ?? "";
          therapistEmail.text = therapistRegisterModel.value.email ?? "";

          // --- Populate Profile Details --- (CORRECTED: .value removed)
          therapistSpecializationID.text = therapistRegisterModel.value.profile?.speciality ?? "";
          therapistSpecialization.text = ""; // This is derived from the getter
          therapistSubSpecialization.text = therapistRegisterModel.value.profile?.subSpecialty ?? "";
          therapistProSummery.text = therapistRegisterModel.value.profile?.professionalSummary ?? "";
          therapistExperience.text = therapistRegisterModel.value.profile?.experience ?? "";
          therapistAppointmentFee.text = therapistRegisterModel.value.profile?.chargePerHour?.toString() ?? "";

          // --- Populate File/Link URLs ---
          therapistCV.value = therapistRegisterModel.value.profile?.curriculumVitae ?? "";
          therapistBrandLogo.value = therapistRegisterModel.value.profile?.brandLogo ?? "";
          therapistProfileImage.value = therapistRegisterModel.value.profile?.image ?? "";

          // --- Populate Lists ---
          if (therapistRegisterModel.value.profile?.certificates != null) {
            therapistCertificate.value = List<String>.from(therapistRegisterModel.value.profile!.certificates!);
          }
          if (therapistRegisterModel.value.profile?.availabilities != null) {
            therapistAvailabilityTime.value = therapistRegisterModel.value.profile?.availabilities
                ?.map((x) => "${x.dayName} (${x.startTime} - ${x.endTime})")
                .toList() ?? [];
          }

          setSetRegisterStatus(Status.completed);
          update();
        } catch (e) {
          setSetRegisterStatus(Status.error);
          debugPrint("⛔ Parsing error in getTherapistRegister: $e");
          showCustomSnackBar("Failed to parse profile data.", isError: true);
        }
      } else {
        setSetRegisterStatus(Status.error);
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      setSetRegisterStatus(Status.error);
      debugPrint("⛔ Exception in getTherapistRegister: $e");
      showCustomSnackBar("An unexpected error occurred. Please check your connection.", isError: true);
    }
  }

  ///========== THERAPIST PROFILE UPDATE API ===========
  RxBool therapistProfileUpdateLoading = false.obs;

  Future<void> updateTherapistProfile() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);
    therapistProfileUpdateLoading.value = true;
    refresh();
    Map<String, String> updatedData = {
      "firstName": therapistFirstName.text, // CORRECTED
      "lastName": therapistLastName.text, // CORRECTED
      "phone": therapistPhoneNumber.text, // CORRECTED
      "role": "therapist",
    };
    final apiUrl = ApiUrl.updateTherapistProfile(userId: userId);

    var response = therapistProfileImageFile.value != null
        ? await ApiClient.patchMultipartData(
      apiUrl,
      updatedData,
      multipartBody: [MultipartBody('image', therapistProfileImageFile.value!)],
    )
        : await ApiClient.patchData(apiUrl, jsonEncode(updatedData));

    therapistProfileUpdateLoading(false);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      Get.snackbar("Success", "Profile updated successfully.");
    } else {
      ApiChecker.checkApi(response);
    }
  }

  //============= Edit Specialization=========\\
  RxBool editSpecializationLoading = false.obs;

  Future<void> editSpecialization() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);
    editSpecializationLoading.value = true;
    refresh();
    Map<String, dynamic> updatedData = {
      "speciality": therapistSpecializationID.text, // CORRECTED
      "subSpecialty": therapistSubSpecialization.text, // CORRECTED
      "professionalSummary": therapistProSummery.text, // CORRECTED
      "role": "therapist",
    };
    final apiUrl = ApiUrl.updateTherapistProfile(userId: userId);
    debugPrint("➡️ API URL: $apiUrl");

    try {
      var response = await ApiClient.patchData(apiUrl, jsonEncode(updatedData));
      editSpecializationLoading(false);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await getTherapistRegister();
        Get.back();
        Get.snackbar("Success", "Specialization updated successfully.");
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      editSpecializationLoading(false);
      Get.snackbar("Error", "Specialization Update Error");
    }
  }

  //============= Edit Experience=========\\
  RxBool editExperienceLoading = false.obs;

  Future<void> editExperience() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);
    editExperienceLoading.value = true;
    refresh();
    Map<String, dynamic> updatedData = {
      "experience": therapistExperience.text, // CORRECTED
      "role": "therapist",
    };
    final apiUrl = ApiUrl.updateTherapistProfile(userId: userId);
    debugPrint("➡️ API URL: $apiUrl");
    try {
      var response = await ApiClient.patchData(apiUrl, jsonEncode(updatedData));
      if (response.statusCode == 200 || response.statusCode == 201) {
        await getTherapistRegister();
        Get.back();
        Get.snackbar("Success", "experience updated successfully.");
      } else {
        debugPrint("Experience Update Error: ${response.body}");
        Get.snackbar("Error", "experience Update Error");
      }
    } catch (e) {
      debugPrint("API Error: $e");
      Get.snackbar("Error", "experience Update Error");
    }
    editExperienceLoading.value = false;
    refresh();
  }

  //================================= Edit Availability ================\\

  //======= AVAILABILITY OBSERVABLES =======
  RxString sunStartTime = "09:00 AM".obs;
  RxString sunEndTime = "09:00 PM".obs;
  RxBool sunDayClose = true.obs; // Default to closed
  final sunDayAppointment = TextEditingController();

  RxString monStartTime = "09:00 AM".obs;
  RxString monEndTime = "09:00 PM".obs;
  RxBool monDayClose = true.obs;
  final monDayAppointment = TextEditingController();

  RxString tueStartTime = "09:00 AM".obs;
  RxString tueEndTime = "09:00 PM".obs;
  RxBool tueDayClose = true.obs;
  final tueDayAppointment = TextEditingController();

  RxString wedStartTime = "09:00 AM".obs;
  RxString wedEndTime = "09:00 PM".obs;
  RxBool wedDayClose = true.obs;
  final wedDayAppointment = TextEditingController();

  RxString thuStartTime = "09:00 AM".obs;
  RxString thuEndTime = "09:00 PM".obs;
  RxBool thuDayClose = true.obs;
  final thuDayAppointment = TextEditingController();

  RxString friStartTime = "09:00 AM".obs;
  RxString friEndTime = "09:00 PM".obs;
  RxBool friDayClose = true.obs;
  final friDayAppointment = TextEditingController();

  RxString satStartTime = "09:00 AM".obs;
  RxString satEndTime = "09:00 PM".obs;
  RxBool satDayClose = true.obs;
  final satDayAppointment = TextEditingController();


  void initializeAvailabilities() {
    // Reset all text controllers
    sunDayAppointment.text = "";
    monDayAppointment.text = "";
    tueDayAppointment.text = "";
    wedDayAppointment.text = "";
    thuDayAppointment.text = "";
    friDayAppointment.text = "";
    satDayAppointment.text = "";

    if (Get.arguments != null && Get.arguments is TherapistRegisterModel) {
      final TherapistRegisterModel model = Get.arguments;
      final availabilities = model.profile?.availabilities ?? [];

      if (availabilities.isEmpty) {
        debugPrint("No availabilities found in the passed model.");
        return;
      }

      Availability? findDay(int dayIndex) {
        try {
          return availabilities.firstWhere((a) => a.dayIndex == dayIndex);
        } catch (e) {
          return null;
        }
      }

      // Update Sunday
      final sunData = findDay(0);
      sunDayClose.value = sunData?.isClosed ?? true;
      if (!sunDayClose.value) {
        sunStartTime.value = sunData?.startTime ?? "09:00 AM";
        sunEndTime.value = sunData?.endTime ?? "05:00 PM";
        sunDayAppointment.text = (sunData?.appointmentLimit ?? 1).toString();
      }

      // Update Monday
      final monData = findDay(1);
      monDayClose.value = monData?.isClosed ?? true;
      if (!monDayClose.value) {
        monStartTime.value = monData?.startTime ?? "09:00 AM";
        monEndTime.value = monData?.endTime ?? "05:00 PM";
        monDayAppointment.text = (monData?.appointmentLimit ?? 1).toString();
      }

      // Update Tuesday
      final tueData = findDay(2);
      tueDayClose.value = tueData?.isClosed ?? true;
      if (!tueDayClose.value) {
        tueStartTime.value = tueData?.startTime ?? "09:00 AM";
        tueEndTime.value = tueData?.endTime ?? "05:00 PM";
        tueDayAppointment.text = (tueData?.appointmentLimit ?? 1).toString();
      }

      // Update Wednesday
      final wedData = findDay(3);
      wedDayClose.value = wedData?.isClosed ?? true;
      if (!wedDayClose.value) {
        wedStartTime.value = wedData?.startTime ?? "09:00 AM";
        wedEndTime.value = wedData?.endTime ?? "05:00 PM";
        wedDayAppointment.text = (wedData?.appointmentLimit ?? 1).toString();
      }

      // Update Thursday
      final thuData = findDay(4);
      thuDayClose.value = thuData?.isClosed ?? true;
      if (!thuDayClose.value) {
        thuStartTime.value = thuData?.startTime ?? "09:00 AM";
        thuEndTime.value = thuData?.endTime ?? "05:00 PM";
        thuDayAppointment.text = (thuData?.appointmentLimit ?? 1).toString();
      }

      // Update Friday
      final friData = findDay(5);
      friDayClose.value = friData?.isClosed ?? true;
      if (!friDayClose.value) {
        friStartTime.value = friData?.startTime ?? "09:00 AM";
        friEndTime.value = friData?.endTime ?? "05:00 PM";
        friDayAppointment.text = (friData?.appointmentLimit ?? 1).toString();
      }

      // Update Saturday
      final satData = findDay(6);
      satDayClose.value = satData?.isClosed ?? true;
      if (!satDayClose.value) {
        satStartTime.value = satData?.startTime ?? "09:00 AM";
        satEndTime.value = satData?.endTime ?? "05:00 PM";
        satDayAppointment.text = (satData?.appointmentLimit ?? 1).toString();
      }
    } else {
      debugPrint("Arguments are null or not a TherapistRegisterModel.");
    }
  }

  List<Map<String, dynamic>> getAvailabilityForSubmission() {
    List<Map<String, dynamic>> availabilityData = [];

    int parseAppointmentLimit(TextEditingController controller) {
      return int.tryParse(controller.text) ?? 1;
    }

    // Process Sunday (Day Index 0)
    if (!sunDayClose.value) {
      availabilityData.add({
        "dayName": "Sunday", "dayIndex": 0, "startTime": sunStartTime.value, "endTime": sunEndTime.value,
        "appointmentLimit": parseAppointmentLimit(sunDayAppointment), // CORRECTED
        "isClosed": false,
      });
    } else { availabilityData.add({"dayName": "Sunday", "dayIndex": 0, "isClosed": true}); }

    // Process Monday (Day Index 1)
    if (!monDayClose.value) {
      availabilityData.add({
        "dayName": "Monday", "dayIndex": 1, "startTime": monStartTime.value, "endTime": monEndTime.value,
        "appointmentLimit": parseAppointmentLimit(monDayAppointment), // CORRECTED
        "isClosed": false,
      });
    } else { availabilityData.add({"dayName": "Monday", "dayIndex": 1, "isClosed": true}); }

    // Process Tuesday (Day Index 2)
    if (!tueDayClose.value) {
      availabilityData.add({
        "dayName": "Tuesday", "dayIndex": 2, "startTime": tueStartTime.value, "endTime": tueEndTime.value,
        "appointmentLimit": parseAppointmentLimit(tueDayAppointment), // CORRECTED
        "isClosed": false,
      });
    } else { availabilityData.add({"dayName": "Tuesday", "dayIndex": 2, "isClosed": true}); }

    // Process Wednesday (Day Index 3)
    if (!wedDayClose.value) {
      availabilityData.add({
        "dayName": "Wednesday", "dayIndex": 3, "startTime": wedStartTime.value, "endTime": wedEndTime.value,
        "appointmentLimit": parseAppointmentLimit(wedDayAppointment), // CORRECTED
        "isClosed": false,
      });
    } else { availabilityData.add({"dayName": "Wednesday", "dayIndex": 3, "isClosed": true}); }

    // Process Thursday (Day Index 4)
    if (!thuDayClose.value) {
      availabilityData.add({
        "dayName": "Thursday", "dayIndex": 4, "startTime": thuStartTime.value, "endTime": thuEndTime.value,
        "appointmentLimit": parseAppointmentLimit(thuDayAppointment), // CORRECTED
        "isClosed": false,
      });
    } else { availabilityData.add({"dayName": "Thursday", "dayIndex": 4, "isClosed": true}); }

    // Process Friday (Day Index 5)
    if (!friDayClose.value) {
      availabilityData.add({
        "dayName": "Friday", "dayIndex": 5, "startTime": friStartTime.value, "endTime": friEndTime.value,
        "appointmentLimit": parseAppointmentLimit(friDayAppointment), // CORRECTED
        "isClosed": false,
      });
    } else { availabilityData.add({"dayName": "Friday", "dayIndex": 5, "isClosed": true}); }

    // Process Saturday (Day Index 6)
    if (!satDayClose.value) {
      availabilityData.add({
        "dayName": "Saturday", "dayIndex": 6, "startTime": satStartTime.value, "endTime": satEndTime.value,
        "appointmentLimit": parseAppointmentLimit(satDayAppointment), // CORRECTED
        "isClosed": false,
      });
    } else { availabilityData.add({"dayName": "Saturday", "dayIndex": 6, "isClosed": true}); }

    return availabilityData;
  }

  RxBool isSubmitAvailability = false.obs;

  Future<void> submitAvailability() async {
    isSubmitAvailability(true);
    List<Map<String, dynamic>> availabilityData = getAvailabilityForSubmission();

    if (availabilityData.isEmpty) {
      showCustomSnackBar("Please set at least one day's availability");
      isSubmitAvailability(false);
      return;
    }

    final userID = await SharePrefsHelper.getString(AppConstants.userId);
    Map<String, dynamic> body = {
      "availabilities": availabilityData,
      "role": "therapist",
    };

    var response = await ApiClient.patchData(
        ApiUrl.updateTherapistProfile(userId: userID), jsonEncode(body));
    isSubmitAvailability(false);

    if (response.statusCode == 200 || response.statusCode == 201) {
      await getTherapistRegister();
      Get.back();
      Get.snackbar("Success", "Availability updated successfully.");
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> timeSet(BuildContext context, {required int dayIndex, required bool isStartTimeFlag}) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      String formattedTime = formatTime(pickedTime);
      switch (dayIndex) {
        case 0: isStartTimeFlag ? sunStartTime.value = formattedTime : sunEndTime.value = formattedTime; break;
        case 1: isStartTimeFlag ? monStartTime.value = formattedTime : monEndTime.value = formattedTime; break;
        case 2: isStartTimeFlag ? tueStartTime.value = formattedTime : tueEndTime.value = formattedTime; break;
        case 3: isStartTimeFlag ? wedStartTime.value = formattedTime : wedEndTime.value = formattedTime; break;
        case 4: isStartTimeFlag ? thuStartTime.value = formattedTime : thuEndTime.value = formattedTime; break;
        case 5: isStartTimeFlag ? friStartTime.value = formattedTime : friEndTime.value = formattedTime; break;
        case 6: isStartTimeFlag ? satStartTime.value = formattedTime : satEndTime.value = formattedTime; break;
      }
      refresh();
    }
  }

  String formatTime(TimeOfDay timeOfDay) {
    final now = DateTime(0, 0, 0, timeOfDay.hour, timeOfDay.minute);
    final format = DateFormat.jm();
    return format.format(now);
  }

  @override
  void onInit() {
    super.onInit();
    getTherapistRegister();
  }
}


