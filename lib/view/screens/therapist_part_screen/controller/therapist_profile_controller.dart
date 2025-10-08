import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/screens/authentication/controller/auth_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../service/api_check.dart';
import '../../../../service/api_client.dart';
import 'package:intl/intl.dart';
import '../../../../service/api_url.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../user_part_screen/model/category_list_model.dart';

class TherapistProfileController extends GetxController {
  // ... (all the properties and methods before submitAvailability are unchanged) ...
  var therapistFirstNameController = TextEditingController().obs;
  var therapistLastNameController = TextEditingController().obs;
  Rx<TextEditingController> therapistEmailController =
      TextEditingController().obs;
  var therapistPhoneController = TextEditingController().obs;
  var therapistPasswordController = TextEditingController().obs;
  var therapistConfirmPasswordController = TextEditingController().obs;

  var therapistSpecializationController = TextEditingController().obs;
  var therapistSpecializationController2 = TextEditingController().obs;
  var therapistSubSpecializationController = TextEditingController().obs;
  var therapistProSummeryController = TextEditingController().obs;

  final RxString _selectedSpecializationId = "".obs;

  String get selectedSpecializationId => _selectedSpecializationId.value;

  set selectedSpecializationId(String value) =>
      _selectedSpecializationId.value = value;

  var therapistExperienceController = TextEditingController().obs;

  var therapistAppointmentFeeController = TextEditingController().obs;

  final RxMap<String, TimeOfDay> startTime = <String, TimeOfDay>{}.obs;
  final RxMap<String, TimeOfDay> endTime = <String, TimeOfDay>{}.obs;
  final RxMap<String, bool> isEnabled = <String, bool>{}.obs;
  final RxBool isLoading = false.obs;

  void initializeAvailability() {
    const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    for (var day in days) {
      startTime[day] = TimeOfDay(hour: 9, minute: 0);
      endTime[day] = TimeOfDay(hour: 17, minute: 0);
      isEnabled[day] = false;
    }
  }

  String getDayName(int index) {
    const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return days[index];
  }

  RxString sunStartTime = "09:00 AM".obs;
  RxString sunEndTime = "09:00 PM".obs;
  RxBool sunDayClose = false.obs;
  Rx<TextEditingController> sunDayAppointment = TextEditingController().obs;

  RxString monStartTime = "09:00 AM".obs;
  RxString monEndTime = "09:00 PM".obs;
  RxBool monDayClose = false.obs;
  Rx<TextEditingController> monDayAppointment = TextEditingController().obs;

  RxString tueStartTime = "09:00 AM".obs;
  RxString tueEndTime = "09:00 PM".obs;
  RxBool tueDayClose = false.obs;
  Rx<TextEditingController> tueDayAppointment = TextEditingController().obs;

  RxString wedStartTime = "09:00 AM".obs;
  RxString wedEndTime = "09:00 PM".obs;
  RxBool wedDayClose = false.obs;
  Rx<TextEditingController> wedDayAppointment = TextEditingController().obs;

  RxString thuStartTime = "09:00 AM".obs;
  RxString thuEndTime = "09:00 PM".obs;
  RxBool thuDayClose = false.obs;
  Rx<TextEditingController> thuDayAppointment = TextEditingController().obs;

  RxString friStartTime = "09:00 AM".obs;
  RxString friEndTime = "09:00 PM".obs;
  RxBool friDayClose = false.obs;
  Rx<TextEditingController> friDayAppointment = TextEditingController().obs;

  RxString satStartTime = "09:00 AM".obs;
  RxString satEndTime = "09:00 PM".obs;
  RxBool satDayClose = false.obs;
  Rx<TextEditingController> satDayAppointment = TextEditingController().obs;

