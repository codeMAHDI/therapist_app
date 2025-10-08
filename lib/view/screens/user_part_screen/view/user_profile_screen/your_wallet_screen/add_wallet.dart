import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/user_profile_screen/your_wallet_screen/controller/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddWallet extends StatelessWidget {
  AddWallet({super.key});

  final WalletController controller = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(titleName: "Add Wallet"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Obx(() {
          return Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              CustomFormCard(
                title: "Amount",
                hintText: "type here....",
                controller: controller.amontcontroller.value,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 500.h,
              ),
              controller.addWalletLoader.value
                  ? CustomLoader()
                  : CustomButton(
                      onTap: () {
                        if (controller.amontcontroller.value.text.isEmpty) {
                          Get.snackbar("Error", "Please enter amount");
                          return;
                        }

                        controller.addWallet();
                      },
                      title: "Add"),
            ],
          );
        }),
      ),
    );
  }
}
