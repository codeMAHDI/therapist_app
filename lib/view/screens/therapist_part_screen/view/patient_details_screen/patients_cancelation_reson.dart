

import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../helper/time_converter/time_converter.dart';
import '../../controller/therapist_home_controller.dart';
import '../therapist_bookings_screen/apointment_model/appointment_model.dart';
import '../therapist_chat_screen/controller/chat_controller.dart';

class PatientsCancelationReson extends StatelessWidget {
  PatientsCancelationReson({super.key});
  final PendingModelByTherapist appriontment = Get.arguments;
  final TherapistHomeController therapistHomeController =
      Get.find<TherapistHomeController>();
  final therapistChatController = Get.find<TherapistChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: AppStrings.patientDetails,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.navbarClr,
                border: Border.symmetric(
                    horizontal:
                        BorderSide(color: AppColors.primary, width: 0.5)),
              ),
              child: Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: ImageHandler.imagesHandle(appriontment.patient?.profile.image ?? ""),
                    //imageUrl:"${ApiUrl.imageUrl}${appriontment.patient?.profile.image ?? ""}",
                    height: 65.h,
                    width: 65.w,
                    boxShape: BoxShape.circle,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: appriontment.patient?.firstName ?? "",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            right: 6.w,
                          ),
                          CustomText(
                            text: appriontment.patient?.lastName ?? "",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: DateConverter.calculateAge(appriontment
                                    .patient?.profile.dateOfBirth
                                    .toString()
                                    .split(" ")
                                    .first ??
                                ""),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                            right: 80.w,
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: CustomText(
                                text:
                                    appriontment.patient?.profile.gender ?? "",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w300,
                              )),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Appointment Date",
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        left: 8.w,
                      ),
                      CustomText(
                        text: appriontment.date.toString().split(" ").first,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        left: 8.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomFormCard(
                      title: "Reason for Appointment",
                      hintText: appriontment.reason ?? "",
                      readOnly: true,
                      controller: TextEditingController()),
                  CustomFormCard(
                      title: "Describe Your Problem",
                      hintText: appriontment.description ?? "",
                      readOnly: true,
                      maxLine: 5,
                      controller: TextEditingController()),
                  CustomFormCard(
                      title: "Cancelation Reason",
                      hintText: appriontment.cancelReason ?? "",
                      readOnly: true,
                      maxLine: 5,
                      controller: TextEditingController()),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: CustomButton(
                        onTap: () {
                          therapistChatController.checkCreateConversation(
                              appointmentID: appriontment.id ?? "");
                        },
                        title: "Chat",
                        height: 48.h,
                        isBorder: true,
                        textColor: AppColors.primary,
                        borderWidth: .8,
                        fontSize: 14.sp,
                        fillColor: AppColors.navbarClr,
                      )),
                      SizedBox(
                        width: 8.w,
                      ),
                    /*  Flexible(
                          child: CustomButton(
                        onTap: () {
                          therapistHomeController
                              .acceptedAppointment(appriontment.id ?? "");
                          Get.back();
                        },
                        title: "Call",
                        height: 48.h,
                      )),*/
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
