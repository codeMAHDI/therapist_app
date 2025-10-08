import 'package:counta_flutter_app/helper/shared_prefe/shared_prefe.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/therapist_register_controller.dart';
import '../../../model/therapist_register_model.dart';

class EditAppointmentScreen extends StatelessWidget {
  EditAppointmentScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TherapistRegisterModel therapistRegisterModel = Get.arguments;
  final therapistRegisterController = Get.find<TherapistRegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Edit Appointment",
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
                SizedBox(
                  height: 200.h,
                ),
                CustomFormCard(
                  title: "Set Your Appointment Fee (per hour)",
                  hintText: AppStrings.typeHere,
                  controller:
                      therapistRegisterController.therapistAppointmentFee,
                  onChanged: (value) {
                    SharePrefsHelper.saveString('appointmentFee', value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.typeYourAppoinmentFee;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                therapistRegisterController.editAppointmentLoading.value
                    ? CustomLoader()
                    : CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            therapistRegisterController.editAppointment();
                          }
                        },
                        title: AppStrings.submit,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
