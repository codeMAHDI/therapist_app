// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:carousel_slider/carousel_slider.dart';
import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/utils/app_icons/app_icons.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:counta_flutter_app/view/components/custom_nav_bar/navbar.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/user_chat_screen/controller/user_chat_controller.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/widget/custom_category_circular.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/widget/custom_doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/general_error.dart';
import '../../../authentication/controller/auth_controller.dart';
import '../../controller/user_home_controller.dart';
import '../popular_doctor_screen/controller/popular_doctor_controller.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final UserHomeController homeController = Get.find<UserHomeController>();

  final popularDoctorController = Get.find<PopularDoctorController>();

  final authController = Get.find<AuthController>();

  final UserChatController controller = Get.find<UserChatController>();
  @override
  void initState() {
    // TO DO: implement initState.
    controller.receivedCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (homeController.sliderImageLoader.value) {
          case Status.loading:
            return Center(child: CustomLoader());
          case Status.internetError:
            return GeneralErrorScreen(
                onTap: () => homeController.getSliderImage());
          case Status.error:
            return GeneralErrorScreen(
                onTap: () => homeController.getSliderImage());
          case Status.completed:
            return Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height / 3.8,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      gradient: LinearGradient(
                          colors: [Color(0xffD4AF37), Color(0xffFFD700)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      color: AppColors.primary),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 80.h, left: 10.h, right: 10.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            ///======= name =========
                            Row(
                              children: [
                                CustomText(
                                  text: authController
                                          .userProfileModel.value.firstName ??
                                      "",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                  right: 8.w,
                                ),
                                CustomText(
                                  text: authController
                                          .userProfileModel.value.lastName ??
                                      "",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ],
                            ),

                            ///======= notification =========
                            IconButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.userNotificationScreen);
                              },
                              icon: CustomImage(
                                imageSrc: AppIcons.notification12,
                                imageColor: AppColors.black,
                                height: 35.h,
                                width: 35.w,
                              ),
                            )
                          ],
                        ),
                        //====== title Name =======
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            text: "How can we help you today?",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            bottom: 15.h,
                          ),
                        ),
                        CustomTextField(
                          onTap: () {
                            Get.toNamed(AppRoutes.searchBarScreen);
                          },
                          readOnly: true,
                          fillColor: AppColors.white,
                          prefixIcon: Icon(Icons.search),
                          hintText: AppStrings.searchForSomeone,
                          hintStyle: TextStyle(color: const Color.fromARGB(80, 23, 23, 23)),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Expanded(
                    child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    ///======== Carousel Slider ===========
                    homeController.sliderImage.isNotEmpty
                        ? CarouselSlider.builder(
                            options: CarouselOptions(
                              initialPage: homeController.sliderImage.length,
                              autoPlay: true,
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              height: 150.h,
                              onPageChanged: (index, reason) {
                                homeController.currentIndex.value = index;
                              },
                            ),
                            itemCount: homeController.sliderImage.length,
                            itemBuilder: (context, index, realIndex) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CustomNetworkImage(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.primary, width: .8),
                                      imageUrl: ImageHandler.imagesHandle(homeController.sliderImage[index].image ?? ""),
                                  //imageUrl:"${ApiUrl.imageUrl}${homeController.sliderImage[index].image ?? ""}",
                                  width: MediaQuery.of(context).size.width,
                                  height: 150.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text:
                                            "Meet Dr. Jane Doe – 10+ years of\n experience in Dermatology”.",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            height: 150.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: AppColors.primary, width: .6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: CustomText(
                              text: "No Slider Image",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                    SizedBox(
                      height: 20.h,
                    ),

                    ///====== Category ===========
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: AppStrings.category,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.categoryScreen,
                              );
                            },
                            child: CustomText(
                              text: AppStrings.viewAll,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    ///====== Category Menu List ===========
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      //padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          homeController.categoryList.length,
                          (index) {
                            if (index < homeController.categoryList.length ) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14.w),
                                child: CustomCategoryCircular(
                                  onTap: () {
                                    // আপনার নির্দিষ্ট রুট যুক্ত করুন
                                    Get.toNamed(AppRoutes.cardiologyScreen,
                                        arguments:
                                            homeController.categoryList[index]);
                                  },
                                  //icon: homeController.categoryList[index].image ?? "",
                                  icon:  ImageHandler.imagesHandle(homeController.categoryList[index].image ?? ""), //"${ApiUrl.imageUrl}${homeController.categoryList[index].image ?? ""}",
                                  text: homeController.categoryList[index].name ??"",
                                ),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                    ),

                    ///====== Popular Doctors ===========
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: AppStrings.popularDoctors,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.popularDoctorScreen);
                            },
                            child: CustomText(
                              text: AppStrings.viewAll,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Column(
                          children: [
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 0,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 0.h),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  popularDoctorController.popularList.length < 2
                                      ? popularDoctorController.popularList.length
                                      : 2,
                              itemBuilder: (BuildContext context, int index) {
                                var data =
                                    popularDoctorController.popularList[index];
                                debugPrint(data.id);
                                return CustomDoctorCard(
                                  onTap: () {
                                    Get.toNamed(
                                        AppRoutes.therapistViewProfileScreen,
                                        arguments: data);
                                  },
                                  imageUrl: ImageHandler.imagesHandle(data.therapist?.profile?.image ?? "" ),
                                     // "${ApiUrl.imageUrl}${data.therapist?.profile?.image ?? ""}",
                                  firstName: data.therapist?.firstName ?? "",
                                  lastName: data.therapist?.lastName ?? "",
                                  title:
                                      data.therapist?.profile?.speciality?.name ??
                                          "",
                                  price: data.therapist?.profile?.chargePerHour?.amount.toString() ??"",
                                  rating: "4.2",
                                );
                              },
                            ),
                          ],
                    ),
                  ],
                )),
              ],
            );
        }
      }),
      bottomNavigationBar: NavBar(currentIndex: 0),
    );
  }
}
