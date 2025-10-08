import 'dart:convert';

import 'package:counta_flutter_app/utils/ToastMsg/toast_message.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_bookings_screen/apointment_model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../service/api_check.dart';
import '../../../../service/api_client.dart';
import '../../../../service/api_url.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../user_part_screen/view/user_profile_screen/your_wallet_screen/model/your_wallet_model.dart';

class TherapistHomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxInt appointmentTypeindex = 0.obs;
  RxList<String> nameList = [
    AppStrings.today,
    AppStrings.upcomming,
  ].obs;

  ///================== Appointment Type List ===============
  RxList<String> appointmentTypeList =
      ['Pending', 'Completed', 'Cancelled', 'Missed'].obs;

  ///============= tab bar ==========
  RxList<String> tabNamelist =
      <String>[AppStrings.canceled, AppStrings.canceledRequest].obs;

  ///================= GET APPOINTMENT LIST =================
  Rx<Status> appointmentListLoader = Status.loading.obs;
  RxList<PendingModelByTherapist> appointmentList =
      <PendingModelByTherapist>[].obs;
  Future<void> getAppointmentList() async {
    appointmentListLoader.value = Status.loading;
    final userId = await SharePrefsHelper.getString(AppConstants.userId);
    debugPrint('=======Method Call ==============>${ApiUrl.getAppointment}');
    try {
      var response = currentIndex.value == 2 && appointmentTypeindex.value == 1
          ? await ApiClient.getData(ApiUrl.getAppointment(
              userId: userId,
              role: "therapist",
              status: "cancelled-requested",
            ))
          : await ApiClient.getData(ApiUrl.getAppointment(
              userId: userId,
              role: "therapist",
              status: appointmentTypeList[currentIndex.value].toLowerCase(),
            ));
      // var response = await ApiClient.getData(ApiUrl.getNotification);
      if (response.statusCode == 200) {
        appointmentListLoader.value = Status.completed;
        var data = response.body['data'];

        /// Ensure proper type conversion here
        appointmentList.value = List<PendingModelByTherapist>.from(
          data.map((item) => PendingModelByTherapist.fromJson(item)),
        );

        refresh();
        debugPrint(
            "List of Print   ======================= ${appointmentList.length}");
      } else {
        appointmentListLoader.value = Status.error;
        ApiChecker.checkApi(response); // Null-safe
        refresh();
      }
    } catch (e) {
      appointmentListLoader.value = Status.error;
      debugPrint('Error: $e');
      refresh();
    }
  }
  //========================================== Accept Appointment ===========================

  Future<void> acceptedAppointment(String id) async {
    var body = {};

    var response = await ApiClient.patchData(
        ApiUrl.acceptedAppointment(appointmentID: id), jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      getAppointmentList();
      refresh();
      Get.back();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  //=========================== Cancel Appointment By Therapist ======================
 
Future<void> cancelAppointmentByTherapist(String id) async {
  // Show a loading indicator to give the user feedback.
  Get.dialog(
    const Center(child: CircularProgressIndicator()),
    barrierDismissible: false,
  );
  var response = await ApiClient.deleteData(
      ApiUrl.cancelAppointment(appointmentID: id));
  Get.back();
 
  if (response.statusCode == 200) {
    // Show a success message
    showCustomSnackBar("Appointment canceled successfully",);
    getAppointmentList();
    getAccpedAndToadyAppointment();
 
  } else {
    ApiChecker.checkApi(response);
  }
}

  //============================================== Get All Accepted and Today Appointment ========================

  Rx<Status> homeSatatus = Status.loading.obs;

  RxList<PendingModelByTherapist> homeList = <PendingModelByTherapist>[].obs;

  Future<void> getAccpedAndToadyAppointment() async {
    homeSatatus = Status.loading.obs;
    refresh();
    final userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = currentIndex.value == 1
        ? await ApiClient.getData(
            ApiUrl.acceptedAllAppointmentbyTherapist(userID: userId))
        : await ApiClient.getData(ApiUrl.allToadyAppointments(userID: userId));

    if (response.statusCode == 200 || response.statusCode == 201) {
      homeList.value = List<PendingModelByTherapist>.from(response.body['data']
          .map((x) => PendingModelByTherapist.fromJson(x)));
      homeSatatus.value = Status.completed;
    } else {
      homeSatatus.value = Status.error;
      ApiChecker.checkApi(response);
    }
  }

  ///================= Get Appointment Balance =================

  // Wallet loading status
  final walletLoader = Status.loading.obs;
  // Store the wallet data
  Rx<YourWalletModel> yourWalletModel = YourWalletModel().obs;
  // Update wallet status
  void setWalletStatus(Status status) => walletLoader.value = status;

  // Fetch wallet data
  Future<void> getWallet() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);
    var response = await ApiClient.getData(ApiUrl.getWallet(userId: userId));

    // Handle the response
    if (response.statusCode == 200) {
      try {
        var data = response.body['data']; // assuming the response is under 'data'
        yourWalletModel.value = YourWalletModel.fromJson(data);
        setWalletStatus(Status.completed); // Update status to completed
      } catch (e) {
        setWalletStatus(Status.error); // Set error if any issue occurs
        debugPrint("Parsing error: $e");
      }
    } else {
      setWalletStatus(Status.error); // Set error if API response is not OK
      Get.snackbar("Error", "Failed to load wallet data.");
    }
  }




  @override
  void onInit() {
    getAccpedAndToadyAppointment();
    getAppointmentList();
    getWallet();
    super.onInit();
  }
}
