import 'dart:convert';

import 'package:counta_flutter_app/view/screens/user_part_screen/view/user_profile_screen/your_wallet_screen/paypal_webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:counta_flutter_app/service/api_client.dart';
import 'package:counta_flutter_app/service/api_url.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import '../../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../../helper/shared_prefe/shared_prefe.dart';
import '../model/your_wallet_model.dart';

class WalletController extends GetxController {
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
        var data =
            response.body['data']; // assuming the response is under 'data'
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

  ///============== DELETE YOUR ACCOUNT ==============
  RxBool deleteUserLoader = false.obs;

  Future<void> deleteUser(String userId) async {
    deleteUserLoader.value = true;
    update();
    debugPrint("====> API Request: ${ApiUrl.deleteUser(userId: userId)}");
    var response =
        await ApiClient.deleteData(ApiUrl.deleteUser(userId: userId));
    if (response.statusCode == 200) {
      deleteUserLoader.value = false;
      debugPrint("====> API Response: Success");
      Get.snackbar("Success", "User deleted successfully.");
      Get.offAllNamed(AppRoutes.loginScreen);
    } else {
      deleteUserLoader.value = false;
      debugPrint("====> API Response: ${response.statusCode} ${response.body}");
      Get.snackbar("Error", "Failed to delete user.");
    }
    update();
  }

  //========================================= Add Wallet ================================

  Rx<TextEditingController> amontcontroller = TextEditingController().obs;

  RxBool addWalletLoader = false.obs;

  Future<void> addWallet() async {
    addWalletLoader.value = true;
    update();
    var body = {"amount": amontcontroller.value.text};

    var response =
        await ApiClient.postData(ApiUrl.amountTopUp, jsonEncode(body));
    if (response.statusCode == 200) {
      addWalletLoader.value = false;
      // debugPrint("====> API Response: Success");
      // Get.snackbar("Success", "Wallet added successfully.");
      // getWallet();
      Get.to(() => PayPalWebView(
          paypalUrl: response.body['data']['approvalUrl'],
          onPaymentSuccess: (value, value2) {
            getWallet();
            debugPrint("==================Success: $value");
          },
          onPaymentError: (value) {
            debugPrint("==================Error: $value");
          }));
    } else {
      addWalletLoader.value = false;
      debugPrint("====> API Response: ${response.statusCode} ${response.body}");
      Get.snackbar("Error", "Failed to add wallet.");
    }
    update();
  }

  @override
  void onInit() {
    getWallet();
    super.onInit();
  }
}
