import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../../service/api_client.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../user_part_screen/view/user_profile_screen/Invoice_list_sceen/model/invoice_by_user_model.dart';
import '../../../../user_part_screen/view/user_profile_screen/Invoice_list_sceen/model/invoice_list_model.dart';
import '../../../model/payment_history.dart';
import '../model/subscription_model.dart';
class SubscriptionController extends GetxController {
  RxInt selectedIndex = (-1).obs;
  ///========================= subscription api implementation =========================
  Rx<Status> subscriptionLoader = Status.loading.obs;
  RxList<SubScriptionModel> subscriptionList = <SubScriptionModel>[].obs;

  Future<void> getSubscriptionList() async {
    debugPrint('======= API Call: ${ApiUrl.getSubscriptionList}');
    try {
      subscriptionLoader.value = Status.loading;
      final response = await ApiClient.getData(ApiUrl.getSubscriptionList,);

      if (response.statusCode == 200) {
        var data = response.body['data'] ?? [];
        subscriptionList.value = List<SubScriptionModel>.from(
          data.map((item) => SubScriptionModel.fromJson(item)),
        );
        subscriptionLoader.value = Status.completed;
      } else {
        subscriptionLoader.value = Status.error;
        debugPrint('API Error: ${response.body}');
      }
    } catch (e) {
      subscriptionLoader.value = Status.error;
      debugPrint('Exception: $e');
    }
  }

  ///========================= Invoice Search api Search =========================
  var invoiceSearchLoader = Status.loading.obs; // Handle loading states
  var invoiceSearchList = <dynamic>[].obs; // All invoices
  var filteredInvoiceList = <dynamic>[].obs; // Filtered invoices
  var searchQuery = ''.obs; // To store the search query

  // Method to get invoices (fetch data)
  Future<void> getInvoices({String query = ''}) async {
    invoiceSearchLoader.value = Status.loading;
    try {
      // Construct the search URL with the query
      final response = await ApiClient.getData(
        ApiUrl.getSearchInvoce(text: query),
        headers: {
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${SharePrefsHelper.getString(AppConstants.bearerToken)}',
        },
      );
      if (response.statusCode == 200) {
        // If the API returns a success response
        var data = json.decode(response.body);
        invoiceSearchList.value =
            data['data']; // Assuming the data comes inside a 'data' field
        filteredInvoiceList.value = invoiceList; // Initially show all invoices
        invoiceSearchLoader.value = Status.completed;
      } else {
        // If the API fails
        Get.snackbar('Error', 'Failed to load data');
        invoiceSearchLoader.value = Status.error;
      }
    } catch (e) {
      // Handle errors
      Get.snackbar('Error', 'Something went wrong: $e');
      invoiceLoader.value = Status.error;
    }
  }

  // Method to filter invoices based on search query
  void searchInvoices() {
    if (searchQuery.value.isEmpty) {
      // If the search query is empty, show all invoices
      filteredInvoiceList.value = invoiceList;
    } else {
      // Filter the invoices based on the invoiceId or other fields
      filteredInvoiceList.value = invoiceList.where((invoice) {
        return invoice.invoiceId != null &&
            invoice.invoiceId
                .toString()
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  ///========================= Payment History api implementation =========================

  Rx<Status> paymentHistoryLoader = Status.loading.obs;
  RxList<PaymentHistoryModel> paymentHistoryList = <PaymentHistoryModel>[].obs;

  Future<void> getPaymentHistory() async {
    debugPrint('======= API Call: ${ApiUrl.getPaymentHistory}');
    try {
      paymentHistoryLoader.value = Status.loading;
      final userId = await SharePrefsHelper.getString(AppConstants.userId);
      final response = await ApiClient.getData(ApiUrl.getPaymentHistory(userId: userId));

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

  ///========================= INVOICE LIST API IMPLEMENTATION =========================///
  Rx<Status> invoiceLoader = Status.loading.obs;
  RxList<InvoiceListModel> invoiceList = <InvoiceListModel>[].obs;

  Future<void> getInvoice() async {
    debugPrint('======= API Call: ${ApiUrl.getInvoice}');
    try {
      invoiceLoader.value = Status.loading;
      final userId = await SharePrefsHelper.getString(AppConstants.userId);
      final response = await ApiClient.getData(ApiUrl.getInvoice(userId: userId));

      if (response.statusCode == 200) {
        var data = response.body['data'] ?? [];
        invoiceList.value = List<InvoiceListModel>.from(
          data.map((item) => InvoiceListModel.fromJson(item)),
        );
        invoiceLoader.value = Status.completed;
      } else {
        invoiceLoader.value = Status.error;
        debugPrint('API Error: ${response.body}');
      }
    } catch (e) {
      invoiceLoader.value = Status.error;
      debugPrint('Exception: $e');
    }
  }


  ///========================= INVOICE BY USER ID API IMPLEMENTATION =========================
  Rx<Status> invoiceByUserLoader = Status.loading.obs;
  Rx<InvoiceByUserModel> invoiceByUserModel = InvoiceByUserModel().obs;
  Future<void> getInvoiceByUserId({required String id}) async {
   // final userId = await SharePrefsHelper.getString(AppConstants.userId);
    final response = await ApiClient.getData(ApiUrl.getInvoiceByUser(userId: id));
    if (response.statusCode == 200) {
      var data = response.body['data'];
      invoiceByUserModel.value = InvoiceByUserModel.fromJson(data);
      invoiceByUserLoader.value = Status.completed;
    } else {
      invoiceByUserLoader.value = Status.error;
      debugPrint('API Error: ${response.body}');
    }
    debugPrint('======= API Call: ${ApiUrl.getInvoiceByUser}');
  }


  ///============ Contact Us API IMPLEMENTATION =========================
  RxBool contactUsLoader = false.obs;
  Rx<TextEditingController> subjectController = TextEditingController().obs;
  Rx<TextEditingController> messageController = TextEditingController().obs;
  Future<void> contactUs({required String firstName}) async {
    contactUsLoader.value = true;
    refresh();
    var body = {
      "firstName": firstName,
      "role": "patient",
      "subject": subjectController.value.text,
      "message": messageController.value.text,
    };
    var response = await ApiClient.postData(ApiUrl.postContactUs,jsonEncode(body));
    if (response.statusCode == 200) {
      Get.back();
      contactUsLoader.value = false;
      Get.snackbar("Success", "Message sent successfully.");
      clearContactUs();
    } else {
      contactUsLoader.value = false;
      Get.snackbar("Error", "Failed to send message.");
    }
  }
  void clearContactUs() {
    subjectController.value.clear();
    messageController.value.clear();
  }



  @override
  void onInit() {
    super.onInit();
    debounce(searchQuery, (value) {
      searchInvoices();
    }, time: Duration(milliseconds: 500));
    getInvoice();
   // getInvoiceByUserId();
    getSubscriptionList();
    getPaymentHistory();
  }
}
