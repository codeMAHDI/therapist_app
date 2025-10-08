import 'package:counta_flutter_app/view/screens/user_part_screen/view/user_profile_screen/your_wallet_screen/add_wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/general_error.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_text/custom_text.dart';
import 'controller/wallet_controller.dart';

class YourWalletScreen extends StatelessWidget {
  YourWalletScreen({super.key});
  final WalletController walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(titleName: "Your Wallet"),
      body: Obx(
        () {
          // Check wallet loading state
          switch (walletController.walletLoader.value) {
            case Status.loading:
              return Center(child: CustomLoader()); // Show loader while loading
            case Status.internetError:
              return GeneralErrorScreen(
                  onTap: () =>
                      walletController.getWallet()); // Retry if internet error
            case Status.error:
              return GeneralErrorScreen(
                  onTap: () => walletController.getWallet()); // Retry on error
            case Status.completed:
              return Column(
                children: [
                  // Wallet Balance Container
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.navbarClr,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.wallet,
                                  size: 22, color: AppColors.white),
                              CustomText(
                                text: "Your Balance",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                left: 10.w,
                              ),
                            ],
                          ),
                          // Display balance
                          CustomText(
                            text:
                                "\$${walletController.yourWalletModel.value.balance!.amount.toString()}",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  // Add balance button
                ],
              );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50.0),
        child: CustomButton(
          onTap: () {
            Get.to(() => AddWallet());

            //TO DO    implement add balance
          },
          title: "Add Balance",
        ),
      ),
    );
  }
}
