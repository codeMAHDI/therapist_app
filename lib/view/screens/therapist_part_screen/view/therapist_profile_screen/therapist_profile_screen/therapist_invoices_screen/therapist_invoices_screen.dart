import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../../helper/time_converter/time_converter.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../../utils/app_const/app_const.dart';
import '../../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../../components/custom_text_field/custom_text_field.dart';
import '../../../../../../components/general_error.dart';
import '../../../../../user_part_screen/view/widget/custom_invoice_list.dart';
import '../../../subscription_screen/controller/subscription_controller.dart';

class TherapistInvoicesScreen extends StatelessWidget {
  TherapistInvoicesScreen({super.key});
  final subscriptionController = Get.find<SubscriptionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Invoice List",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(
              () {
            switch (subscriptionController.invoiceLoader.value) {
              case Status.loading:
                return Center(child: CustomLoader());
              case Status.internetError:
                return GeneralErrorScreen(
                    onTap: () => subscriptionController.getInvoice());
              case Status.error:
                return GeneralErrorScreen(
                    onTap: () => subscriptionController.getInvoice());
              case Status.completed:
                return Column(
                  children: [
                    // Search Bar
                    CustomTextField(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      fillColor: AppColors.white,
                      onChanged: (value) {
                        subscriptionController.searchQuery.value = value;
                        subscriptionController.searchInvoices();
                        subscriptionController.searchQuery.refresh();
                        subscriptionController.filteredInvoiceList.refresh();
                        // Filter locally
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Display filtered list or show message if no data
                    Expanded(
                      child: subscriptionController
                          .filteredInvoiceList.isNotEmpty &&
                          subscriptionController.searchQuery.value.isNotEmpty
                          ? ListView.builder(
                        itemCount:
                        subscriptionController.filteredInvoiceList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var invoice = subscriptionController
                              .filteredInvoiceList[index];
                          return CustomInvoiceList(
                            onTap: () {
                              Get.toNamed(AppRoutes.invoiceViewScreen);
                            },
                            invoiceId: invoice.invoiceId.toString(),
                            firstName:
                            invoice.user?.id?.firstName ?? "",
                            lastName: invoice.user?.id?.lastName ?? "",
                            date: DateConverter.formatServerTime(
                                invoice.createdAt.toString()),
                            amount: "50",
                          );
                        },
                      )
                          : subscriptionController.invoiceList.isNotEmpty
                          ? ListView.builder(
                        itemCount:
                        subscriptionController.invoiceList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var invoice =
                          subscriptionController.invoiceList[index];
                          return CustomInvoiceList(
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.invoiceViewScreen,
                                arguments:
                                subscriptionController
                                    .invoiceList[index],
                              );
                            },
                            invoiceId: invoice.invoiceId.toString(),
                            firstName:
                            invoice.user?.id?.firstName ?? "",
                            lastName: invoice.user?.id?.lastName ?? "",
                            date: DateConverter.formatServerTime(
                                invoice.createdAt.toString()),
                            amount: "50",
                          );
                        },
                      )
                          : Center(
                        child: Text(
                          "Data not found",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}