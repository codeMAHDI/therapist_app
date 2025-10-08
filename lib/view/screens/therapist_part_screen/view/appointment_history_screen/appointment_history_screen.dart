import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:counta_flutter_app/helper/time_converter/time_converter.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/widget/custom_appoint_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/general_error.dart';
import '../../controller/therapist_home_controller.dart';

class AppointmentHistoryScreen extends StatelessWidget {
  AppointmentHistoryScreen({super.key}) {
    therapistHomeController.getWallet();
  }
  final therapistHomeController = Get.find<TherapistHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: AppStrings.appointmentHistory,
      ),
      body: Obx(
        () {
          switch (therapistHomeController.walletLoader.value) {
            case Status.loading:
              return Center(child: CustomLoader()); // Show loader while loading
            case Status.internetError:
              return GeneralErrorScreen(
                  onTap: () => therapistHomeController
                      .getWallet()); // Retry if internet error
            case Status.error:
              return GeneralErrorScreen(
                  onTap: () =>
                      therapistHomeController.getWallet()); // Retry on error
            case Status.completed:
              return Column(
                children: [
                  ///============ Calendar =============
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: AppColors.navbarClr,
                      border: Border.symmetric(
                          horizontal:
                              BorderSide(color: AppColors.primary, width: 0.5)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: DateConverter.estimatedDate(
                                  therapistHomeController
                                      .yourWalletModel.value.createdAt!),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primary,
                              right: 10.w,
                            ),
                            Icon(
                              Icons.calendar_month,
                              color: AppColors.primary,
                              size: 16,
                            ),
                          ],
                        ),
                        CustomText(
                          text: "Total appointment :  ${therapistHomeController.appointmentList.length}",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          top: 10.h,
                          bottom: 6.h,
                        ),
                        CustomText(
                          text: "Total Balance :  \$${therapistHomeController.yourWalletModel.value.balance!.amount.toString()}",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          therapistHomeController.appointmentList.isNotEmpty
                              ? Column(
                            children: List.generate(  therapistHomeController.appointmentList.length, (index) {
                              return CustomAppointRow(
                                image: ImageHandler.imagesHandle(therapistHomeController.appointmentList[index].patient?.profile.image ?? ""),
                                //image: "${ApiUrl.imageUrl}${therapistHomeController.appointmentList[index].patient?.profile.image ?? ""}",
                                firstName: therapistHomeController
                                    .appointmentList[index]
                                    .patient
                                    ?.firstName,
                                lastName: therapistHomeController
                                    .appointmentList[index].patient?.lastName,
                                time: therapistHomeController
                                    .appointmentList[index].slot,
                                day: therapistHomeController
                                    .appointmentList[index].date
                                    .toString()
                                    .split(" ")
                                    .first,
                                //price:  "\$${therapistHomeController.appointmentList[index].feeInfo?.mainFee.toString()}",

                              );
                            }),
                          )
                              : Center(
                              child: CustomText(
                                text: "No Appointment History",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ))
                        ],
                      ))
                ],
              );
          }
        },
      ),
    );
  }
}
