import 'dart:convert'; // Required for JSON encoding/decoding
import 'package:counta_flutter_app/helper/shared_prefe/shared_prefe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../service/api_check.dart';
import '../../../../../../service/api_client.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  RxSet<String> readNotifications = <String>{}.obs;

  ///================= GET NOTIFICATION LIST =================
  Rx<Status> notificationListLoader = Status.loading.obs;
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;
  Future<void> getNotificationList() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);
    debugPrint('=======Method Call ==============>${ApiUrl.getNotification}');
    try {
      var response =
          await ApiClient.getData(ApiUrl.getNotification(userId: userId));
      // var response = await ApiClient.getData(ApiUrl.getNotification);
      if (response.statusCode == 200) {
        notificationListLoader.value = Status.completed;
        var data = response.body['data'] ?? [];

        /// Ensure proper type conversion here
        notificationList.value = List<NotificationModel>.from(
          data.map((item) => NotificationModel.fromJson(item)),
        );

        refresh();
        debugPrint(
            "List of Print   ======================= ${notificationList.length}");
      } else {
        notificationListLoader.value = Status.error;
        ApiChecker.checkApi(response); // Null-safe
        refresh();
      }
    } catch (e) {
      notificationListLoader.value = Status.error;
      debugPrint('Error: $e');
      refresh();
    }
  }

  //=========================================== Dismis Specific Notification ===============================

  Future<void> dismisSingleNotification({required String id}) async {
    var body = {};
    var response = await ApiClient.patchData(
        ApiUrl.dismisSingleNotification(
          notificationId: id,
        ),
        jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      getNotificationList();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  //=================================== All Delete Notification ===============================

  Future<void> clearAllNotification() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);

    var body = {};

    var response = await ApiClient.deleteData(
        ApiUrl.clearAllNotification(userId: userId),
        body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      getNotificationList();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  /// Mark a notification as read
  void markAsRead(String id) {
    if (!readNotifications.contains(id)) {
      readNotifications.add(id);
      _saveReadNotifications();
    }
  }

  void clearAllNotifications() {
    notificationList.clear(); // List ta empty kore dibo
    readNotifications.clear(); // Read list o empty korbo
  }

  /// Save read notifications to SharedPreferences
  Future<void> _saveReadNotifications() async {
    await SharePrefsHelper.setString(
        'read_notifications', json.encode(readNotifications.toList()));
  }

  @override
  void onInit() {
    getNotificationList();
    super.onInit();
  }
}
