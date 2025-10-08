import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../service/api_check.dart';
import '../../../../service/api_client.dart';
import '../../../../service/api_url.dart';
import '../../../../utils/app_const/app_const.dart';
import '../view/user_my_bookings_screen/model/pending_model.dart';

class UserMyBookingController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxList<String> nameList = [
    "Pending",
    'Approved',
    'Completed',
    'Cancelled',
  ].obs;

  ///================= GET APPOINTMENT LIST =================
  Rx<Status> appointmentListLoader = Status.loading.obs;
  RxList<PendingModel> appointmentList = <PendingModel>[].obs;
  Future<void> getAppointmentList() async {
    appointmentListLoader.value = Status.loading;
    final userId = await SharePrefsHelper.getString(AppConstants.userId);
    debugPrint('=======Method Call ==============>${ApiUrl.getAppointment}');
    try {
      var response = await ApiClient.getData(ApiUrl.getAppointment(
          userId: userId,
          role: "patient",
          status: nameList[currentIndex.value].toLowerCase()));
      // var response = await ApiClient.getData(ApiUrl.getNotification);
      if (response.statusCode == 200) {
        appointmentListLoader.value = Status.completed;
        var data = response.body['data'] ?? [];

        /// Ensure proper type conversion here
        appointmentList.value = List<PendingModel>.from(
          data.map((item) => PendingModel.fromJson(item)),
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

  ///================= DELETE APPOINTMENT =================
  Rx<TextEditingController> reasonController = TextEditingController().obs;
  var isLoading = false.obs;

  get therapistImageByAppointmentId => null;

  Future<void> deleteAppointment(String appointmentId) async {
    if (reasonController.value.text.isEmpty) {
      Get.snackbar("Error", "Please reason this ",
          snackPosition: SnackPosition.TOP);
      return;
    }
    isLoading.value = true;

    var body = {
      "cancelReason": reasonController.value.text,
    };

    try {
      final response = await ApiClient.deleteData(
        ApiUrl.delReason(appointmentId: appointmentId),
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        getAppointmentList();
        reasonController.value.clear(); // কারণ ফাঁকা করে দিচ্ছি
        Get.back(result: true); // আগের স্ক্রিনে ফিরে যাওয়া
        Get.snackbar("Successful!", "Your appointment has been canceled.",
            snackPosition: SnackPosition.TOP);
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      debugPrint('There was a problem deleting the appointment: $e');
      Get.snackbar("Error!", "Something went wrong, please try again.",
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getAppointmentList();
    super.onInit();
  }
}
