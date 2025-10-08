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
import 'package:get/get_core/src/get_main.dart';
import '../../../../../helper/images_handle/image_handle.dart';
import '../therapist_bookings_screen/apointment_model/appointment_model.dart';
import '../therapist_chat_screen/controller/chat_controller.dart';
class PatientsCompleteScreen extends StatelessWidget {
  const PatientsCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PendingModelByTherapist appriontment = Get.arguments;
    final therapistChatController = Get.find<TherapistChatController>();
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: AppStrings.patientDetails,
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.navbarClr,
              border: Border.symmetric(horizontal: BorderSide(color: AppColors.primary,width: 0.5)),
            ),child: Row(
            children: [
              CustomNetworkImage(
                imageUrl: ImageHandler.imagesHandle(appriontment.patient?.profile.image ?? ""),
                height: 65.h, width: 65.w, boxShape: BoxShape.circle,),
              SizedBox(width: 10.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "Dr. Mehedi",fontSize: 20.sp,fontWeight: FontWeight.w500,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "25 years old",fontSize: 15.sp,fontWeight: FontWeight.w300,right: 80.w,),
                      Align(alignment: Alignment.centerRight,
                          child: CustomText(text: "Male",fontSize: 15.sp,fontWeight: FontWeight.w300,)),
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
                    CustomText(text: "Appointment Date", fontSize: 16,fontWeight: FontWeight.w300,left: 8.w,),
                    CustomText(text: "15 June", fontSize: 16,fontWeight: FontWeight.w300,left: 8.w,),
                  ],
                ),
                SizedBox(height: 20.h,),
                CustomFormCard(
                    title: "Reason for Appointment",
                    hintText: "Chronic pain issue- back pain",
                    readOnly: true,
                    controller: TextEditingController()),
                CustomFormCard(
                    title: "Describe Your Problem",
                    hintText: "I've been experiencing chronic back pain for the past six months. The pain started gradually without any clear injury/incident. It began as a dull ache in my lower back.",
                    readOnly: true,
                    maxLine: 5,
                    controller: TextEditingController()),
                SizedBox(height: 80.h,),
                Row(
                  children: [
                    Flexible(
                        child: CustomButton(
                          onTap: (){
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
                   /* Flexible(
                        child: CustomButton(
                          onTap: (){},
                          title: "Call",
                          height: 48.h,
                        )),*/
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
