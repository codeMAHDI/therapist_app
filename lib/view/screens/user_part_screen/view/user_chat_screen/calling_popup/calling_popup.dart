import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_chat_screen/zego_cloud_calling/calling_page.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/user_chat_screen/user_inbox_screen.dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showIncomingCallPopup({
  required String roomId,
  required String callerId,
  required String callLogId,
}) {
  showDialog(
    context: Get.context!,
    barrierDismissible:
        false, // user back press করে popup dismiss করতে পারবে না
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue.shade100,
                child: Icon(Icons.video_call, size: 40, color: Colors.blue),
              ),
              const SizedBox(height: 16),
              Text(
                "Incoming Video Call",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text("Caller ID: $callerId"),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Decline Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.all(20),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.offAll(() => UserInboxScreen()); // dismiss popup
                      debugPrint("❌ Declined call $callLogId");

                      // TODO: socket.emit("declineCall", {...});
                    },
                    child: Icon(Icons.call_end, color: Colors.white),
                  ),

                  // Accept Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.all(20),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.offAll(() => UserInboxScreen()); // dismiss popup
                      debugPrint("✅ Accepted call $roomId");
                      // Navigate to your call screen
                      Get.to(() => CallingPage(
                            callID: roomId,
                            userName: 'User',
                            userID: callerId,
                          ));
                    },
                    child: Icon(Icons.call, color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
