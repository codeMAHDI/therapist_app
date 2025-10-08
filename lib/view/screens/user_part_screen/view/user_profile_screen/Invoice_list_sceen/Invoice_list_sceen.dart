import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/helper/time_converter/time_converter.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/widget/custom_invoice_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/general_error.dart';
import '../../../../therapist_part_screen/view/subscription_screen/controller/subscription_controller.dart';

class InvoiceListSceen extends StatelessWidget {
  InvoiceListSceen({super.key});
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
                      hintText: "Search for invoices",cursorColor: Colors.black,hintStyle: TextStyle(fontSize: 17 ,color: const Color.fromARGB(59, 0, 0, 0)),
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
                    // Display filtered list
                    Expanded(
                        child: subscriptionController
                                    .filteredInvoiceList.isNotEmpty &&
                                subscriptionController
                                    .searchQuery.value.isNotEmpty
                            ? ListView.builder(
                                itemCount: subscriptionController
                                    .filteredInvoiceList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var invoice = subscriptionController
                                      .filteredInvoiceList[index];
                                  return CustomInvoiceList(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.invoiceViewScreen,);
                                    },
                                    invoiceId: invoice.invoiceId.toString(),
                                    firstName:
                                        invoice.user?.id?.firstName ?? "",
                                    lastName: invoice.user?.id?.lastName ?? "",
                                    date: "${DateConverter.formatServerTime(
                                        invoice.createdAt.toString())}",
                                    amount:   invoice.appointment?.feeInfo?.mainFee?.amount.toString(),
                                    //invoice.appointment?.feeInfo?.bookedFee?.amount.toString(),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount:
                                    subscriptionController.invoiceList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var invoice =
                                      subscriptionController.invoiceList[index];
                                  return CustomInvoiceList(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.invoiceViewScreen, arguments: subscriptionController.invoiceList[index]);
                                    },
                                    invoiceId: invoice.invoiceId.toString(),
                                    firstName:
                                        invoice.user?.id?.firstName ?? "",
                                    lastName: invoice.user?.id?.lastName ?? "",
                                    date: DateConverter.formatServerTime(
                                        invoice.createdAt.toString()),
                                    amount:"${invoice.appointment?.feeInfo?.mainFee?.amount?.toString() ?? ''} ${invoice.appointment?.feeInfo?.mainFee?.currency ?? ''}",
                                  );
                                },
                              ))
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
