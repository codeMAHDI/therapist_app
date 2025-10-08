import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/components/general_error.dart';
import 'package:counta_flutter_app/view/screens/authentication/controller/auth_controller.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/popular_doctor_screen/controller/popular_doctor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../popular_doctor_screen/model/popular_doctor_model.dart';

class UserPatientDetailsScreen extends StatelessWidget {
  UserPatientDetailsScreen({super.key});

  final PopularDoctorController popularDoctorController =
      Get.find<PopularDoctorController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();

  final PopularDoctorsModel popularDoctorsModel =
      Get.arguments[2] ?? PopularDoctorsModel();
  final String selectedSlot = Get.arguments[0] ?? '';
  final DateTime selectedDate = Get.arguments[1] ?? DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: AppStrings.patientDetails,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Obx(() {
            switch (authController.rxRequestStatus.value) {
              case Status.loading:
                return Center(
                  child: CustomLoader(),
                );
              case Status.internetError:
                return Center(
                  child: CustomLoader(),
                );
              case Status.error:
                return GeneralErrorScreen(
                  onTap: () => authController.getUserProfile(),
                );
              case Status.completed:
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: AppColors.navbarClr,
                        border: Border.symmetric(
                            horizontal: BorderSide(
                                color: AppColors.primary, width: 0.5)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomNetworkImage(
                                imageUrl: authController.userProfileModel.value.profile?.image ??"",
                                height: 65.h,
                                width: 65.w,
                                boxShape: BoxShape.circle,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                        text: authController.userProfileModel
                                                .value.firstName ??
                                            "",
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                        right: 6.w,
                                      ),
                                      CustomText(
                                        text: authController.userProfileModel
                                                .value.lastName ??
                                            "",
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  CustomText(
                                    text: calculateAge(
                                      authController.userProfileModel.value
                                              .profile?.dateOfBirth
                                              .toString() ??
                                          "",
                                    ),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w300,
                                    // right: 80.w,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CustomText(
                            text: authController
                                    .userProfileModel.value.profile?.gender ??
                                "",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomFormCard(
                            title: "Reason for Appointment",
                            hintText: "Chronic pain issue- back pain",
                            controller:
                                popularDoctorController.reasonController.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.fieldCantBeEmpty;
                              }
                              return null;
                            },
                          ),
                          CustomFormCard(
                            title: "Describe Your Problem",
                            hintText: "I've been experiencing chronic.",
                            isMultiLine: true,
                            controller: popularDoctorController
                                .descriptionController.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.fieldCantBeEmpty;
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 80.h,
                          ),
                          popularDoctorController.patientDetailsLoading.value
                              ? CustomLoader()
                              : CustomButton(
                                  onTap: () {
                                    if (selectedSlot.isNotEmpty) {
                                      // Calculate the cost
                                      popularDoctorController.calculateCost(
                                        selectedSlot,
                                        popularDoctorsModel.therapist?.profile
                                                ?.chargePerHour?.amount
                                                ?.toDouble() ??
                                            0.0,
                                      );
                                      // Check if the selected slot is already booked (error handling)
                                      if (popularDoctorController
                                          .checkWalletBalance()) {
                                        popularDoctorController.postAppointment(
                                          therapistID: popularDoctorsModel
                                                  .therapist?.id ??
                                              "",
                                          date: selectedDate.toString(),
                                          slot: selectedSlot,
                                        );
                                      } else {
                                        Get.toNamed(AppRoutes.userPaymentView,
                                            arguments: popularDoctorsModel);
                                        Get.snackbar(
                                          'Insufficient Balance',
                                          'Please add money to your wallet.',
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                      }
                                    } else {
                                      Get.snackbar("No Slot Selected",
                                          "Please select a slot before continuing.");
                                    }
                                  },
                                  title: AppStrings.continueText,
                                ),
                        ],
                      ),
                    )
                  ],
                );
            }
          }),
        ),
      ),
    );
  }

  String calculateAge(String dateOfBirth) {
    // Parse the dateOfBirth to a DateTime object
    DateTime birthDate = DateTime.parse(dateOfBirth);
    DateTime today = DateTime.now();

    // Calculate the difference between today and birthDate
    int age = today.year - birthDate.year;

    // If the birth date hasn't occurred yet this year, subtract 1 from the age
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    // Return the formatted age
    return "$age years old";
  }
}
