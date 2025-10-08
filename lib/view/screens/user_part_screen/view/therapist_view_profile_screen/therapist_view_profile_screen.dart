import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:counta_flutter_app/helper/shared_prefe/shared_prefe.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/authentication/controller/auth_controller.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_chat_screen/model/conversation_model.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/review_screen/controller/review_controller.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/review_screen/review_screen.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/review_screen/submit_review_screen.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/therapist_view_profile_screen/widget/custom_day_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../popular_doctor_screen/model/popular_doctor_model.dart';

class TherapistViewProfileScreen extends StatelessWidget {
  TherapistViewProfileScreen({super.key});
  final PopularDoctorsModel popularDoctorsModel = Get.arguments;
  final authController = Get.find<AuthController>();
  final ReviewController controller = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
    controller.fetchFeedbackSummary(popularDoctorsModel.id ?? "");
    double rating = controller.averageRating.value;
    int count = controller.feedbackCount.value;
    return Scaffold(
      backgroundColor: AppColors.navbarClr,
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Therapist Profile",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CustomNetworkImage(
                  imageUrl: ImageHandler.imagesHandle(
                      popularDoctorsModel.therapist?.profile?.brandLogo ?? ""),
                  //imageUrl:"${ApiUrl.imageUrl}${popularDoctorsModel.therapist?.profile?.brandLogo ?? ""}",
                  height: MediaQuery.sizeOf(context).height / 5,
                  width: MediaQuery.sizeOf(context).width,
                  backgroundColor: AppColors.navbarClr,
                ),
                Positioned(
                  top: 70.h,
                  left: 0.w,
                  right: 0.w,
                  child: /*CustomImage(
                      imageSrc:"${ApiUrl.imageUrl}${popularDoctorsModel.therapist?.profile?.image ?? ""}",
                      height: 180,
                      width: 180,
                    )*/
                      ProfilePicture(
                    
                    imageUrl: ImageHandler.imagesHandle(
                        popularDoctorsModel.therapist?.profile?.image ?? ""),
                    //imageUrl:"${ApiUrl.imageUrl}${popularDoctorsModel.therapist?.profile?.image ?? ""}",
                    // boxShape: BoxShape.circle,
                    //  border: Border.all(color: Colors.white, width: 5),

                    height: 180.h,
                    width: 180.w,
                    borderColor: AppColors.primary,
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              //color: AppColors.navbarClr,
              height: 80.h,
            ),

            ///============ Name ===========
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              width: MediaQuery.sizeOf(context).width,
              //height:MediaQuery.sizeOf(context).height/7 ,
              decoration: BoxDecoration(
                color: AppColors.navbarClr,
                border: Border(
                  bottom: BorderSide(color: AppColors.primary, width: 0.5),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: popularDoctorsModel.therapist?.firstName ?? "",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          right: 10.w,
                        ),
                        CustomText(
                          text: popularDoctorsModel.therapist?.lastName ?? "",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                  CustomText(
                    top: 6.h,
                    text: popularDoctorsModel
                            .therapist?.profile?.speciality?.name ??
                        "",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),

            ///==================== Experience =====================
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CustomText(
                        text: "${popularDoctorsModel
                                .therapist?.profile?.experience}" ??
                            "",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        text: "Experience",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_05,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50.h,
                        width: 1.w,
                        color: AppColors.primary,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        height: 50.h,
                        width: 1.w,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(ReviewScreen(
                          therapistId: popularDoctorsModel.id ?? ""));
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.primary,
                              size: 15,
                            ),
                            SizedBox(width: 5.w),
                            /*  CustomText(
                              text: "${rating.toStringAsFixed(1)} (${count.toString()})",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ), */
                            Obx(() {
                              // Reactive rating & count
                              double rating = controller.averageRating.value;
                              int count = controller.feedbackCount.value;
                              return CustomText(
                                text: "${rating.toStringAsFixed(1)} ($count)",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              );
                            }),
                          ],
                        ),
                        CustomText(
                          text: "Ratings",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black_05,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: AppStrings.appointmentFee,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text:
                        "\$${popularDoctorsModel.therapist?.profile?.chargePerHour?.amount.toString() ?? ""}",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 1.h,
                width: MediaQuery.sizeOf(context).width,
                color: AppColors.primary,
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Availability",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  left: 20.w,
                )),

            ///==================== Availability =====================
            if (popularDoctorsModel
                    .therapist?.profile?.availabilities?.isNotEmpty ??
                false)
              Column(
                children: List.generate(
                    popularDoctorsModel
                            .therapist?.profile?.availabilities?.length ??
                        0, (index) {
                  return CustomDayTime(
                    dayName: popularDoctorsModel
                        .therapist?.profile?.availabilities?[index].dayName,
                    startTime: popularDoctorsModel
                        .therapist?.profile?.availabilities?[index].startTime,
                    endTime: popularDoctorsModel
                        .therapist?.profile?.availabilities?[index].endTime,
                  );
                }),
              ),
            SizedBox(
              height: 25.h,
            ),

            ///==================== Book Appointment Button =====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.requestAppointmentScreen,
                      arguments: popularDoctorsModel);
                },
                title: AppStrings.bookAppointment,
                height: 45.h,
              ),
            ),

            //=========Share Review==========
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 50.0, right: 50.0, bottom: 10.0),
              child: CustomButton(
                fillColor: const Color.fromARGB(255, 64, 201, 94),
                onTap: () {
                  Get.to(() => SubmitReviewScreen(
                        patientId: authController.userProfileModel.value.id ??
                            "", // patient এর ID
                        therapistId:
                            popularDoctorsModel.id ?? "", // therapist এর ID
                      ));
                },
                title: AppStrings.shareReview,
                height: 45.h,
              ),
            ),

            ///==================== About Us =====================
            Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  top: 20.h,
                  text: AppStrings.aboutus,
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  left: 20.w,
                  bottom: 10.h,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomText(
                text: popularDoctorsModel
                        .therapist?.profile?.professionalSummary ??
                    "",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
