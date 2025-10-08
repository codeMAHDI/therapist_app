import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomingCallScreen extends StatelessWidget {
  final String callerName;
  final String callerImage;

  const IncomingCallScreen({super.key, required this.callerName, required this.callerImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: Stack(
        children: [
          // Caller Image
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(callerImage),
              ),
            ),
          ),

          // Caller Name
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  callerName,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Incoming Call...",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Accept & Reject Buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Reject Button
                  FloatingActionButton(
                    onPressed: () {
                      Get.back(); // Call Reject করলে Screen বন্ধ হবে
                    },
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.call_end, color: Colors.white),
                  ),
                  // Accept Button
                  FloatingActionButton(
                    onPressed: () {
                      Get.snackbar("Call Accepted", "Connecting...");
                      Get.toNamed(AppRoutes.callingPage);
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.call, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}