import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/general_error.dart';
import '../about_us_screen/controller/about_controller.dart';
class TermsConditionScreen extends StatelessWidget {
  TermsConditionScreen({super.key});
  final AboutController aboutController = Get.find<AboutController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true,titleName: AppStrings.termsAndConditions,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () {
              switch (aboutController.rxAboutStatus.value) {
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
                      onTap: () => aboutController.getAboutUs());
                case Status.completed:
                  return Column(
                    children: [
                      HtmlWidget(
                        aboutController.aboutModel.value.description != null
                            ? aboutController.aboutModel.value.description!
                            : 'About Us Is Empty Data',
                        textStyle: TextStyle(color: AppColors.white, fontSize: 18.sp, fontWeight: FontWeight.w400,),
                      ),
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
