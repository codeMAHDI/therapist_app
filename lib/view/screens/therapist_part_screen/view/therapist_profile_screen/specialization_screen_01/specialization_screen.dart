import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../../utils/app_strings/app_strings.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../../components/custom_textfield_popup/custom_textfield_popup.dart';
import '../../../../../components/general_error.dart';
import '../../../controller/therapist_profile_controller.dart';
import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';


class SpecializationScreen extends StatelessWidget {
  SpecializationScreen({super.key});

  final TherapistProfileController therapistPC =
      Get.find<TherapistProfileController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // final SpecialityController specialityController = Get.find<SpecialityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Specialization",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Step -01",
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  bottom: 10.h,
                ),

                CustomText(
                  text: "Specialization",
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                  bottom: 8.h,
                ),

                // Updated CustomTextfield WithPopup to show dynamic data
                Obx(
                  () {
                    switch (therapistPC.categoryListLoader.value) {
                      case Status.loading:
                        return Center(child: CustomLoader());
                      case Status.internetError:
                        return GeneralErrorScreen(
                            onTap: () => therapistPC.getCategoryList());
                      case Status.error:
                        return GeneralErrorScreen(
                            onTap: () => therapistPC.getCategoryList());
                      case Status.completed:
                        debugPrint(
                            "Dropdown Items: ${therapistPC.categoryList.map((e) => e.name).toList()}");
                        return CustomTextfieldWithPopup(
                          items: therapistPC.catagoryName,
                          fillColor: AppColors.black,
                          popupColor: AppColors.black,
                          hintText: AppStrings.selectSpecialization,
                          controller: therapistPC
                              .therapistSpecializationController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.selectSpecialization;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            debugPrint(
                                '=======  Value  ============================================== $value');
                            for (int i = 0;
                                i < therapistPC.categoryList.length;
                                i++) {
                              if (therapistPC.categoryList[i].name == value) {
                                therapistPC.therapistSpecializationController2
                                        .value.text =
                                    therapistPC.categoryList[i].id ?? '';
                                therapistPC.therapistSpecializationController
                                    .refresh();
                                break;
                              }
                            }

                            debugPrint(
                                '=======================  Value  ============================================== ${therapistPC.therapistSpecializationController2.value.text}');
                          },
                        );
                    }
                  },
                ),

                SizedBox(height: 12.h),

                CustomFormCard(
                  title: "Sub Specialization",
                  hintText: AppStrings.typeHere,
                  controller:
                      therapistPC.therapistSubSpecializationController.value,
                  onChanged: (value) {
                    SharePrefsHelper.saveString('subSpecialization', value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.typeYourSubSpecialization;
                    }
                    return null;
                  },
                ),

                CustomFormCard(
                  title: "Professional Summary",
                  hintText: AppStrings.typeHere,
                  maxLine: 5,
                  controller: therapistPC.therapistProSummeryController.value,
                  onChanged: (value) {
                    SharePrefsHelper.saveString('proSummery', value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.typeProfessionalSummary;
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20.h),

                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Get.toNamed(AppRoutes.experianceScreen);
                    }
                    therapistPC.dataPassButton();

                    debugPrint(
                        '==========================>> Navigating to: ${therapistPC.therapistSpecializationController.value.text}');
                  },
                  title: AppStrings.next,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
