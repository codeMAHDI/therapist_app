import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../../../service/api_client.dart';
import '../../../../../../../service/api_url.dart';
import '../../../../../../../utils/app_const/app_const.dart';
import '../../../../../therapist_part_screen/model/payment_history.dart';

class EditProfileController extends GetxController{

  ///=========== Date Time GetX Controller Code ===========//
// Observable to track the selected DateTime
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
// Method to format the DateTime for display
  String get formattedDate {
    if (selectedDate.value != null) {
      return DateFormat('dd-MM-yyyy').format(selectedDate.value!);
    }
    return 'No Date Selected';
  }

// Function to pick a date
  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!, // Use GetX context
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    selectedDate.value = pickedDate;
    }

  ///========================= Payment History api implementation =========================

  Rx<Status> paymentHistoryLoader = Status.loading.obs;
  RxList<PaymentHistoryModel> paymentHistoryList = <PaymentHistoryModel>[].obs;

  Future<void> getPaymentHistory() async {
    debugPrint('======= API Call: ${ApiUrl.getPaymentHistory}');
    try {
      final userId = await SharePrefsHelper.getString(AppConstants.userId);
      final response =
      await ApiClient.getData(ApiUrl.getPaymentHistory(userId: userId));

      if (response.statusCode == 200) {
        var data = response.body['data'] ?? [];
        paymentHistoryList.value = List<PaymentHistoryModel>.from(
          data.map((item) => PaymentHistoryModel.fromJson(item)),
        );
        paymentHistoryLoader.value = Status.completed;
      } else {
        paymentHistoryLoader.value = Status.error;
        debugPrint('API Error: ${response.body}');
      }
    } catch (e) {
      paymentHistoryLoader.value = Status.error;
      debugPrint('Exception: $e');
    }
  }

 @override
  void onInit() {
    super.onInit();
    getPaymentHistory();
  }


}