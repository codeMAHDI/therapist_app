import 'dart:io';
import 'package:counta_flutter_app/helper/shared_prefe/shared_prefe.dart';
import 'package:counta_flutter_app/helper/time_converter/time_converter.dart';
import 'package:counta_flutter_app/service/socket_service.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../service/api_check.dart';
import '../../../../service/api_client.dart';
import '../../../../service/api_url.dart';
import '../../../../utils/ToastMsg/toast_message.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../model/user_profile_model.dart';

class AuthController extends GetxController {
  //====================== Radio Button ======================
  RxString radioButton = AppStrings.userRole.obs;


  ///====================== User Profile ======================
  Rx<File?> profileImage = Rx<File?>(null); // Initialize Rx variable properly
  Rx<String> imagePath = Rx<String>("");
  Future<void> getFileImage() async {
    debugPrint("=============================> image Click");
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      debugPrint("=============================> image path ${image.path}");
      profileImage.value = File(image.path);
      imagePath.value = image.path;
      update(); // Automatically triggers UI update
    }
  }

  ///====================== 1- USER REGISTER ======================
  // Observable variables for form controllers
  Rx<TextEditingController> userFirstNameController =
      TextEditingController().obs;
  Rx<TextEditingController> userLastNameController =
      TextEditingController().obs;
  Rx<TextEditingController> userEmailController = TextEditingController().obs;
  Rx<TextEditingController> userPhoneController = TextEditingController().obs;
  Rx<TextEditingController> userLocationController =
      TextEditingController().obs;
  Rx<TextEditingController> userPasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> userConfirmPasswordController =
      TextEditingController().obs;

  Rx<TextEditingController> userDateController = TextEditingController().obs;

  ///========== USER PROFILE GET API ===========
  final rxRequestStatus = Status.loading.obs;
  void setRequestStatus(Status status) => rxRequestStatus.value = status;
  Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;

  Future<void> getUserProfile() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);
    var response =
        await ApiClient.getData(ApiUrl.getUserProfile(userId: userId));

    if (response.statusCode == 200) {
      try {
        var data = response.body['data'];
        userProfileModel.value = UserProfileModel.fromJson(data);

        //  Populate TextFields with API Data
        userFirstNameController.value.text =
            userProfileModel.value.firstName ?? "";
        userLastNameController.value.text =
            userProfileModel.value.lastName ?? "";
        userPhoneController.value.text = userProfileModel.value.phone ?? "";
        userLocationController.value.text =
            userProfileModel.value.profile?.address ?? "";

        // Use dateOfBirth from profile if available, otherwise fallback to createdAt
        final dob = userProfileModel.value.profile?.dateOfBirth;
        if (dob != null) {
          userDateController.value.text = DateFormat('yyyy-MM-dd').format(dob);
        } else {
          userDateController.value.text = DateConverter.dateFormetString(
              userProfileModel.value.createdAt.toString());
        }

        selectedGender.value = userProfileModel.value.profile?.gender ?? "";

        setRequestStatus(Status.completed);
        update();
      } catch (e) {
        setRequestStatus(Status.error);
        debugPrint("Parsing error: $e");
      }
    } else {
      setRequestStatus(Status.error);
      Get.snackbar("Error", "Failed to load user profile.");
    }
  }

  ///=========== USER UPDATE PROFILE API ===========
  RxBool userUpdateLoading = false.obs;
  Future<void> updateUserProfile() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);
    userUpdateLoading.value = true;
    refresh();
    Map<String, dynamic> updatedData = {
      "firstName": userFirstNameController.value.text,
      "lastName": userLastNameController.value.text,
      "phone": userPhoneController.value.text,
      "location": userLocationController.value.text,
      "dateOfBirth": userDateController.value.text,
      "gender": selectedGender.value.toString(),
      "role": "patient",
    };

    if (profileImage.value != null) {
      Map<String, String> body = {};
      var response = await ApiClient.patchMultipartData(
          ApiUrl.updateProfileImage(userId: userId), body,
          multipartBody: [
            MultipartBody(
              'image',
              profileImage.value!,
            )
          ]);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Profile image updated successfully.");
      }
    }

    var response = profileImage.value == null
        ? await ApiClient.patchData(
            ApiUrl.updateProfile(userId: userId), jsonEncode(updatedData))
        : await ApiClient.patchData(
            ApiUrl.updateUserProfile(userId: userId), jsonEncode(updatedData));
    if (response.statusCode == 200) {
      getUserProfile();
      userUpdateLoading.value = false;
      Get.snackbar("Success", "Profile updated successfully.");
      Get.offAllNamed(AppRoutes.userProfileScreen);
      profileImage.value = null;
    } else {
      Get.snackbar("Error", "Failed to update profile.");
      userUpdateLoading.value = false;
    }
  }

  ///======================  user Post API profile date ======================

  /// Date Formate======
  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(userDateController.value.text),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    userDateController.value.text = DateFormat('yyyy-MM-dd').format(picked!);
    }

  /// User Gender selection
  RxString selectedGender = ''.obs;
  final List<String> genderOptions = ['male', 'female', 'other'];
  // Set gender
  void setGender(String gender) {
    selectedGender.value = gender;
  }

  /// Image file to be uploaded
  Rx<File?> image = Rx<File?>(null);
  // Method to pick image from gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  // Date of birth
  RxString formattedDate = ''.obs;
  // Loading indicator
  RxBool userRegisterLoading = false.obs;
  // Sign up function

  Future<void> userSignUp() async {
    userRegisterLoading.value = true;
    // var selectedImagePath = profileImage.value;
    Map<String, String> body = {
      "firstName": userFirstNameController.value.text,
      "lastName": userLastNameController.value.text,
      "email": userEmailController.value.text,
      "phone": userPhoneController.value.text,
      "address": userLocationController.value.text,
      "gender": selectedGender.value,
      "dateOfBirth": userDateController.value.text,
      "password": userPasswordController.value.text,
      "role": "patient",

    };

    debugPrint('======================== ${body.toString()}');

    var response = await ApiClient.postMultipartData(ApiUrl.userRegister, body,
        multipartBody: [
          MultipartBody(
            'image',
            File(profileImage.value!.path),
          )
        ]);
    if (response.statusCode == 201 || response.statusCode == 200) {
      userRegisterLoading.value = false;
      //showCustomSnackBar(response.body['message']!, isError: false);
      Get.toNamed(AppRoutes.verificationScreen,
          arguments:
              UserModel(userEmailController.value.text, AppStrings.register));
      clearUserData();
    } else {
      if (response.statusText == ApiClient.somethingWentWrong) {
        showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
      } else {
        ApiChecker.checkApi(response);
      }
      userRegisterLoading.value = false;
    }
  }


  ///====================== 2- VALIDATION CONTROLLER ======================
  Rx<TextEditingController> otpController = TextEditingController().obs;
  //====== Validation Method =======
  RxBool otpLoading = false.obs;
  Future<void> verifyOtp(
      {required String email, required String screenName}) async {
    otpLoading.value = true;

    var body = {
      "email": email, // Ensure this email is correct
      "otp": otpController.value.text,
    };

    var body2 = {
      "email": email,
      "code": otpController.value.text,
    };

    debugPrint(
        "Submitted OTP Body: $body"); // Debugging: To check the submitted data

    var response = screenName == AppStrings.forgotPassword
        ? await ApiClient.postData(ApiUrl.otpVerify, jsonEncode(body))
        : await ApiClient.postData(ApiUrl.emailVerify, jsonEncode(body2));

    if (response.statusCode == 200) {
      otpLoading.value = false;
      showCustomSnackBar(response.body['message']!, isError: false);

      // Navigate based on screenName
      if (screenName == AppStrings.forgotPassword) {
        Get.offAllNamed(AppRoutes.setNewPasswordScreen,
            arguments: UserModel(email, AppStrings.resetPassword));
      } else if (screenName == AppStrings.register) {
        Get.offAllNamed(AppRoutes.loginScreen);
      } else {
        Get.offAllNamed(AppRoutes.userHomeScreen);
      }
    } else {
      otpLoading.value = false;

      // Error handling
      if (response.statusText == ApiClient.somethingWentWrong) {
        showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
      } else {
        ApiChecker.checkApi(response); // Log specific API errors
      }
    }
  }

  ///==================== 3- FORGET PASSWORD CONTROLLER==================
  Rx<TextEditingController> forgetEmailController = TextEditingController().obs;
  RxBool forgetPasswordLoading = false.obs;
  Future<void> forgetPassword(
      {required String email, required bool isForgot}) async {
    forgetPasswordLoading.value = true;
    refresh();
    var body = {
      "email": email,
    };
    var response =
        await ApiClient.postData(ApiUrl.forgetPassword, jsonEncode(body));
    if (response.statusCode == 200) {
      forgetPasswordLoading.value = false;
      SharePrefsHelper.setString(
          AppConstants.bearerToken, response.body['data']);
      refresh();
      showCustomSnackBar(response.body['message']!, isError: false);
      if (isForgot) {
        Get.offAllNamed(AppRoutes.verificationScreen,
            arguments: UserModel(
                forgetEmailController.value.text, AppStrings.forgotPassword));
      } else {
        Get.offAllNamed(AppRoutes.verificationScreen,
            arguments: UserModel(email, AppStrings.forgotPassword));
      }
    } else {
      if (response.statusText == ApiClient.somethingWentWrong) {
        showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
        forgetPasswordLoading.value = false;
        refresh();
        return;
      } else {
        ApiChecker.checkApi(response);
        forgetPasswordLoading.value = false;
        refresh();
        return;
      }
    }
  }

  ///==================== 4- SET NEW PASSWORD CONTROLLER==================

  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;
  RxBool newPasswordLoading = false.obs;
  Future<void> setNewPassword({required String email}) async {
    try {
      newPasswordLoading.value = true;

      var body = {
        "email": email,
        "newPassword": newPasswordController.value.text,
      };

      var response =
          await ApiClient.postData(ApiUrl.resetPassword, jsonEncode(body));

      if (response.statusCode == 200) {
        showCustomSnackBar(response.body['message']!, isError: false);
        Get.offAllNamed(AppRoutes.loginScreen);
      } else {
        if (response.statusText == ApiClient.somethingWentWrong) {
          showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
        } else {
          ApiChecker.checkApi(response);
        }
      }
    } catch (e) {
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    } finally {
      newPasswordLoading.value = false;
    }
  }

  ///======================LOGIN CONTROLLER=====================

  Rx<TextEditingController> loginEmailController = TextEditingController(
    text: kDebugMode ? "fiwixe2514@jarars.com" : "",
  ).obs;


  Rx<TextEditingController> loginPasswordController = TextEditingController(
    text: kDebugMode ? "12345678" : "",
  ).obs;

  ///=====================LOGIN METHOD=====================
  RxBool loginLoading = false.obs;
  Future<void> loginUser() async {
    loginLoading.value = true;
    var body = {
      "email": loginEmailController.value.text,
      "password": loginPasswordController.value.text,
      "isSocial": false,
      "fcmToken": null
    };
    var response = await ApiClient.postData(ApiUrl.login, jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      loginLoading.value = false;
      refresh();
      showCustomSnackBar(response.body['message']!, isError: false);
      // Save user data and token
      SharePrefsHelper.setString(
          AppConstants.bearerToken, response.body['data']['accessToken']);
      SharePrefsHelper.setString(
          AppConstants.userId, response.body['data']['_id']);
      String userRole = response.body['data']['role'];
      SharePrefsHelper.setString(AppConstants.role, userRole);
      SocketApi.init();
      if (userRole == "patient") {
        clearUserData();
        Get.offAllNamed(AppRoutes.userHomeScreen);
      } else {
        clearUserData();
        Get.offAllNamed(AppRoutes.therapistHomeScreen);
      }
      //   }
    } else {
      loginLoading.value = false;
      refresh();
      if (response.statusText == ApiClient.somethingWentWrong) {
        showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }
  ///====================== Two images for upload ======================
  Rx<File?> profilePhoto = Rx<File?>(null);
  Rx<File?> brandLogo = Rx<File?>(null);

  /// Pick Profile Photo
  Future<void> pickProfilePhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      profilePhoto.value = File(image.path);
      update();
    }
  }

  /// Pick Brand Logo
  Future<void> pickBrandLogo() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      brandLogo.value = File(image.path);
      update();
    }
  }

  RxBool uploadingImages = false.obs;

  Future<void> updateProfileAndLogo() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);

    if (profilePhoto.value == null && brandLogo.value == null) {
      Get.snackbar("Error", "Please select at least one image");
      return;
    }

    uploadingImages.value = true;

    Map<String, String> body = {}; // Add any fields if required
    List<MultipartBody> files = [];

    if (profilePhoto.value != null) files.add(MultipartBody('profilePhoto', profilePhoto.value!));
    if (brandLogo.value != null) files.add(MultipartBody('brandLogo', brandLogo.value!));

    try {
      var response = await ApiClient.patchMultipartData(
        ApiUrl.updateTherapistProfile(userId: userId),
        body,
        multipartBody: files,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Profile & Logo updated successfully");

        // Clear selected images
        profilePhoto.value = null;
        brandLogo.value = null;

        // Navigate to Therapist Home screen
        Get.offAllNamed(AppRoutes.therapistHomeScreen);
      } else {
        Get.snackbar("Error", "Failed to upload images");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      debugPrint("Upload error: $e");
    } finally {
      uploadingImages.value = false;
    }
  }



  // Clear form data
  void clearUserData() {
    userFirstNameController.value.clear();
    userLastNameController.value.clear();
    userEmailController.value.clear();
    userPhoneController.value.clear();
    userLocationController.value.clear();
    selectedGender.value = '';
    formattedDate.value = '';
    userPasswordController.value.clear();
    userConfirmPasswordController.value.clear();
    profileImage.value = null;
  }


  @override
  void onInit() {
    super.onInit();
    getUserProfile(); // Load user profile when the controller initializes
  }
}

class UserModel {
  final String email;
  final String screenName;
  UserModel(this.email, this.screenName);
}



