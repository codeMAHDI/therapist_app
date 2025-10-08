// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_images/app_images.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../helper/images_handle/image_handle.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../controller/therapist_register_controller.dart';
import '../../../model/therapist_register_model.dart';

class TherapistEditProfileScreen extends StatefulWidget {
  const TherapistEditProfileScreen({super.key});

  @override
  State<TherapistEditProfileScreen> createState() => _TherapistEditProfileScreenState();
}

class _TherapistEditProfileScreenState extends State<TherapistEditProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final therapistRegisterController = Get.find<TherapistRegisterController>();
  late final TherapistRegisterModel therapistRegisterModel;

  @override
  void initState() {
    super.initState();
    therapistRegisterModel = Get.arguments as TherapistRegisterModel;

    // Initialize controllers with data from arguments
    therapistRegisterController.therapistFirstName.text = therapistRegisterModel.firstName ?? '';
    therapistRegisterController.therapistLastName.text = therapistRegisterModel.lastName ?? '';
    therapistRegisterController.therapistPhoneNumber.text = therapistRegisterModel.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            scale: 4,
            image: AssetImage(AppImages.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomRoyelAppbar(
                titleName: "Edit Profile",
                leftIcon: true,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                      child: Column(
                        children: [
                          // profile image
                          Center(
                            child: SizedBox(
                              width: 120.w,
                              height: 120.h,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Obx(() {
                                    final profileModel = therapistRegisterController.therapistRegisterModel.value.profile;
                                    if (therapistRegisterController.therapistProfileImageFile.value != null) {
                                      return Container(
                                        width: 120.w,
                                        height: 120.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(width: 3, color: AppColors.primary),
                                          image: DecorationImage(
                                            image: FileImage(File(therapistRegisterController.therapistProfileImageFile.value!.path)),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    } else if (profileModel?.image != null && profileModel!.image!.isNotEmpty) {
                                      return CustomNetworkImage(
                                        imageUrl: ImageHandler.imagesHandle(profileModel.image!),
                                        height: 120.h,
                                        width: 120.w,
                                        boxShape: BoxShape.circle,
                                      );
                                    } else {
                                      return CustomImage(imageSrc: AppImages.imgPng, height: 120.h, width: 120.w);
                                    }
                                  }),
                                  Positioned(
                                    bottom: 5,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        therapistRegisterController.getProfileFileImage();
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.camera_alt, size: 18, color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          // First Name
                          CustomFormCard(
                            prefixIcon: Icon(Icons.person, color: AppColors.primary),
                            title: AppStrings.firstName,
                            hintText: "type here..",
                            // CORRECTED: .value removed
                            controller: therapistRegisterController.therapistFirstName,
                            validator: (value) {
                              if (value == null || value.isEmpty) return AppStrings.enterYourName;
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          // Last Name
                          CustomFormCard(
                            prefixIcon: Icon(Icons.person, color: AppColors.primary),
                            title: AppStrings.lastName,
                            hintText: "type here..",
                            // CORRECTED: .value removed
                            controller: therapistRegisterController.therapistLastName,
                            validator: (value) {
                              if (value == null || value.isEmpty) return AppStrings.enterYourName;
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          // Contact
                          CustomFormCard(
                            prefixIcon: Icon(Icons.contact_phone_outlined, color: AppColors.primary),
                            title: AppStrings.contact,
                            hintText: AppStrings.typeHere,
                            // CORRECTED: .value removed
                            controller: therapistRegisterController.therapistPhoneNumber,
                            validator: (value) {
                              if (value == null || value.isEmpty) return AppStrings.enterYourPhone;
                              return null;
                            },
                          ),
                          SizedBox(height: 40.h),
                          // Submit Button
                          Obx(() => therapistRegisterController.therapistProfileUpdateLoading.value
                              ? CustomLoader()
                              : CustomButton(
                            title: AppStrings.submit,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                therapistRegisterController.updateTherapistProfile();
                              }
                            },
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






// // ignore_for_file: prefer_const_constructors
// import 'dart:io';

// import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
// import 'package:counta_flutter_app/utils/app_images/app_images.dart';
// import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
// import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
// import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
// import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
// import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../../../../helper/shared_prefe/shared_prefe.dart';
// import '../../../controller/therapist_profile_controller.dart';
// import '../../../controller/therapist_register_controller.dart';
// import '../../../model/therapist_register_model.dart';

// class TherapistEditProfileScreen extends StatelessWidget {
//   TherapistEditProfileScreen({super.key});
//   final therapistPC = Get.find<TherapistProfileController>();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final TherapistRegisterModel therapistRegisterModel = Get.arguments;
//   final therapistRegisterController = Get.find<TherapistRegisterController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       height: MediaQuery.sizeOf(context).height,
//       width: MediaQuery.sizeOf(context).width,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//             scale: 4,
//             image: AssetImage(
//               AppImages.backgroundImage,
//             ),
//             fit: BoxFit.cover),
//       ),
//       child: Form(
//         key: formKey,
//         child: Obx(() {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomRoyelAppbar(
//                 titleName: "Edit Profile",
//                 leftIcon: true,
//               ),
//               Expanded(
//                 child: ListView(
//                   padding: EdgeInsets.zero,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                           left: 20.h, right: 20.h, bottom: 50.h),
//                       child: Column(
//                         children: [
//                           /// profile image======
//                           Center(
//                             child: Container(
//                               width: 120,
//                               height: 120,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(70),
//                                 border: Border.all(
//                                     width: 3, color: AppColors.primary),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     spreadRadius: 2,
//                                     blurRadius: 10,
//                                     color: AppColors.white.withOpacity(0.1),
//                                   ),
//                                 ],
//                               ),
//                               child: Stack(
//                                 fit: StackFit.loose,
//                                 clipBehavior: Clip.none,
//                                 children: [
//                                   Obx(() {
//                                     final profileImage =
//                                         therapistRegisterController
//                                             .therapistProfileImage.value;

//                                     // ignore: unused_local_variable

//                                     final profileModel =
//                                         therapistRegisterController
//                                             .therapistRegisterModel
//                                             .value
//                                             .profile;


//                                     return Container(
//                                       width: 120,
//                                       height: 120,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         image: DecorationImage(
//                                           image: FileImage(File(profileImage)),
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                                   Positioned(
//                                     bottom: 5,
//                                     right: 0,
//                                     child: GestureDetector(
//                                       onTap: () async {
//                                         therapistRegisterController
//                                             .getFileImage();
//                                       },
//                                       child: Container(
//                                         height: 30,
//                                         width: 30,
//                                         decoration: BoxDecoration(
//                                           color: AppColors.primary,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: const Icon(
//                                           Icons.camera_alt,
//                                           size: 18,
//                                           color: AppColors.white,

//                                     if (profileImage.isNotEmpty) {
//                                       return Container(
//                                         width: 120,
//                                         height: 120,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           image: DecorationImage(
//                                             image:
//                                                 FileImage(File(profileImage)),
//                                             fit: BoxFit.fill,
//                                           ),

//                                         ),
//                                       );
//                                     } else if (profileModel != null &&
//                                         profileModel.image != null &&
//                                         profileModel.image!.isNotEmpty) {
//                                       return CustomNetworkImage(
//                                         imageUrl:
//                                             '${ApiUrl.imageUrl}${profileModel.image}',
//                                         height: 120.h,
//                                         width: 120.w,
//                                         boxShape: BoxShape.circle,
//                                       );
//                                     } else {
//                                       return CustomNetworkImage(
//                                         imageUrl: AppConstants.profileImage,
//                                         height: 120.h,
//                                         width: 120.w,
//                                         boxShape: BoxShape.circle,
//                                       );
//                                     }
//                                   }),
//                                   Positioned(
//                                     bottom: 5,
//                                     right: 0,
//                                     child: GestureDetector(
//                                       onTap: () async {
//                                         therapistRegisterController
//                                             .getFileImage();
//                                       },
//                                       child: Container(
//                                         height: 30,
//                                         width: 30,
//                                         decoration: BoxDecoration(
//                                           color: AppColors.primary,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: const Icon(
//                                           Icons.camera_alt,
//                                           size: 18,
//                                           color: AppColors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                           CustomFormCard(
//                             prefixIcon: Icon(
//                               Icons.person,
//                               color: AppColors.primary,
//                             ),
//                             title: AppStrings.firstName,
//                             hintText: "type here..",
//                             controller: therapistRegisterController
//                                 .therapistFirstName.value,
//                             onChanged: (value) {
//                               SharePrefsHelper.saveString('firstName', value);
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return AppStrings.enterYourName;
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(
//                             width: 10.w,
//                           ),

//                           ///============ Last Name ===========
//                           CustomFormCard(
//                             prefixIcon: Icon(
//                               Icons.person,
//                               color: AppColors.primary,
//                             ),
//                             title: AppStrings.lastName,
//                             hintText: "type here..",
//                             controller: therapistRegisterController
//                                 .therapistLastName.value,
//                             onChanged: (value) {
//                               SharePrefsHelper.saveString('lastName', value);
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return AppStrings.enterYourName;
//                               }
//                               return null;
//                             },
//                           ),

//                           ///============ Contact ===========
//                           CustomFormCard(
//                             prefixIcon: Icon(
//                               Icons.contact_phone_outlined,
//                               color: AppColors.primary,
//                             ),
//                             title: AppStrings.contact,
//                             hintText: AppStrings.typeHere,
//                             controller: therapistRegisterController
//                                 .therapistPhoneNumber.value,
//                             onChanged: (value) {
//                               SharePrefsHelper.saveString('phoneNo', value);
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return AppStrings.enterYourPhone;
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                           ),

//                           ///============ Submit ===========
//                           therapistRegisterController
//                                   .therapistProfileUpdateLoading.value
//                               ? CustomLoader()
//                               : CustomButton(
//                                   title: AppStrings.submit,
//                                   onTap: () {
//                                     if (formKey.currentState!.validate()) {
//                                       therapistRegisterController
//                                           .updateTherapistProfile();
//                                       // Get.toNamed(AppRoutes.profileViewScreen);
//                                     }
//                                   },
//                                 ),
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           );
//         }),
//       ),
//     ));
//   }
// }
