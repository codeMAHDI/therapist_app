import 'dart:convert';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/user_profile_screen/Invoice_list_sceen/model/invoice_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../../service/api_check.dart';
import '../../../../../../service/api_client.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../user_profile_screen/your_wallet_screen/controller/wallet_controller.dart';
import '../model/popular_doctor_model.dart';

class PopularDoctorController extends GetxController {
  RxDouble totalCost = 0.0.obs;
  void calculateCost(String timeRange, double hourlyRate) {
    // Define time format
    final DateFormat timeFormat = DateFormat("hh:mm a");

    // Split the time range
    final times = timeRange.split(" - ");
    final startTime = timeFormat.parse(times[0]);
    final endTime = timeFormat.parse(times[1]);

    // Calculate the duration in minutes
    final durationInMinutes = endTime.difference(startTime).inMinutes;

    // Convert the duration to hours
    final durationInHours = durationInMinutes / 60;

    // Calculate the total cost
    final cost = durationInHours * hourlyRate;
    totalCost.value = cost;
    refresh();
    debugPrint('Total Cost: $cost');
  }

  ///================= IS CURRENT OR FUTURE DATE TIME =================
  bool isCurrentOrFutureDateTime(
      {required String time, required DateTime date}) {
    try {
      // Fully sanitize the time string
      String sanitizedTime = sanitizeTimeString(time);
      // Parse the sanitized time string
      DateFormat format = DateFormat('h:mm a'); // 'hh:mm AM/PM'
      DateTime parsedTime = format.parse(sanitizedTime);

      // Combine the date with the parsed time
      DateTime combinedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        parsedTime.hour,
        parsedTime.minute,
      );

      // Compare the combined DateTime with the current DateTime
      DateTime now = DateTime.now();
      bool isValue = combinedDateTime.isAtSameMomentAs(now) ||
          combinedDateTime.isAfter(now);

      debugPrint(
          '=============== isCurrentOrFutureDateTime: $isValue ===============');
      return isValue;
    } catch (e) {
      debugPrint('Error parsing time: $e');
      return false; // Return false if the time string is invalid
    }
  }

  String sanitizeTimeString(String time) {
    return time
        .replaceAll(
            RegExp(r'\s+'), ' ') // Replace multiple spaces with a single space
        .replaceAll(
            String.fromCharCode(0x00A0), ' ') // Replace non-breaking spaces
        .replaceAll(RegExp(r'[^\x20-\x7E]'), '') // Remove non-ASCII characters
        .trim(); // Trim leading and trailing spaces
  }

  ///================= GET POPULAR LIST =================
  Rx<Status> popularListLoader = Status.loading.obs;
  RxList<PopularDoctorsModel> popularList = <PopularDoctorsModel>[].obs;
  Future<void> getPopularList() async {
    // final userId = await SharePrefsHelper.getString(AppConstants.userId);
    debugPrint(
        '=======Method Call ==============>${ApiUrl.getPopularTherapist}');
    try {
      var response = await ApiClient.getData(ApiUrl.getPopularTherapist);
      // var response = await ApiClient.getData(ApiUrl.getNotification);
      if (response.statusCode == 200) {
        popularListLoader.value = Status.completed;
        var data = response.body['data'] ?? [];

        /// Ensure proper type conversion here with error handling
        try {
          popularList.value = List<PopularDoctorsModel>.from(
            data.map((item) {
              try {
                debugPrint('Attempting to parse item: ${item.keys}');
                return PopularDoctorsModel.fromJson(item);
              } catch (e) {
                debugPrint('Error parsing individual doctor: $e');
                debugPrint('Problematic item: $item');
                return null;
              }
            }).where((doctor) {
              if (doctor == null) return false;
              final therapist = doctor.therapist;
              final hasName = (therapist?.firstName?.isNotEmpty ?? false) || (therapist?.lastName?.isNotEmpty ?? false);
              // Relaxed filtering - only require name, not image
              debugPrint('Doctor: ${therapist?.firstName} ${therapist?.lastName}, HasName: $hasName');
              return hasName;
            }),
          );
        } catch (e) {
          debugPrint('Error parsing doctor data: $e');
          popularList.value = [];
        }

        refresh();
        debugPrint(
            "List of Print   ======================= ${popularList.length}");
      } else {
        popularListLoader.value = Status.error;
        ApiChecker.checkApi(response); // Null-safe
        refresh();
      }
    } catch (e) {
      popularListLoader.value = Status.error;
      debugPrint('Error: $e');
      refresh();
    }
  }

  ///============= Post Appointment ==============
  Rx<TextEditingController> reasonController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  RxBool patientDetailsLoading = false.obs;

  Future<void> postAppointment({
    required String slot,
    required String date,
    required String therapistID,
  }) async {
    patientDetailsLoading.value = true;

    // Get the userId from SharedPreferences
    final userId = await SharePrefsHelper.getString(AppConstants.userId);

    // Get the token and wait for it
    final token = await SharePrefsHelper.getString(AppConstants.bearerToken);

    // Construct the request body JSON
    var body = {
      "patient": userId,
      "therapist": therapistID,
      "date": date,
      "slot": slot,
      "reason": reasonController.value.text,
      "description": descriptionController.value.text,
      "duration": {"value": 3600, "unit": "seconds"},
      "feeInfo": {
        "bookedFee": {"amount": totalCost.value.toInt(), "currency": "USD"},
        "patientTransactionId": "txn_123456789"
      },
      "isAvailableInWallet": checkWalletBalance(),
    };

    // Perform the API call
    try {
      var response = await ApiClient.postData(
          ApiUrl.postAppointment, jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer $token", // Make sure the token is a String, not Future<String>
          });

      // Handling the API response
      if (response.statusCode == 200 || response.statusCode == 201) {
        patientDetailsLoading.value = false;
        refresh();
        showCustomSnackBar(response.body['message'] ?? 'No message available',
            isError: false);
        // SharePrefsHelper.setString(
        //     AppConstants.bearerToken, response.body['data']['accessToken']);

        //==========================  Call Get invoice Id ===========================
        getInvoiceByAppointmentId(appointmentId: response.body['data']['_id']);

        //  Get.toNamed(AppRoutes.bookedScreen);
      } else {
        // If the slot is already booked
        if (response.body['error']?.contains('already booked') ?? false) {
          patientDetailsLoading.value = false;
          Get.snackbar(
            "Slot Already Booked",
            "The selected slot has already been booked. Please choose another slot.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          patientDetailsLoading.value = false;
          ApiChecker.checkApi(response);
        }
      }
    } catch (e) {
      patientDetailsLoading.value = false;
      showCustomSnackBar("An error occurred: $e", isError: true);
    }
  }
  //============================================= Get Invoice by appointment id =-=====================================

  RxList<InvoiceListModel> singleInvoice = <InvoiceListModel>[].obs;

  Future<void> getInvoiceByAppointmentId({required String appointmentId}) async {
    var response = await ApiClient.getData(
        ApiUrl.getInvoiceByAppointmentId(appointmentId: appointmentId));

    if (response.statusCode == 200 || response.statusCode == 201) {
      singleInvoice.value = List<InvoiceListModel>.from(
          response.body['data'].map((x) => InvoiceListModel.fromJson(x)));

      Get.toNamed(AppRoutes.bookedScreen);
      refresh();

      // debugPrint("Invoice: ${singleInvoice.value.toJson()}");
    } else {
      ApiChecker.checkApi(response);
    }
  }

  //====================================== Check Wallet Balance ======================================

  final WalletController walletController = Get.find<WalletController>();

  bool checkWalletBalance() {
    if (walletController.yourWalletModel.value.balance?.amount == null) {
      return false;
    }
    if (totalCost.value >=
        walletController.yourWalletModel.value.balance!.amount!) {
      return false;
    } else {
      return true;
    }
  }

  //=================================== Get Therapist By Speciality ================================

  RxList<PopularDoctorsModel> therapistBySpecialityList =
      <PopularDoctorsModel>[].obs;

  Rx<Status> therapistBySpecialityLoader = Status.loading.obs;

  RxInt totalPage = 1.obs;
  RxInt currentPage = 1.obs;
  RxString specialityId = "".obs;

  Future<void> getTherapistbySpeciality({
    required String therapistID,
  }) async {
    specialityId.value = therapistID;
    refresh();
    var response = await ApiClient.getData(ApiUrl.getTherapistBySpeciality(
        specialityId: therapistID, currentPage: currentPage.value));

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        therapistBySpecialityList.value = List<PopularDoctorsModel>.from(
          response.body['data']
              .map((item) {
                try {
                  debugPrint('Speciality - Attempting to parse item: ${item.keys}');
                  return PopularDoctorsModel.fromJson(item);
                } catch (e) {
                  debugPrint('Speciality - Error parsing individual doctor: $e');
                  debugPrint('Speciality - Problematic item: $item');
                  return null;
                }
              })
              .where((doctor) {
                if (doctor == null) return false;
                final therapist = doctor.therapist;
                final hasName = (therapist?.firstName?.isNotEmpty ?? false) || (therapist?.lastName?.isNotEmpty ?? false);
                debugPrint('Speciality Doctor: ${therapist?.firstName} ${therapist?.lastName}, HasName: $hasName');
                return hasName;
              }),
        );
      } catch (e) {
        debugPrint('Error parsing speciality doctor data: $e');
        therapistBySpecialityList.value = [];
      }

      totalPage.value = response.body['meta']['totalPage'];
      currentPage.value = response.body['meta']['currentPage'];

      therapistBySpecialityLoader.value = Status.completed;
      refresh();
    } else {
      therapistBySpecialityLoader.value = Status.error;
      ApiChecker.checkApi(response);
      refresh();
    }
  }

  //=================================== Get Therapist By Speciality With Pagination ================================

  RxBool isLoadMoreRunning = false.obs;
  RxInt page = 1.obs;

  void pageInit() {
    page.value = currentPage.value;
  }

  //======================== Get More Appoinment With Pagination =======================
  Rx<ScrollController> specialityScrollController = ScrollController().obs;
  Future<void> loadMoreAppointment() async {
    if (isLoadMoreRunning.value == false &&
        totalPage.value != 1 &&
        totalPage.value != currentPage.value &&
        therapistBySpecialityLoader.value != Status.loading) {
      page.value += 1;

      isLoadMoreRunning(true);

      var response = await ApiClient.getData(ApiUrl.getTherapistBySpeciality(
          specialityId: specialityId.value, currentPage: currentPage.value));

      if (response.statusCode == 200 || response.statusCode == 201) {
        therapistBySpecialityList.value = List<PopularDoctorsModel>.from(
            response.body['data']
                .map((item) => PopularDoctorsModel.fromJson(item)));

        totalPage.value = response.body['meta']['totalPage'];
        currentPage.value = response.body['meta']['currentPage'];
        isLoadMoreRunning(false);

        refresh();
      } else {
        therapistBySpecialityLoader.value = Status.error;
        ApiChecker.checkApi(response);
        refresh();
      }
    }
  }

  Future<void> addScrollListener() async {
    specialityScrollController.value.addListener(() {
      if (specialityScrollController.value.position.atEdge) {
        if (specialityScrollController.value.position.pixels != 0) {
          loadMoreAppointment();
        }
      }
    });
  }

  @override
  void onInit() {
    specialityScrollController.value.addListener(addScrollListener);
    getPopularList();
    super.onInit();
  }
}
