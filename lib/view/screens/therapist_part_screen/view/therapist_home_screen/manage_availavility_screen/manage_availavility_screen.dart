
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/therapist_profile_controller.dart';
import '../../widget/custom_availability_time_set.dart';

class ManageAvailavilityScreen extends StatelessWidget {
  ManageAvailavilityScreen({super.key});
  final TherapistProfileController availabilityController =
  Get.find<TherapistProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Manage Availability",
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Obx(() {
              return Column(
                children: [

                  // --- Sunday ---
                  CustomAvailabilityTimeSet(
                    value: !availabilityController.sunDayClose.value,
                    onChanged: (value) {
                      availabilityController.sunDayClose.value = !value;
                    },
                    dayNames: "Sun",
                    endTimeShow: availabilityController.sunEndTime.value,
                    startTimeShow: availabilityController.sunStartTime.value,
                    perDay: availabilityController.sunDayAppointment.value,
                    endTimeButton: () {
                      if (!availabilityController.sunDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 0, isStartTimeFlag: false);
                      } else {
                        //ToastMsg().errorToast("Sunday is Closed. Please open it first.");
                      }
                    },
                    startTimeButton: () {
                      if (!availabilityController.sunDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 0, isStartTimeFlag: true);
                      } else {
                        //ToastMsg().errorToast("Sunday is Closed. Please open it first.");
                      }
                    },
                  ),
                  // --- Monday ---
                  CustomAvailabilityTimeSet(
                    value: !availabilityController.monDayClose.value,
                    onChanged: (value) {
                      availabilityController.monDayClose.value = !value;
                    },
                    dayNames: "Mon",
                    startTimeShow: availabilityController.monStartTime.value,
                    endTimeShow: availabilityController.monEndTime.value,
                    perDay: availabilityController.monDayAppointment.value,
                    startTimeButton: () {
                      if (!availabilityController.monDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 1, isStartTimeFlag: true);
                      } else {
                       // ToastMsg().errorToast("Monday is Closed. Please open it first.");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.monDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 1, isStartTimeFlag: false);
                      } else {
                        //ToastMsg().errorToast("Monday is Closed. Please open it first.");
                      }
                    },
                  ),
                  // ... All other days ...
                  // --- Tuesday ---
                  CustomAvailabilityTimeSet(
                    value: !availabilityController.tueDayClose.value,
                    onChanged: (value) {
                      availabilityController.tueDayClose.value = !value;
                    },
                    dayNames: "Tue",
                    startTimeShow: availabilityController.tueStartTime.value,
                    endTimeShow: availabilityController.tueEndTime.value,
                    perDay: availabilityController.tueDayAppointment.value,
                    startTimeButton: () {
                      if (!availabilityController.tueDayClose.value){
                        availabilityController.timeSet(context, dayIndex: 2, isStartTimeFlag: true);
                      } else{
                       // ToastMsg().errorToast("Tuesday is Closed. Please open it first.");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.tueDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 2, isStartTimeFlag: false);
                      }else{
                       // ToastMsg().errorToast("Tuesday is Closed. Please open it first.");
                      }
                    },
                  ),
                  // --- Wednesday ---
                  CustomAvailabilityTimeSet(
                    value: !availabilityController.wedDayClose.value,
                    onChanged: (value) {
                      availabilityController.wedDayClose.value = !value;
                    },
                    dayNames: "Wed",
                    startTimeShow: availabilityController.wedStartTime.value,
                    endTimeShow: availabilityController.wedEndTime.value,
                    perDay: availabilityController.wedDayAppointment.value,
                    startTimeButton: () {
                      if (!availabilityController.wedDayClose.value){
                        availabilityController.timeSet(context, dayIndex: 3, isStartTimeFlag: true);
                      } else{
                      //  ToastMsg().errorToast("Wednesday is Closed. Please open it first.");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.wedDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 3, isStartTimeFlag: false);
                      }else{
                        //ToastMsg().errorToast("Wednesday is Closed. Please open it first.");
                      }
                    },
                  ),
                  // --- Thursday ---
                  CustomAvailabilityTimeSet(
                    value: !availabilityController.thuDayClose.value,
                    onChanged: (value) {
                      availabilityController.thuDayClose.value = !value;
                    },
                    dayNames: "Thu",
                    startTimeShow: availabilityController.thuStartTime.value,
                    endTimeShow: availabilityController.thuEndTime.value,
                    perDay: availabilityController.thuDayAppointment.value,
                    startTimeButton: () {
                      if (!availabilityController.thuDayClose.value){
                        availabilityController.timeSet(context, dayIndex: 4, isStartTimeFlag: true);
                      } else{
                       // ToastMsg().errorToast("Thursday is Closed. Please open it first.");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.thuDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 4, isStartTimeFlag: false);
                      }else{
                       // ToastMsg().errorToast("Thursday is Closed. Please open it first.");
                      }
                    },
                  ),
                  // --- Friday ---
                  CustomAvailabilityTimeSet(
                    value: !availabilityController.friDayClose.value,
                    onChanged: (value) {
                      availabilityController.friDayClose.value = !value;
                    },
                    dayNames: "Fri",
                    startTimeShow: availabilityController.friStartTime.value,
                    endTimeShow: availabilityController.friEndTime.value,
                    perDay: availabilityController.friDayAppointment.value,
                    startTimeButton: () {
                      if (!availabilityController.friDayClose.value){
                        availabilityController.timeSet(context, dayIndex: 5, isStartTimeFlag: true);
                      } else{
                        //ToastMsg().errorToast("Friday is Closed. Please open it first.");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.friDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 5, isStartTimeFlag: false);
                      }else{
                        //ToastMsg().errorToast("Friday is Closed. Please open it first.");
                      }
                    },
                  ),
                  // --- Saturday ---
                  CustomAvailabilityTimeSet(
                    value: !availabilityController.satDayClose.value,
                    onChanged: (value) {
                      availabilityController.satDayClose.value = !value;
                    },
                    dayNames: "Sat",
                    startTimeShow: availabilityController.satStartTime.value,
                    endTimeShow: availabilityController.satEndTime.value,
                    perDay: availabilityController.satDayAppointment.value,
                    startTimeButton: () {
                      if (!availabilityController.satDayClose.value){
                        availabilityController.timeSet(context, dayIndex: 6, isStartTimeFlag: true);
                      } else{
                        //ToastMsg().errorToast("Saturday is Closed. Please open it first.");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.satDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 6, isStartTimeFlag: false);
                      }else{
                       // ToastMsg().errorToast("Saturday is Closed. Please open it first.");
                      }
                    },
                  ),
                  SizedBox(height: 30.h),
                  Obx(
                        () => availabilityController.isSubmitAvailabilityLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                      onTap: () {
                        availabilityController.submitAvailability();
                      },
                      title: "Submit",
                    ),
                  ),
                  SizedBox(height: 50.h),
                ],
              );
            })),
      ),
    );
  }
}