  Future<void> timeSet(BuildContext context,
      {required int dayIndex, required bool isStartTimeFlag}) async {
    TimeOfDay initialUserTime;
    String currentTimeString;

    switch (dayIndex) {
      case 0:
        currentTimeString =
            isStartTimeFlag ? sunStartTime.value : sunEndTime.value;
        break;
      case 1:
        currentTimeString =
            isStartTimeFlag ? monStartTime.value : monEndTime.value;
        break;
      case 2:
        currentTimeString =
            isStartTimeFlag ? tueStartTime.value : tueEndTime.value;
        break;
      case 3:
        currentTimeString =
            isStartTimeFlag ? wedStartTime.value : wedEndTime.value;
        break;
      case 4:
        currentTimeString =
            isStartTimeFlag ? thuStartTime.value : thuEndTime.value;
        break;
      case 5:
        currentTimeString =
            isStartTimeFlag ? friStartTime.value : friEndTime.value;
        break;
      case 6:
        currentTimeString =
            isStartTimeFlag ? satStartTime.value : satEndTime.value;
        break;
      default:
        currentTimeString = "09:00 AM";
    }

    try {
      final format = DateFormat.jm();
      DateTime parsedDateTime = format.parse(currentTimeString);
      initialUserTime = TimeOfDay.fromDateTime(parsedDateTime);
    } catch (e) {
      debugPrint(
          "Error parsing initial time '$currentTimeString' for time picker: $e. Using current time as fallback.");
      initialUserTime = TimeOfDay.now();
    }

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialUserTime,
    );

