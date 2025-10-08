import 'package:counta_flutter_app/helper/time_converter/time_converter.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_icons/app_icons.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/widget/custom_invoice_row_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/general_error.dart';
import '../../../../therapist_part_screen/view/subscription_screen/controller/subscription_controller.dart';
import 'model/invoice_list_model.dart';

class InvoiceViewScreen extends StatefulWidget {
  const InvoiceViewScreen({super.key});

  @override
  State<InvoiceViewScreen> createState() => _InvoiceViewScreenState();
}

class _InvoiceViewScreenState extends State<InvoiceViewScreen> {
  final subscriptionController = Get.find<SubscriptionController>();

  final InvoiceListModel invoiceModel = Get.arguments;
  @override
  void initState() {
    subscriptionController.getInvoiceByUserId(id: invoiceModel.id ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: AppStrings.invoiceView,
      ),
      body: Obx(() {
        switch (subscriptionController.invoiceByUserLoader.value) {
          case Status.loading:
            return Center(child: CustomLoader()); // Show loader while loading
          case Status.internetError:
            return GeneralErrorScreen(
              onTap: () => subscriptionController.getInvoiceByUserId(
                id: invoiceModel.id ?? "",
              ),
            ); // Retry if internet error
          case Status.error:
            return GeneralErrorScreen(
                onTap: () => subscriptionController.getInvoiceByUserId(
                    id: invoiceModel.id ?? "")); // Retry on error
          case Status.completed:
            var invoice = subscriptionController.invoiceByUserModel.value;
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20.w),
                 // height: MediaQuery.sizeOf(context).height / 1.4,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: AppColors.navbarClr,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomImage(
                            imageSrc: AppIcons.logo,
                            width: 60.w,
                            height: 60.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                text: AppStrings.consultationInvoice,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                bottom: 8.h,
                              ),
                              CustomText(
                                text: invoice.invoiceId ?? "",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primary,
                                bottom: 8.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CustomText(
                                    text: "Appointment Id",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white,
                                    bottom: 8.h,
                                  ),
                                  CustomText(
                                    text: invoice.appointment?.id.toString() ??
                                        "",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: AppColors.primary,
                                    size: 15,
                                  ),
                                  CustomText(
                                    left: 10.h,
                                    text: invoice.createdAt != null
                                        ? DateConverter.dateFormetString(
                                            invoice.createdAt.toString())
                                        : "No date available",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    right: 10.h,
                                  ),
                                  Icon(
                                    Icons.access_time_sharp,
                                    color: AppColors.primary,
                                    size: 15,
                                  ),
                                  CustomText(
                                    left: 10.h,
                                    text: invoice.createdAt != null
                                        ? DateConverter.timeFormatString(invoice
                                            .createdAt
                                            .toString()) // Extracts only time
                                        : "No time slot",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Divider(
                        color: AppColors.primary,
                        thickness: .5,
                      ),
                      CustomText(
                        text: AppStrings.userDetails,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        top: 12.h,
                      ),
                      Divider(
                        color: AppColors.white_50,
                        thickness: .5,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Name :",
                            fontSize: 18.w,
                            fontWeight: FontWeight.w600,
                          ),
                          Row(
                            children: [
                              CustomText(
                                text: invoice.user?.id?.firstName ?? "",
                                fontSize: 18.w,
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                text: invoice.user?.id?.lastName ?? "",
                                fontSize: 18.w,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          )
                        ],
                      ),
                      /*CustomInvoiceRowList(
                          menuName: AppStrings.name, name: "John Doe",),*/
                      CustomInvoiceRowList(
                        menuName: "Email :",
                        name: invoice.user?.id?.email ?? "",
                      ),
                      CustomInvoiceRowList(
                        menuName: AppStrings.phoneNumberT,
                        name: invoice.user?.id?.phone ?? "",
                      ),
                      CustomText(
                        text: AppStrings.consultationDetails,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        top: 12.h,
                      ),
                      Divider(
                        color: AppColors.white_50,
                        thickness: .5,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: AppStrings.doctorName,
                            fontSize: 18.w,
                            fontWeight: FontWeight.w600,
                          ),
                          Row(
                            children: [
                              CustomText(
                                text:
                                    invoice.appointment?.therapist?.firstName ??
                                        "",
                                fontSize: 18.w,
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                text:
                                    invoice.appointment?.therapist?.lastName ??
                                        "",
                                fontSize: 18.w,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          )
                        ],
                      ),
                      CustomInvoiceRowList(
                        menuName: AppStrings.dateTime,
                        name: invoice.appointment?.date != null
                            ? DateConverter.dateFormetString(
                                invoice.appointment!.date.toString())
                            : "No date available",
                      ),
                      CustomText(
                        text: AppStrings.paymentDetails,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        top: 12.h,
                      ),
                      Divider(
                        color: AppColors.white_50,
                        thickness: .5,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CustomInvoiceRowList(
                        menuName: AppStrings.serviceFee,
                        name: invoice.appointment?.feeInfo?.bookedFee?.amount
                            .toString(),
                      ),
                      CustomInvoiceRowList(
                        menuName: AppStrings.transectionId,
                        name: invoice
                                .appointment?.feeInfo?.patientTransactionId ??
                            "",
                      ),
                      CustomInvoiceRowList(
                        menuName: AppStrings.totalAmountPaid,
                        name: invoice.appointment?.feeInfo?.bookedFee?.amount.toString(),
                      ),
                    ],
                  ),
                ),
              ),
            );
        }
      }),
    );
  }
}
