import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'constants.dart';

class CallingPage extends StatelessWidget {
  const CallingPage(
      {super.key,
      required this.callID,
      required this.userName,
      required this.userID});
  final String callID;
  final String userName;
  final String userID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: AppInfo
          .appId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: AppInfo
          .appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userID,
      userName: userName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
