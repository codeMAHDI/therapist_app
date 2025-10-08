import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/utils/app_icons/app_icons.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:counta_flutter_app/view/components/custom_nav_bar/therapist_navbar.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_show_dialog/custom_show_dialog.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/widget/custom_profile_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/general_error.dart';
import '../../../controller/therapist_register_controller.dart';
import '../../../model/therapist_register_model.dart';

class TherapistProfileScreen extends StatelessWidget {
  TherapistProfileScreen({super.key});

  final therapistRegisterController = Get.find<TherapistRegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(titleName: AppStrings.profile),
      body: Obx(
        () {
          switch (therapistRegisterController.therapistLoading.value) {
            case Status.loading:
              return Center(child: CustomLoader());
            case Status.internetError:
              return GeneralErrorScreen(
                  onTap: () =>
                      therapistRegisterController.getTherapistRegister());
            case Status.error:
              return GeneralErrorScreen(
                  onTap: () =>
                      therapistRegisterController.getTherapistRegister());
            case Status.completed:
              debugPrint(therapistRegisterController
                  .therapistSpecialization.value.text);
              return Column(
                children: [
                  ///=========== Profile Card ===========
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    decoration: BoxDecoration(
                      color: AppColors.navbarClr,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl: ImageHandler.imagesHandle(therapistRegisterController.therapistProfileImage.value),
                              height: 80.h,
                              width: 80.w,
                              boxShape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.primary, width: 1.5.w),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text:
                                      "${therapistRegisterController.therapistFirstName.value.text} ${therapistRegisterController.therapistLastName.value.text}",
                                  fontSize: 16.h,
                                  fontWeight: FontWeight.w500,
                                ),
                                // ====== Specialization ======
                                // This is the NEW code. Change the 'text' property.
                                Obx(() => CustomText(
                                  text: therapistRegisterController.specializationName, // Use the new getter here
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                )),
                                // ====== Appointment fee (per hour) ======
                                CustomText(
                                  text:
                                      "Appointment fee (per hour): ${therapistRegisterController.therapistAppointmentFee.value.text}",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.toNamed(
                                    AppRoutes.therapistProfileAllDataShow,
                                    arguments: TherapistRegisterModel());
                              },
                              icon: CustomImage(
                                imageSrc: AppIcons.editIcon,
                              ),
                            ),
                            CustomText(
                              text:
                                  "\$ ${therapistRegisterController.therapistAppointmentFee.value.text}",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primary,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  ///============ Profile Menu List ===========
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Column(
                        children: [
                          //========== Payment History ===========
                          CustomProfileList(
                            imageSrc: AppIcons.menu1,
                            text: AppStrings.paymentHistory,
                            onTap: () {
                              Get.toNamed(AppRoutes.drPaymentHistoryScreen);
                            },
                          ),
                          //========== wallet  ===========
                          CustomProfileList(
                            imageSrc: AppIcons.menu2,
                            text: AppStrings.savedCards,
                          ),
                          //========== invoices  ===========
                          CustomProfileList(
                            imageSrc: AppIcons.menu3,
                            text: AppStrings.invoices,
                            onTap: () {
                              Get.toNamed(AppRoutes.therapistInvoicesScreen);
                            },
                          ),

                          //========== manageSubscription  ===========
                          CustomProfileList(
                            imageSrc: AppIcons.menu10,
                            text: AppStrings.manageSubscription,
                            onTap: () {
                              Get.toNamed(AppRoutes.manageSubscriptionScreen);
                            },
                          ),
                          //==========  contactUs ===========
                          CustomProfileList(
                            imageSrc: AppIcons.menu4,
                            text: AppStrings.contactUs,
                            onTap: () {
                              Get.toNamed(AppRoutes.contactUsScreen);
                            },
                          ),
                          //==========  aboutUs ===========
                          CustomProfileList(
                            imageSrc: AppIcons.menu5,
                            text: AppStrings.aboutUs,
                            onTap: () {
                              Get.toNamed(AppRoutes.aboutUsScreen);
                            },
                          ),
                          //==========  terms ===========
                          CustomProfileList(
                            imageSrc: AppIcons.menu6,
                            text: AppStrings.terms,
                            onTap: () {
                              Get.toNamed(AppRoutes.termsConditionScreen);
                            },
                          ),
                          //==========  privacy ===========
                          CustomProfileList(
                            imageSrc: AppIcons.menu6,
                            text: AppStrings.privacy,
                            onTap: () {
                              Get.toNamed(AppRoutes.privacyPolicyScreen);
                            },
                          ),
                          //==========  deleteAccount ===========
                          CustomProfileList(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: AppColors.navbarClr,
                                  insetPadding: EdgeInsets.all(8),
                                  contentPadding: EdgeInsets.all(8),
                                  content: SizedBox(
                                    width: MediaQuery.sizeOf(context).width,
                                    child: CustomShowDialog(
                                      textColor: AppColors.white,
                                      title: "Delete Your Account",
                                      discription:
                                          "Are you sure you want to Delete Account.",
                                      showRowButton: true,
                                      showCloseButton: true,
                                      leftOnTap: () {
                                        Get.toNamed(AppRoutes.loginScreen);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            imageSrc: AppIcons.menu8,
                            text: AppStrings.deleteAccount,
                          ),
                          //==========  logOut ===========
                          CustomProfileList(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: AppColors.navbarClr,
                                  insetPadding: EdgeInsets.all(8),
                                  contentPadding: EdgeInsets.all(8),
                                  content: SizedBox(
                                    width: MediaQuery.sizeOf(context).width,
                                    child: CustomShowDialog(
                                      textColor: AppColors.white,
                                      title: "Logout Account",
                                      discription:
                                          "Are you sure you want to logout Account.",
                                      showRowButton: true,
                                      showCloseButton: true,
                                      leftOnTap: () {
                                        Get.toNamed(AppRoutes.loginScreen);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            imageSrc: AppIcons.menu9,
                            text: AppStrings.logOut,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
          }
          debugPrint(
              therapistRegisterController.therapistSpecialization.value.text);
        },
      ),
      bottomNavigationBar: TherapistNavbar(currentIndex: 3),
    );
  }
}
