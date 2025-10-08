import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/helper/shared_prefe/shared_prefe.dart';
import 'package:counta_flutter_app/service/api_check.dart';
import 'package:counta_flutter_app/service/api_client.dart';
import 'package:counta_flutter_app/service/api_url.dart';
import 'package:counta_flutter_app/service/socket_service.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_chat_screen/model/conversation_model.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_chat_screen/model/meesage_model.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_chat_screen/zego_cloud_calling/calling_page.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_bookings_screen/apointment_model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TherapistChatController extends GetxController {
//========================================== get Conversation List ================================

  RxString userId = ''.obs;
  final RxMap<String, String> patientImageByUserId = <String, String>{}.obs;
  final RxMap<String, String> patientImageByAppointmentId = <String, String>{}.obs;
  RxList<ConvarsationModel> filteredConversations = <ConvarsationModel>[].obs;

//======================================== Start Message First time ==============================

  void checkCreateConversation({required String appointmentID}) async {
    for (int i = 0; i < conversationList.length; i++) {
      if (conversationList[i].appointment == appointmentID) {
        return Get.toNamed(AppRoutes.therapistMeesageScreen,
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
  var therapistImageByAppointmentId = <String, String>{}.obs;
  var therapistImageByUserId = <String, String>{}.obs;

  Future<void> getConversation() async {
    final userID = await SharePrefsHelper.getString(AppConstants.userId);

    userId.value = userID;
    refresh();

    debugPrint('''=======Method Call ==============>$userID''');

    final response =
    await ApiClient.getData(ApiUrl.getConversationByUserid(userID: userID));

    if (response.statusCode == 200 || response.statusCode == 201) {
      conversationList.value = List<ConvarsationModel>.from(
          response.body['data'].map((x) => ConvarsationModel.fromJson(x)));

      getConversationStatus.value = Status.completed;
      _prefetchPatientImages();
      _fetchPatientImagesFromBookings();
    } else {
      getConversationStatus.value = Status.error;
      ApiChecker.checkApi(response);
    }
  }


  //=========================================== Filter Conversation ================================
 ///================ Filter Conversations =================
void filterConversations(String query) {
  if (query.isEmpty) {
    filteredConversations.value = List.from(conversationList);
  } else {
    filteredConversations.value = conversationList.where((c) {
      final patientName = c.patient?.name?.toLowerCase() ?? '';
      final lastMsg = c.lastMessage?.id?.content?.toLowerCase() ?? '';
      final q = query.toLowerCase();
      return patientName.contains(q) || lastMsg.contains(q);
    }).toList();
  }
  refresh();
}
  /// Call this after fetching conversations to initialize filtered list
  void initializeFilteredList() {
    filteredConversations.value = List.from(conversationList);
  }

  //=========================================== Patient Image Fetching Methods ================================

  Future<void> _prefetchPatientImages() async {
    try {
      // Get patient images directly from conversation data
      for (final conversation in conversationList) {
        final patientUserId = conversation.patient?.patientUserId?.id;
        final appointmentId = conversation.appointment;
        final imagePath = conversation.patient?.profileImage;

        if (patientUserId != null && imagePath != null && imagePath.isNotEmpty) {
          patientImageByUserId[patientUserId] = imagePath;
        }

        if (appointmentId != null && imagePath != null && imagePath.isNotEmpty) {
          patientImageByAppointmentId[appointmentId] = imagePath;
        }
      }

      // Also fetch patient images by patient ID from API
      await _fetchPatientImagesByUserId();

      refresh();
    } catch (_) {}
  }

  Future<void> _fetchPatientImagesByUserId() async {
    try {
      final Set<String> patientUserIds = conversationList
          .map((c) => c.patient?.patientUserId?.id)
          .whereType<String>()
          .toSet();

      final List<String> idsToFetch = patientUserIds
          .where((id) => !(patientImageByUserId.containsKey(id)))
          .toList();

      if (idsToFetch.isEmpty) return;

      await Future.wait(idsToFetch.map((id) async {
        try {
          final res = await ApiClient.getData(ApiUrl.getProfile(userId: id));
          if (res.statusCode == 200 || res.statusCode == 201) {
            final data = res.body is Map<String, dynamic>
                ? res.body
                : (res.body['data'] ?? res.body);

            // Try to parse as PendingModelByTherapist.Patient
            if (data is Map<String, dynamic> && data['profile'] != null) {
              final profile = data['profile'];
              final imagePath = profile['image'];
              if (imagePath != null && imagePath.isNotEmpty) {
                patientImageByUserId[id] = imagePath;
              }
            }
          }
        } catch (_) {}
      }));

      refresh();
    } catch (_) {}
  }

  Future<void> _fetchPatientImagesFromBookings() async {
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
              userId: currentUserId, role: 'therapist', status: status));
          if (res.statusCode == 200 || res.statusCode == 201) {
            final list = (res.body['data'] as List<dynamic>?) ?? [];
            for (final item in list) {
              final model = PendingModelByTherapist.fromJson(
                  item is Map<String, dynamic> ? item : (item as dynamic));
              final appointmentId = model.id ?? '';
              final imagePath = model.patient?.profile.image;
              if (appointmentId.isNotEmpty && imagePath != null && imagePath.isNotEmpty) {
                patientImageByAppointmentId[appointmentId] = imagePath;
              }

              final patientUserId = model.patient?.id;
              if (patientUserId != null && patientUserId.isNotEmpty && imagePath != null && imagePath.isNotEmpty) {
                patientImageByUserId[patientUserId] = imagePath;
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
    var body = {
      "conversation": conversationId,
      "sender": senderId,
      "senderRole": 'therapist',
      "type": 'text',
      "content": messageController.value.text,
    };

    var body2 = {
      "conversation": conversationId,
      "sender": senderId,
      "senderRole": 'therapist',
      "type": 'attachment',
      "content": messageController.value.text,
    };

    RxList<MultipartBody> multipartBody = <MultipartBody>[].obs;

    if (selectedImages.isNotEmpty) {
      multipartBody.value = selectedImages
          .map((image) => MultipartBody('attachment', File(image.path)))
          .toList();
      refresh();
    }

    // ignore: invalid_use_of_protected_member
    var response = selectedImages.value.isEmpty
        ? await ApiClient.postData(ApiUrl.sendMessage, jsonEncode(body))
        : await ApiClient.postMultipartData(
      ApiUrl.sendMessage, body2,
      // ignore: invalid_use_of_protected_member
      multipartBody: multipartBody.value,
    );

    //  [
    //     MultipartBody('attachment', File(selectedImage.value!.path))
    //   ]);
    if (response.statusCode == 200 || response.statusCode == 201) {
      messageController.value.clear();
      getAllMessage(conversationId: conversationId);
      getConversation();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  //========================================= Get Message in real time ================================

  // void receivedNewMessage() {
  //   if (!SocketApi.isConnected()) {
  //     debugPrint('❌ Cannot listen for messages. Socket is not connected.');
  //     return;
  //   }

  //   debugPrint('✅ Listening for new messages...');

  //   // Listen for new messages
  //   SocketApi.listen('newMessage', (dynamic data) {
  //     debugPrint('📩 New Message Received: $data');

  //     if (data is Map<String, dynamic> && data.containsKey('conversation')) {
  //       String conversationId = data['conversation'];

  //       // Fetch updated messages
  //       getAllMessage(conversationId: conversationId);
  //     } else {
  //       debugPrint('⚠️ Invalid message format received.');
  //     }
  //   });
  // }

  void receivedNewMessage() {
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

//    sendCall()async{

//     var data = {
//       "conversation": conversationId.value,
//       "sender": senderId.value,
//       "senderRole": 'therapist',
//       "type": 'call',
//       "content": messageController.value.text,
//     };

//  SocketApi.sendEvent('acceptCall', data)

//    }

  Future<void> startVideoCall({required String conversationId, required String name}) async {
    final userID = await SharePrefsHelper.getString(AppConstants.userId);

    var data = {
      "conversationId": conversationId,
      "role": "therapist",
      "userId": userID,
      "callType": "video"
    };

    var response =
    await ApiClient.postData(ApiUrl.startVideoCall, jsonEncode(data));

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint('🎉 Video call started successfully $conversationId');
      Get.to(() => CallingPage(
        callID: conversationId,
        userName: name,
        userID: userID,
      ));
    } else {
      ApiChecker.checkApi(response);
    }
  }

  @override
  void onInit() {
    getConversation();
    // SocketApi.init().then((_) {
    //   debugPrint('🔄 Socket initialized, now listening for messages...');
    //   receivedNewMessage(); // Start listening after successful connection
    // });

    receivedNewMessage();

    super.onInit();
  }
}
 
 