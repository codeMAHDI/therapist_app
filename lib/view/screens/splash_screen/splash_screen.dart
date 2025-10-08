// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/helper/shared_prefe/shared_prefe.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_images/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  //final AuthController authController =Get.find<AuthController>();
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        // Get.offAllNamed(AppRoutes.loginScreen);
        isAllreadyLogin();
      });
    });
  }

  Future<void> isAllreadyLogin() async {
    final role = await SharePrefsHelper.getString(AppConstants.role);
    final token = await SharePrefsHelper.getString(AppConstants.bearerToken);

    if (role.isEmpty && token.isEmpty) {
      Get.offAllNamed(AppRoutes.loginScreen);
    } else {
      switch (role) {
        case 'patient':
          Get.offAllNamed(AppRoutes.userHomeScreen);
          break;
        case 'therapist':
          Get.offAllNamed(AppRoutes.therapistHomeScreen);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: CustomImage(
        imageSrc: AppImages.splashScreenImage,
        boxFit: BoxFit.fill,
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        scale: 4,
      ),
    );
  }
}
