import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:counta_flutter_app/helper/shared_prefe/shared_prefe.dart';
import 'package:counta_flutter_app/service/api_check.dart';
import 'package:counta_flutter_app/service/api_client.dart';
import 'package:counta_flutter_app/service/api_url.dart';
import 'package:counta_flutter_app/service/socket_service.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_chat_screen/model/conversation_model.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_chat_screen/model/meesage_model.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/user_chat_screen/calling_popup/calling_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/model/therapist_register_model.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/user_my_bookings_screen/model/pending_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/app_routes/app_routes.dart';

class UserChatController extends GetxController {
  //========================================== get Conversation List ================================

  RxString userId = ''.obs;
  final RxMap<String, String> therapistImageByUserId = <String, String>{}.obs;
  final RxMap<String, String> therapistImageByAppointmentId = <String, String>{}.obs;
    RxList<ConvarsationModel> filteredConversations = <ConvarsationModel>[].obs;

//======================================== Start Message First time ==============================

  void checkCreateConversation({required String appointmentID}) async {
    for (int i = 0; i < conversationList.length; i++) {
      if (conversationList[i].appointment == appointmentID) {
        return Get.toNamed(AppRoutes.userMeessageScreen,
            arguments: conversationList[i]);
      } else {
        continue;
      }
    }

    createConversation(appointmentID: appointmentID);
  }
  // Get.toNamed(AppRoutes.therapistMeesageScreen, arguments: data);

  //==================================== Create Conversation ===============================

