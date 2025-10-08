import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../../../service/api_check.dart';
import '../../../../../../../service/api_client.dart';
import '../../../../../../../service/api_url.dart';
import '../../../../../../../utils/app_const/app_const.dart';
import 'model/about_us_model.dart';
import 'model/privacy_model.dart';
import 'model/terms_model.dart';

class AboutController extends GetxController {
  RxBool isCheck = false.obs;

  ///=========================== Get Privacy Policy ===============================//
  final rxPrivacyStatus = Status.loading.obs;
  void setPrivacyStatus(Status value) {
    rxPrivacyStatus.value = value;
  }

  Rx<PrivacyModel> privacyModel = PrivacyModel().obs;

  Future<void> getPrivacyPolicy() async {
    var response = await ApiClient.getData(ApiUrl.privacyPolicy);
    if (response.statusCode == 200) {
      try {
        rxPrivacyStatus.value = Status.completed;
        var data = response.body["data"];
        privacyModel.value = PrivacyModel.fromJson(data);
        debugPrint(
            '======================================>Profile Image ${privacyModel.value.toJson()}');
        refresh();
      } catch (e) {
        // Catch parsing issues
        setPrivacyStatus(Status.error);
        debugPrint("Parsing error: $e");
        refresh();
      }
    }else if(response.statusCode == 404){
      rxPrivacyStatus.value =Status.error;
      //  setAboutStatus(Status.error);
      privacyModel.value = PrivacyModel();
    }
    else {
      if (response.statusText == ApiClient.somethingWentWrong) {
        setPrivacyStatus(Status.internetError);
      } else {
        setPrivacyStatus(Status.error);
      }
      ApiChecker.checkApi(response);
      refresh();
    }
  }

  ///=========================== Get Terms & Conditions ===============================//
  final rxTermsStatus = Status.loading.obs;
  void setTermsStatus(Status value) {
    rxTermsStatus.value = value;
  }
  Rx<TermsModel> termsModel = TermsModel().obs;
  Future<void> getTermsConditions() async {
    var response = await ApiClient.getData(ApiUrl.termsCondition);
    if (response.statusCode == 200) {
      try {
        rxTermsStatus.value = Status.completed;
        var data = response.body["data"];
        termsModel.value = TermsModel.fromJson(data);
        debugPrint(
            '======================================>Profile Image ${termsModel.value.toJson()}');
        refresh();
      } catch (e) {
        // Catch parsing issues
        setTermsStatus(Status.error);
        debugPrint("Parsing error: $e");
        refresh();
      }
    }else if(response.statusCode == 404){
      rxTermsStatus.value =Status.error;
      //  setAboutStatus(Status.error);
      termsModel.value = TermsModel();
    }
    else {
      if (response.statusText == ApiClient.somethingWentWrong) {
        setTermsStatus(Status.internetError);
      } else {
        setTermsStatus(Status.error);
      }
      ApiChecker.checkApi(response);
      refresh();
    }
  }


  //=========================== Get About US ===============================//
  final rxAboutStatus = Status.loading.obs;
  void setAboutStatus(Status value) {
    rxTermsStatus.value = value;
  }
  Rx<AboutUsModel> aboutModel = AboutUsModel().obs;
  Future<void> getAboutUs() async {
    var response = await ApiClient.getData(ApiUrl.aboutUs);
    if (response.statusCode == 200) {
      try {
        rxAboutStatus.value = Status.completed;
        var data = response.body["data"];
        aboutModel.value = AboutUsModel.fromJson(data);
        debugPrint(
            '======================================>Profile Image ${aboutModel.value.toJson()}');
        refresh();
      } catch (e) {
        // Catch parsing issues
        setAboutStatus(Status.error);
        debugPrint("Parsing error: $e");
        refresh();
      }
    } else if(response.statusCode == 404){
      rxAboutStatus.value =Status.error;
      //  setAboutStatus(Status.error);
      aboutModel.value = AboutUsModel();
    }
    else {
      if (response.statusText == ApiClient.somethingWentWrong) {
        setAboutStatus(Status.internetError);
      } else {
        setAboutStatus(Status.error);
      }
      ApiChecker.checkApi(response);
      refresh();
    }
  }



  @override
  void onInit() {
    getPrivacyPolicy();
    getTermsConditions();
    getAboutUs();
    super.onInit();
  }
}
