import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomInboxMassage extends StatelessWidget {
  const CustomInboxMassage({
    super.key,
    required this.alignment,
    required this.message,
    this.messageTime,
    required this.type,
    required this.imageUrls,
  });
  final bool alignment;
  final String message;
  final String? messageTime;
  final String type;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment:
        alignment ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          alignment
              ? Row(
            children: [
              CustomNetworkImage(
                imageUrl: AppConstants.profileImage,
                height: 45.w,
                width: 45.w,
                boxShape: BoxShape.circle,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  type == 'text'
                      ? Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 8, horizontal: 12),
                    alignment: alignment
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth:
                        MediaQuery.sizeOf(context).width * 0.75,
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: alignment
                              ? AppColors.white
                              : AppColors.primary,
                          borderRadius: alignment
                              ? const BorderRadius.only(
                            bottomRight: Radius.circular(16),
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          )
                              : const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 10),
                          child: CustomText(
                            textAlign: alignment
                                ? TextAlign.right
                                : TextAlign.left,
                            text: message,
                            fontSize: 16.sp,
                            color: alignment
                                ? AppColors.black_04
                                : AppColors.white,
                            fontWeight: FontWeight.w400,
                            maxLines: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                      : buildImageSection(imageUrls, context, message),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: CustomText(
                      text: messageTime ?? '',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black_04,
                    ),
                  ),
                ],
              ),
            ],
          )
              : type == 'text'
              ? Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            alignment:
            alignment ? Alignment.topLeft : Alignment.topRight,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.75,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color:
                  alignment ? AppColors.white : AppColors.primary,
                  borderRadius: alignment
                      ? const BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  )
                      : const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 10),
                  child: CustomText(
                    textAlign:
                    alignment ? TextAlign.right : TextAlign.left,
                    text: message,
                    fontSize: 16.sp,
                    color: alignment
                        ? AppColors.black_04
                        : AppColors.white,
                    fontWeight: FontWeight.w400,
                    maxLines: 20,
                  ),
                ),
              ),
            ),
          )
              : buildImageSection(imageUrls, context, message),
          SizedBox(
            height: 4.h,
          ),
          alignment
              ? Container()
              : CustomText(
            text: messageTime ?? '',
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black_04,
          ),
          SizedBox(
            height: 12.h,
          ),
        ],
      ),
    );
  }

  Column buildImageSection(
      List<String> imageUrls, BuildContext context, String? content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
            children: List.generate(imageUrls.length, (index) {
              return Column(
                children: [
                  CustomNetworkImage(
                    imageUrl: ApiUrl.imageUrl + imageUrls[index],
                    height: 200.h,
                    width: 200.w,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              );
            })),
        if (content != null && content.isNotEmpty)
          Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                alignment: alignment ? Alignment.topLeft : Alignment.topRight,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.65,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: alignment ? AppColors.white : AppColors.primary,
                      borderRadius: alignment
                          ? const BorderRadius.only(
                        bottomRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      )
                          : const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 10),
                      child: CustomText(
                        textAlign: alignment ? TextAlign.right : TextAlign.left,
                        text: message,
                        fontSize: 16.sp,
                        color: alignment ? AppColors.black_04 : AppColors.white,
                        fontWeight: FontWeight.w400,
                        maxLines: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}