  Future<void> createConversation({required String appointmentID}) async {
    var response = await ApiClient.getData(
        ApiUrl.createConversation(appointmentID: appointmentID));

    if (response.statusCode == 200 || response.statusCode == 201) {
      getConversation();
      checkCreateConversation(appointmentID: appointmentID);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  ///===================================//=============================

  Rx<Status> getConversationStatus = Status.loading.obs;

  RxList<ConvarsationModel> conversationList = <ConvarsationModel>[].obs;

  ///================ Filter Conversations =================
void filterConversations(String query) {
  if (query.isEmpty) {
    filteredConversations.value = List.from(conversationList);
  } else {
    filteredConversations.value = conversationList.where((c) {
      final therapistName = c.therapist?.name?.toLowerCase() ?? '';
      final lastMsg = c.lastMessage?.id?.content?.toLowerCase() ?? '';
      final q = query.toLowerCase();
      return therapistName.contains(q) || lastMsg.contains(q);
    }).toList();
  }
  refresh();
}
  /// Call this after fetching conversations to initialize filtered list
  void initializeFilteredList() {
    filteredConversations.value = List.from(conversationList);
  }



//=========================================== get conversation ================================


  Future<void> getConversation() async {
  final userID = await SharePrefsHelper.getString(AppConstants.userId);
  userId.value = userID;
  refresh();

  final response = await ApiClient.getData(ApiUrl.getConversationByUserid(userID: userID));

  if (response.statusCode == 200 || response.statusCode == 201) {
    conversationList.value = List<ConvarsationModel>.from(
      response.body['data'].map((x) => ConvarsationModel.fromJson(x))
    );
    // Initialize filteredConversations
    filteredConversations.value = List.from(conversationList);
    getConversationStatus.value = Status.completed;
    _prefetchTherapistImages();
    _fetchTherapistImagesFromBookings();
  } else {
    getConversationStatus.value = Status.error;
    ApiChecker.checkApi(response);
  }
}
//here's the function in the controller to fetch the therapist image by user id

  Future<void> _prefetchTherapistImages() async {
    try {
      final Set<String> therapistUserIds = conversationList
          .map((c) => c.therapist?.therapistUserId?.id)
          .whereType<String>()
          .toSet();

      final List<String> idsToFetch = therapistUserIds
          .where((id) => !(therapistImageByUserId.containsKey(id)))
          .toList();

      if (idsToFetch.isEmpty) return;

      await Future.wait(idsToFetch.map((id) async {
        try {
          final res = await ApiClient.getData(ApiUrl.getProfile(userId: id));
          if (res.statusCode == 200 || res.statusCode == 201) {
            final data = res.body is Map<String, dynamic>
                ? res.body
                : (res.body['data'] ?? res.body);
            final model = TherapistRegisterModel.fromJson(
                data is Map<String, dynamic> ? data : res.body['data']);
            final imagePath = model.profile?.image;
            if (imagePath != null && imagePath.isNotEmpty) {
              therapistImageByUserId[id] = imagePath;
            }
          }
        } catch (_) {}
      }));

      refresh();
    } catch (_) {}
  }

  Future<void> _fetchTherapistImagesFromBookings() async {
    try {
      final String currentUserId = userId.value.isNotEmpty
          ? userId.value
          : await SharePrefsHelper.getString(AppConstants.userId);

      final List<String> statuses = [
        'pending',
        'approved',
        'completed',
        'cancelled',
      ];

      await Future.wait(statuses.map((status) async {
        try {
          final res = await ApiClient.getData(ApiUrl.getAppointment(
              userId: currentUserId, role: 'patient', status: status));
          if (res.statusCode == 200 || res.statusCode == 201) {
            final list = (res.body['data'] as List<dynamic>?) ?? [];
            for (final item in list) {
              final model = PendingModel.fromJson(
                  item is Map<String, dynamic> ? item : (item as dynamic));
              final appointmentId = model.id ?? '';
              final imagePath = model.therapist?.profile?.image;
              if (appointmentId.isNotEmpty && imagePath != null && imagePath.isNotEmpty) {
                therapistImageByAppointmentId[appointmentId] = imagePath;
              }

              final therapistUserId = model.therapist?.id;
              if (therapistUserId != null && therapistUserId.isNotEmpty && imagePath != null && imagePath.isNotEmpty) {
                therapistImageByUserId[therapistUserId] = imagePath;
              }
            }
          }
        } catch (_) {}
      }));

      refresh();
    } catch (_) {}
  }

  //=========================================== get message list ================================

  Rx<Status> messageStatusLoading = Status.loading.obs;

  RxList<MessageModel2> messageList = <MessageModel2>[].obs;

  Future<void> getAllMessage({required String conversationId}) async {
    var response = await ApiClient.getData(
        ApiUrl.getNessage(conversationId: conversationId));

    if (response.statusCode == 200 || response.statusCode == 201) {
      messageList.value = List<MessageModel2>.from(
          response.body['data'].map((x) => MessageModel2.fromJson(x)));
      messageStatusLoading.value = Status.completed;
    } else {
      ApiChecker.checkApi(response);
      messageStatusLoading.value = Status.error;
      refresh();
    }
  }

  //========= Image Picker GetX Controller Code ===========//

  final RxList<File> selectedImages = <File>[].obs;
  final ImagePicker _picker = ImagePicker();

// Pick multiple images from the gallery
  Future<void> pickImagesFromGallery() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      selectedImages.addAll(images.map((image) => File(image.path)));
    }
  }

  final Rx<File?> selectedImage = Rx<File?>(null);
// Pick an image using the camera
  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

//================================================== Send Message ================================