    if (pickedTime != null) {
      String formattedTime = formatTime(pickedTime);
      switch (dayIndex) {
        case 0:
          if (isStartTimeFlag)
            sunStartTime.value = formattedTime;
          else
            sunEndTime.value = formattedTime;
          break;
        case 1:
          if (isStartTimeFlag)
            monStartTime.value = formattedTime;
          else
            monEndTime.value = formattedTime;
          break;
        case 2:
          if (isStartTimeFlag)
            tueStartTime.value = formattedTime;
          else
            tueEndTime.value = formattedTime;
          break;
        case 3:
          if (isStartTimeFlag)
            wedStartTime.value = formattedTime;
          else
            wedEndTime.value = formattedTime;
          break;
        case 4:
          if (isStartTimeFlag)
            thuStartTime.value = formattedTime;
          else
            thuEndTime.value = formattedTime;
          break;
        case 5:
          if (isStartTimeFlag)
            friStartTime.value = formattedTime;
          else
            friEndTime.value = formattedTime;
          break;
        case 6:
          if (isStartTimeFlag)
            satStartTime.value = formattedTime;
          else
            satEndTime.value = formattedTime;
          break;
      }
      refresh();
    }
  }

  String formatTime(TimeOfDay timeOfDay) {
    final now = DateTime(0, 0, 0, timeOfDay.hour, timeOfDay.minute);
    final format = DateFormat.jm();
    return format.format(now);
  }

  var cvFile = Rx<File?>(null);

  Future<void> pickCvFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pickedFile != null && pickedFile.files.single.path != null) {
      cvFile.value = File(pickedFile.files.single.path!);
    }
  }

  var certificateFile = Rx<File?>(null);

  Future<void> pickCertificateFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pickedFile != null && pickedFile.files.single.path != null) {
      certificateFile.value = File(pickedFile.files.single.path!);
    }
  }

  var brandLogoFile = Rx<File?>(null);

  Future<void> brandLogo() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      brandLogoFile.value = File(pickedFile.path);
    }
  }

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

  ///======================== SUBMIT/UPDATE AVAILABILITY ===========================
  RxBool isSubmitAvailabilityLoading = false.obs;

  Future<void> submitAvailability() async {
    isSubmitAvailabilityLoading.value = true;

    List<Map<String, dynamic>> getAvailabilityForSubmission() {
      List<Map<String, dynamic>> availabilityData = [];
      void addDayIfEnabled(
          String dayName,
          int dayIndex,
          bool isDayEffectivelyOpen,
          String startTime,
          String endTime,
          String appointmentLimitText) {
        if (isDayEffectivelyOpen) {
          int? limit = int.tryParse(appointmentLimitText);
          if (limit != null && limit > 0) {
            availabilityData.add({
              "dayName": dayName,
              "dayIndex": dayIndex,
              "startTime": startTime,
              "endTime": endTime,
              "appointmentLimit": limit,
              "isClosed": false,
            });
          }
        }
      }

      addDayIfEnabled("Sunday", 0, !sunDayClose.value, sunStartTime.value,
          sunEndTime.value, sunDayAppointment.value.text);
      addDayIfEnabled("Monday", 1, !monDayClose.value, monStartTime.value,
          monEndTime.value, monDayAppointment.value.text);
      addDayIfEnabled("Tuesday", 2, !tueDayClose.value, tueStartTime.value,
          tueEndTime.value, tueDayAppointment.value.text);
      addDayIfEnabled("Wednesday", 3, !wedDayClose.value, wedStartTime.value,
          wedEndTime.value, wedDayAppointment.value.text);
      addDayIfEnabled("Thursday", 4, !thuDayClose.value, thuStartTime.value,
          thuEndTime.value, thuDayAppointment.value.text);
      addDayIfEnabled("Friday", 5, !friDayClose.value, friStartTime.value,
          friEndTime.value, friDayAppointment.value.text);
      addDayIfEnabled("Saturday", 6, !satDayClose.value, satStartTime.value,
          satEndTime.value, satDayAppointment.value.text);
      return availabilityData;
    }

    List<Map<String, dynamic>> availabilityPayload =
        getAvailabilityForSubmission();

    if (availabilityPayload.isEmpty) {
      Get.snackbar("Error",
          "Please open at least one day and set a valid appointment limit.");
      isSubmitAvailabilityLoading.value = false;
      return;
    }

    final userId = await SharePrefsHelper.getString(AppConstants.userId);
    // ============================ THE FIX ============================
    // Changed AppConstants.token to AppConstants.bearerToken, which is the more likely constant name.
    // If your constant is named something else, please change it here.
    final token = await SharePrefsHelper.getString(AppConstants.bearerToken);
    // ===============================================================

    if (userId.isEmpty || token.isEmpty) {
      Get.snackbar(
          "Error", "Could not find user credentials. Please log in again.");
      isSubmitAvailabilityLoading.value = false;
      return;
    }

    final uri = Uri.parse(
        ApiUrl.baseUrl + ApiUrl.updateTherapistProfile(userId: userId));

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Map<String, dynamic> body = {
      "availabilities": jsonEncode(availabilityPayload),
      "role": "therapist",
    };

    final String encodedBody = jsonEncode(body);

    debugPrint("Submitting Availability Data");
    debugPrint("URL: $uri");
    debugPrint("Headers: $headers");
    debugPrint("Encoded Body: $encodedBody");

    try {
      http.Response response = await http.patch(
        uri,
        headers: headers,
        body: encodedBody,
      );

      isSubmitAvailabilityLoading.value = false;

      // 6. Process the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        Get.snackbar("Success", "Availability updated successfully.");
      } else {
        debugPrint("API Error: ${response.statusCode}");
        debugPrint("API Response: ${response.body}");
        try {
          final responseBody = jsonDecode(response.body);
          final errorMessage =
              responseBody['error'] ?? "An unknown error occurred.";
          Get.snackbar("Update Failed", errorMessage);
        } catch (e) {
          Get.snackbar("Update Failed",
              "An unknown error occurred while parsing the server response.");
        }
      }
    } catch (e) {
      isSubmitAvailabilityLoading.value = false;
      debugPrint("Error updating availability: $e");
      Get.snackbar("Error", "An error occurred while updating availability.");
    }
  }

  RxBool therapistRegisterLoading = false.obs;

  Future<void> therapistRegister() async {
    therapistRegisterLoading.value = true;
    Map<String, String> body = {
      "firstName": therapistFirstNameController.value.text,
      "lastName": therapistLastNameController.value.text,
      "email": therapistEmailController.value.text,
      "phone": therapistPhoneController.value.text,
      "password": therapistPasswordController.value.text,
      "speciality": therapistSpecializationController2.value.text,
      "subSpecialty": therapistSubSpecializationController.value.text,
      "professionalSummary": therapistProSummeryController.value.text,
      "experience": therapistExperienceController.value.text,
      "image": selectedImage.value?.path ?? '',
      "curriculumVitae": cvFile.value?.path ?? '',
      "certificates": certificateFile.value?.path ?? '',
      "brandLogo": brandLogoFile.value?.path ?? '',
      "availabilities": jsonEncode([
        {
          "dayName": "Sunday",
          "dayIndex": 0,
          "startTime": sunStartTime.value,
          "endTime": sunEndTime.value,
          "appointmentLimit":
              _parseAppointmentLimit(sunDayAppointment.value.text),
          "isClosed": !sunDayClose.value
        },
        {
          "dayName": "Monday",
          "dayIndex": 1,
          "startTime": monStartTime.value,
          "endTime": monEndTime.value,
          "appointmentLimit":
              _parseAppointmentLimit(monDayAppointment.value.text),
          "isClosed": !monDayClose.value
        },
        {
          "dayName": "Tuesday",
          "dayIndex": 2,
          "startTime": tueStartTime.value,
          "endTime": tueEndTime.value,
          "appointmentLimit":
              _parseAppointmentLimit(tueDayAppointment.value.text),
          "isClosed": !tueDayClose.value
        },
        {
          "dayName": "Wednesday",
          "dayIndex": 3,
          "startTime": wedStartTime.value,
          "endTime": wedEndTime.value,
          "appointmentLimit":
              _parseAppointmentLimit(wedDayAppointment.value.text),
          "isClosed": !wedDayClose.value
        },
        {
          "dayName": "Thursday",
          "dayIndex": 4,
          "startTime": thuStartTime.value,
          "endTime": thuEndTime.value,
          "appointmentLimit":
              _parseAppointmentLimit(thuDayAppointment.value.text),
          "isClosed": !thuDayClose.value
        },
        {
          "dayName": "Friday",
          "dayIndex": 5,
          "startTime": friStartTime.value,
          "endTime": friEndTime.value,
          "appointmentLimit":
              _parseAppointmentLimit(friDayAppointment.value.text),
          "isClosed": !friDayClose.value
        },
        {
          "dayName": "Saturday",
          "dayIndex": 6,
          "startTime": satStartTime.value,
          "endTime": satEndTime.value,
          "appointmentLimit":
              _parseAppointmentLimit(satDayAppointment.value.text),
          "isClosed": !satDayClose.value
        }
      ]),
      "chargePerHour": jsonEncode({
        "amount":
            double.tryParse(therapistAppointmentFeeController.value.text) ??
                0.0,
        "currency": "USD"
      }),
      "role": "therapist",
    };

    try {
      if (selectedImage.value == null ||
          cvFile.value == null ||
          certificateFile.value == null ||
          brandLogoFile.value == null) {
        Get.snackbar("Error", "Please select all required images and files.");
        therapistRegisterLoading.value = false;
        return;
      }

      var response = await ApiClient.postMultipartData(
        ApiUrl.therapistRegister,
        body,
        multipartBody: [
          MultipartBody('image', selectedImage.value!),
          MultipartBody('curriculumVitae', cvFile.value!),
          MultipartBody('certificates', certificateFile.value!),
          MultipartBody('brandLogo', brandLogoFile.value!)
        ],
      );

      if (response.statusCode == 201) {
        therapistRegisterLoading.value = false;
        Get.toNamed(AppRoutes.verificationScreen,
            arguments: UserModel(
                therapistEmailController.value.text, AppStrings.register));
      } else {
        ApiChecker.checkApi(response);
        therapistRegisterLoading.value = false;
      }
    } catch (e) {
      therapistRegisterLoading.value = false;
      debugPrint("Error in therapistRegister: $e");
      Get.snackbar("Error", "Something went wrong!");
    }
  }

  int _parseAppointmentLimit(String text) {
    try {
      return int.parse(text);
    } catch (e) {
      debugPrint("Invalid appointment limit: $e");
      return 0;
    }
  }

  Rx<Status> categoryListLoader = Status.loading.obs;
  RxList<CategoryListModel> categoryList = <CategoryListModel>[].obs;
  RxList<String> catagoryName = <String>[].obs;

  Future<void> getCategoryList() async {
    debugPrint(
        '======= Fetching Categories from API: ${ApiUrl.getCategoryList}');
    try {
      var response = await ApiClient.getData(ApiUrl.getCategoryList);
      if (response.statusCode == 200) {
        categoryListLoader.value = Status.completed;
        var data = response.body['data'] ?? [];
        catagoryName.value = List<String>.from(
            response.body['data'].map((x) => x['name'].toString()));
        categoryList.value = data.map<CategoryListModel>((item) {
          debugPrint("Category Loaded: ${item['name']}");
          return CategoryListModel.fromJson(item);
        }).toList();
        refresh();
      } else {
        categoryListLoader.value = Status.error;
        ApiChecker.checkApi(response);
        refresh();
      }
    } catch (e) {
      categoryListLoader.value = Status.error;
      debugPrint('Error Fetching Categories: $e');
      refresh();
    }
  }

  Future<void> loadData() async {
    therapistFirstNameController.value.text =
        await SharePrefsHelper.getString("firstName");
    therapistLastNameController.value.text =
        await SharePrefsHelper.getString("lastName");
    therapistEmailController.value.text =
        await SharePrefsHelper.getString("email");
    therapistPhoneController.value.text =
        await SharePrefsHelper.getString("phone");
    therapistPasswordController.value.text =
        await SharePrefsHelper.getString("password");
    therapistConfirmPasswordController.value.text =
        await SharePrefsHelper.getString("confirmPassword");
    therapistSpecializationController.value.text =
        await SharePrefsHelper.getString("specialty");
    therapistSubSpecializationController.value.text =
        await SharePrefsHelper.getString("subSpecialization");
    therapistProSummeryController.value.text =
        await SharePrefsHelper.getString("proSummery");
    therapistExperienceController.value.text =
        await SharePrefsHelper.getString("experience");
    therapistAppointmentFeeController.value.text =
        await SharePrefsHelper.getString("appointmentFee");
  }

  void dataPassButton() async {
    var firstName = await SharePrefsHelper.getString("firstName");
    var lastName = await SharePrefsHelper.getString("lastName");
    var email = await SharePrefsHelper.getString("email");
    var phone = await SharePrefsHelper.getString("phone");
    var password = await SharePrefsHelper.getString("password");
    var confirmPassword = await SharePrefsHelper.getString("confirmPassword");
    var specialization = await SharePrefsHelper.getString("specialty");
    var subSpecialization =
        await SharePrefsHelper.getString("subSpecialization");
    var proSummery = await SharePrefsHelper.getString("proSummery");
    var experience = await SharePrefsHelper.getString("experience");
    var appointmentFee = await SharePrefsHelper.getString("appointmentFee");

    debugPrint("""
      Full Name: $firstName,
      Last Name: $lastName,
      Email: $email,
      Phone: $phone,
      Password: $password,
      Confirm Password: $confirmPassword,
      Specialization: $specialization,
      Sub Specialization: $subSpecialization,
      Professional Summary: $proSummery,
      Experience: $experience,
      CV File Path: ${cvFile.value},
      Certificate File Path: ${certificateFile.value},
      Brand Logo File Path: ${brandLogoFile.value},
      Person Image File Path: ${selectedImage.value},
      Appointment Fee: $appointmentFee,
      Start Time: $startTime,
      End Time: $endTime,
    """);
  }



  @override
  void onInit() {
    super.onInit();
    initializeAvailability();
    getCategoryList();
  }
}
