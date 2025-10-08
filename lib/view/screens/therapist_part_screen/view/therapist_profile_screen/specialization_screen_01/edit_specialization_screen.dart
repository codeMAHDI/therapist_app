import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/components/custom_textfield_popup/custom_textfield_popup.dart';
import 'package:counta_flutter_app/view/components/general_error.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/controller/therapist_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../user_part_screen/model/category_list_model.dart';
import '../../../controller/therapist_register_controller.dart';
import '../../../model/therapist_register_model.dart';

class EditSpecializationScreen extends StatefulWidget {
  const EditSpecializationScreen({super.key});

  @override
  State<EditSpecializationScreen> createState() => _EditSpecializationScreenState();
}

class _EditSpecializationScreenState extends State<EditSpecializationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final therapistRegisterController = Get.find<TherapistRegisterController>();
  final therapistPC = Get.find<TherapistProfileController>();
  late final TherapistRegisterModel therapistRegisterModel;

  @override
  void initState() {
    super.initState();
    therapistRegisterModel = Get.arguments as TherapistRegisterModel;

    // CORRECTED: .value removed from all controller interactions
    therapistRegisterController.therapistSubSpecialization.text =
        therapistRegisterModel.profile?.subSpecialty ?? '';
    therapistRegisterController.therapistProSummery.text =
        therapistRegisterModel.profile?.professionalSummary ?? '';

    // We can use the initializeForEdit method from the controller now
    therapistRegisterController.initializeForEdit(therapistRegisterModel, therapistPC.categoryList);

    // This logic is now handled inside initializeForEdit
    // therapistRegisterController.therapistSpecialization.clear();
    // therapistRegisterController.therapistSpecializationID.clear();
  }

  @override
  void dispose() {
    therapistRegisterController.resetEditScreenFlags();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Edit Specialization",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Step -01", fontSize: 18.w, fontWeight: FontWeight.w600, color: AppColors.primary, bottom: 10.h),
                CustomText(text: "Specialization", fontSize: 18.w, fontWeight: FontWeight.w600, color: AppColors.white, bottom: 8.h),

                Obx(() {
                  switch (therapistPC.categoryListLoader.value) {
                    case Status.loading:
                      return const Center(child: CustomLoader());
                    case Status.internetError:
                    case Status.error:
                      return GeneralErrorScreen(onTap: () => therapistPC.getCategoryList());
                    case Status.completed:
                    // This now correctly populates the fields when the data is ready
                      therapistRegisterController.initializeForEdit(therapistRegisterModel, therapistPC.categoryList);

                      return CustomTextfieldWithPopup(
                        items: therapistPC.catagoryName,
                        fillColor: AppColors.black,
                        popupColor: AppColors.black,
                        hintText: AppStrings.selectSpecialization,
                        // CORRECTED: .value removed
                        controller: therapistRegisterController.therapistSpecialization,
                        validator: (value) {
                          if (value == null || value.isEmpty || value == 'Not Set' || value == 'Not Found') {
                            return "Please select a specialization";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          final selectedCategory = therapistPC.categoryList.firstWhere(
                                (category) => category.name == value,
                            orElse: () => CategoryListModel(),
                          );
                          // CORRECTED: .value removed
                          therapistRegisterController.therapistSpecialization.text = value;
                          therapistRegisterController.therapistSpecializationID.text = selectedCategory.id ?? '';
                        },
                      );
                  }
                }),
                SizedBox(height: 12.h),

                CustomFormCard(
                  title: "Sub Specialization",
                  hintText: AppStrings.typeHere,
                  // CORRECTED: .value removed
                  controller: therapistRegisterController.therapistSubSpecialization,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Please enter a sub specialization";
                    return null;
                  },
                ),
                CustomFormCard(
                  title: "Professional Summary",
                  hintText: AppStrings.typeHere,
                  maxLine: 5,
                  // CORRECTED: .value removed
                  controller: therapistRegisterController.therapistProSummery,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Please enter a professional summary";
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                Obx(() => therapistRegisterController.editSpecializationLoading.value
                    ? const Center(child: CustomLoader())
                    : CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      therapistRegisterController.editSpecialization();
                    }
                  },
                  title: AppStrings.submit,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