  Rx<TextEditingController> messageController = TextEditingController().obs;

  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
  }) async {
    try {
      var messageText = messageController.value.text.trim();

      if (messageText.isEmpty && selectedImages.isEmpty) {
        debugPrint("⚠️ Cannot send an empty message");
        return;
      }

      var body = {
        "conversation": conversationId,
        "sender": senderId,
        "senderRole": 'patient',
        "type": selectedImages.isNotEmpty ? 'attachment' : 'text',
        "content": messageText,
      };

      RxList<MultipartBody> multipartBody = <MultipartBody>[].obs;

      if (selectedImages.isNotEmpty) {
        multipartBody.value = selectedImages
            .map((image) => MultipartBody('attachment', File(image.path)))
            .toList();
        refresh();
      }

      var response = selectedImages.isEmpty
          ? await ApiClient.postData(ApiUrl.sendMessage, jsonEncode(body))
          : await ApiClient.postMultipartData(
        ApiUrl.sendMessage,
        body,
        // ignore: invalid_use_of_protected_member
        multipartBody: multipartBody.value,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("✅ Message sent successfully!");
        messageController.value.clear();
        getAllMessage(conversationId: conversationId);
        getConversation();
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      debugPrint("❌ Error sending message: $e");
    }
  }

  // sendMessage({
  //   required String conversationId,
  //   required String senderId,
  // }) async {
  //   var body = {
  //     "conversation": conversationId,
  //     "sender": senderId,
  //     "senderRole": 'patient',
  //     "type": 'text',
  //     "content": messageController.value.text,
  //   };

  //   var body2 = {
  //     "conversation": conversationId,
  //     "sender": senderId,
  //     "senderRole": 'patient',
  //     "type": 'attachment',
  //     "content": messageController.value.text,
  //   };

  //   RxList<MultipartBody> multipartBody = <MultipartBody>[].obs;

  //   if (selectedImages.isNotEmpty) {
  //     multipartBody.value = selectedImages
  //         .map((image) => MultipartBody('attachment', File(image.path)))
  //         .toList();
  //     refresh();
  //   }

  //   // ignore: invalid_use_of_protected_member
  //   var response = selectedImages.value.isEmpty
  //       ? await ApiClient.postData(ApiUrl.sendMessage, jsonEncode(body))
  //       : await ApiClient.postMultipartData(
  //           ApiUrl.sendMessage, body2,
  //           // ignore: invalid_use_of_protected_member
  //           multipartBody: multipartBody.value,
  //         );

  //   //  [
  //   //     MultipartBody('attachment', File(selectedImage.value!.path))
  //   //   ]);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     messageController.value.clear();
  //     getAllMessage(conversationId: conversationId);
  //     getConversation();
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  // }

  //========================================= Get Message in real time ================================

  void receivedNewMessage() async {
    debugPrint('🔄 Socket initialized, now listening for messages...');
    if (!SocketApi.isConnected()) {
      debugPrint('❌ Cannot listen for messages. Socket is not connected.');
      return;
    }

    debugPrint('✅ Listening for new messages...');

    // Ensure we don't add duplicate listeners
    SocketApi.listen('newMessage', (dynamic data) {
      debugPrint('📩 New Message Received: $data');

      if (data is Map<String, dynamic> && data.containsKey('conversation')) {
        String conversationId = data['conversation'];

        // Fetch updated messages
        getAllMessage(conversationId: conversationId);
      } else {
        debugPrint('⚠️ Invalid message format received.');
      }

      // T ODO: Implement UI update or notification logic here
    });
  }

  void receivedCall() async {
    debugPrint('🔄 Socket initialized, now listening for call...');
    if (!SocketApi.isConnected()) {
      debugPrint('❌ Cannot listen for messages. Socket is not connected.');
      return;
    }

    debugPrint('✅ Listening for new call...');

    final userID = await SharePrefsHelper.getString(AppConstants.userId);

    // Ensure we don't add duplicate listeners
    SocketApi.listen('incomingCall', (dynamic data) {
      debugPrint('📩 New Message Received: $data');

      if (data is Map<String, dynamic>) {
        final roomId = data['roomId'] ?? '';
        // final callerId = data['callerId'] ?? '';
        final callLogId = data['callLogId'] ?? '';

        // Show popup
        showIncomingCallPopup(
          // যেহেতু আপনি GetX ব্যবহার করছেন
          roomId: roomId,
          callerId: userID,
          callLogId: callLogId,
        );
      } else {
        debugPrint('⚠️ Invalid message format received.');
      }

      // T ODO: Implement UI update or notification logic here
    });
  }

  @override
  void onInit() {
    getConversation();
    // SocketApi.init().then((_) {
    //   debugPrint('🔄 Socket initialized, now listening for messages...');
    //   receivedNewMessage(); // Start listening after successful connection
    // });

    receivedNewMessage();
    receivedCall();

    super.onInit();
  }
}