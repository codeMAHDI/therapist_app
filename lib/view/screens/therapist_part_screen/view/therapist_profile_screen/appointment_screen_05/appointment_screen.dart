import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/helper/shared_prefe/shared_prefe.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/controller/therapist_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({super.key});
  final TherapistProfileController therapistPC = Get.find<TherapistProfileController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Appointment",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Step -05",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  bottom: 6.h,
                ),
                SizedBox(
                  height: 200.h,
                ),
                CustomFormCard(
                    title: "Set Your Appointment Free (per hour)",
                    hintText: AppStrings.typeHere,
                    controller: therapistPC.therapistAppointmentFeeController.value,
                    onChanged: (value){
                      SharePrefsHelper.saveString('appointmentFee', value);
                    },
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return AppStrings.typeYourDate;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Get.toNamed(AppRoutes.availabilityScreen);
                    }
                   therapistPC.dataPassButton();
                  },
                  title: AppStrings.next,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
