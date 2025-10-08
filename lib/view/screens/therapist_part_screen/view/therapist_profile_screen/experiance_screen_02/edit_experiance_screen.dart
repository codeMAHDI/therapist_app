import 'package:counta_flutter_app/helper/shared_prefe/shared_prefe.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import '../../../controller/therapist_register_controller.dart';
import '../../../model/therapist_register_model.dart';

class EditExperianceScreen extends StatelessWidget {
  EditExperianceScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TherapistRegisterModel therapistRegisterModel = Get.arguments;
  final therapistRegisterController = Get.find<TherapistRegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Edit Experience",
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
                  text: "Step -02",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  bottom: 6.h,
                ),
                SizedBox(
                  height: 200.h,
                ),
                CustomFormCard(
                  title: "Total years of experience",
                  hintText: AppStrings.typeHere,
                  controller:
                      therapistRegisterController.therapistExperience,
                  onChanged: (value) {
                    SharePrefsHelper.saveString("experience", value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.typeYourExperiance;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                therapistRegisterController.editExperienceLoading.value
                    ? CustomLoader()
                    : CustomButton(
                        title: AppStrings.submit,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            therapistRegisterController.editExperience();
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
