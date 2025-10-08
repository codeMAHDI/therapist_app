import 'package:counta_flutter_app/utils/ToastMsg/toast_message.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/controller/therapist_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widget/custom_availability_time_set.dart';

class AvailabilityEditScreen extends StatefulWidget {
  const AvailabilityEditScreen({super.key});

  @override
  State<AvailabilityEditScreen> createState() => _AvailabilityEditScreenState();
}

class _AvailabilityEditScreenState extends State<AvailabilityEditScreen> {
  final TherapistRegisterController availabilityController =
  Get.find<TherapistRegisterController>();

  @override
  void initState() {
    super.initState();
    availabilityController.initializeAvailabilities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Availability",
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Obx(() {
              return Column(
                children: [
                  // ======================= SUNDAY =======================
                  CustomAvailabilityTimeSet(
                    value: !availabilityController.sunDayClose.value,
                    onChanged: (value) {
                      availabilityController.sunDayClose.value = !value;
                    },
                    dayNames: "Sun",
                    endTimeShow: availabilityController.sunEndTime.value,
                    startTimeShow: availabilityController.sunStartTime.value,
                    // CORRECTED: .value removed
                    perDay: availabilityController.sunDayAppointment,
                    endTimeButton: () {
                      if (!availabilityController.sunDayClose.value) {
                        availabilityController.timeSet(context,
                            dayIndex: 0, isStartTimeFlag: false);
                      } else {
                        showCustomSnackBar("Sunday is Close");
                      }
                    },
                    startTimeButton: () {
                      if (!availabilityController.sunDayClose.value) {
                        availabilityController.timeSet(context,
                            dayIndex: 0, isStartTimeFlag: true);
                      } else {
                        showCustomSnackBar("Sunday is Close");
                      }
                    },
                  ),
                  // ======================= MONDAY =======================
                  CustomAvailabilityTimeSet(
                    value: !availabilityController.monDayClose.value,
                    onChanged: (value) {
                      availabilityController.monDayClose.value = !value;
                    },
                    dayNames: "Mon",
                    startTimeShow: availabilityController.monStartTime.value,
                    endTimeShow: availabilityController.monEndTime.value,
                    // CORRECTED: .value removed
                    perDay: availabilityController.monDayAppointment,
                    startTimeButton: () {
                      if (!availabilityController.monDayClose.value) {
                        availabilityController.timeSet(context,
                            dayIndex: 1, isStartTimeFlag: true);
                      } else {
                        showCustomSnackBar("Monday is Close");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.monDayClose.value) {
                        availabilityController.timeSet(context,
                            dayIndex: 1, isStartTimeFlag: false);
                      } else {
                        showCustomSnackBar("Monday is Close");
                      }
                    },
                  ),
                  // ======================= TUESDAY =======================
                  CustomAvailabilityTimeSet(
                    value: !availabilityController.tueDayClose.value,
                    onChanged: (value) {
                      availabilityController.tueDayClose.value = !value;
                    },
                    dayNames: "Tue",
                    startTimeShow: availabilityController.tueStartTime.value,
                    endTimeShow: availabilityController.tueEndTime.value,
                    // CORRECTED: .value removed
                    perDay: availabilityController.tueDayAppointment,
                    startTimeButton: () {
                      if (!availabilityController.tueDayClose.value) {
                        availabilityController.timeSet(context,
                            dayIndex: 2, isStartTimeFlag: true);
                      } else {
                        showCustomSnackBar("Tuesday is Close");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.tueDayClose.value) {
                        availabilityController.timeSet(context,
                            dayIndex: 2, isStartTimeFlag: false);
                      } else {
                        showCustomSnackBar("Tuesday is Close");
                      }
                    },
                  ),
                  // ======================= WEDNESDAY =======================
                  CustomAvailabilityTimeSet(
                    value: !availabilityController.wedDayClose.value,
                    onChanged: (value) {
                      availabilityController.wedDayClose.value = !value;
                    },
                    dayNames: "Wed",
                    startTimeShow: availabilityController.wedStartTime.value,
                    endTimeShow: availabilityController.wedEndTime.value,
                    // CORRECTED: .value removed
                    perDay: availabilityController.wedDayAppointment,
                    startTimeButton: () {
                      if (!availabilityController.wedDayClose.value) {
                        availabilityController.timeSet(context,
                            dayIndex: 3, isStartTimeFlag: true);
                      } else {
                        showCustomSnackBar("Wednesday is Close");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.wedDayClose.value) {
                        availabilityController.timeSet(context,
                            dayIndex: 3, isStartTimeFlag: false);
                      } else {
                        showCustomSnackBar("Wednesday is Close");
                      }
                    },
                  ),
                  // ======================= THURSDAY =======================
                  CustomAvailabilityTimeSet(
                    value: !availabilityController.thuDayClose.value,
                    onChanged: (value) {
                      availabilityController.thuDayClose.value = !value;
                    },
                    dayNames: "Thu",
                    startTimeShow: availabilityController.thuStartTime.value,
                    endTimeShow: availabilityController.thuEndTime.value,
                    // CORRECTED: .value removed
                    perDay: availabilityController.thuDayAppointment,
                    startTimeButton: () {
                      if (!availabilityController.thuDayClose.value) {
                        availabilityController.timeSet(context,
                            dayIndex: 4, isStartTimeFlag: true);
                      } else {
                        showCustomSnackBar("Thursday is Close");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.thuDayClose.value) {
                        availabilityController.timeSet(context,
                            dayIndex: 4, isStartTimeFlag: false);
                      } else {
                        showCustomSnackBar("Thursday is Close");
                      }
                    },
                  ),
                  // ======================= FRIDAY =======================
                  CustomAvailabilityTimeSet(
                    value: !availabilityController.friDayClose.value,
                    onChanged: (value) {
                      availabilityController.friDayClose.value = !value;
                    },
                    dayNames: "Fri",
                    startTimeShow: availabilityController.friStartTime.value,
                    endTimeShow: availabilityController.friEndTime.value,
                    // CORRECTED: .value removed
                    perDay: availabilityController.friDayAppointment,
                    startTimeButton: () {
                      if (!availabilityController.friDayClose.value) {
                        availabilityController.timeSet(context,
                            dayIndex: 5, isStartTimeFlag: true);
                      } else {
                        showCustomSnackBar("Friday is Close");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.friDayClose.value) {
                        availabilityController.timeSet(context,
                            dayIndex: 5, isStartTimeFlag: false);
                      } else {
                        showCustomSnackBar("Friday is Close");
                      }
                    },
                  ),
                  // ======================= SATURDAY =======================
                  CustomAvailabilityTimeSet(
                    value: !availabilityController.satDayClose.value,
                    onChanged: (value) {
                      availabilityController.satDayClose.value = !value;
                    },
                    dayNames: "Sat",
                    startTimeShow: availabilityController.satStartTime.value,
                    endTimeShow: availabilityController.satEndTime.value,
                    // CORRECTED: .value removed
                    perDay: availabilityController.satDayAppointment,
                    startTimeButton: () {
                      if (!availabilityController.satDayClose.value) {
                        availabilityController.timeSet(context,
                            dayIndex: 6, isStartTimeFlag: true);
                      } else {
                        showCustomSnackBar("Saturday is Close");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.satDayClose.value) {
                        availabilityController.timeSet(context,
                            dayIndex: 6, isStartTimeFlag: false);
                      } else {
                        showCustomSnackBar("Saturday is Close");
                      }
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  // The submit button remains the same, it's already correct.
                  Obx(() => availabilityController.isSubmitAvailability.value
                      ? CustomLoader()
                      : CustomButton(
                    onTap: () {
                      availabilityController.submitAvailability();
                    },
                    title: "Submit",
                  )),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              );
            })),
      ),
    );
  }
}
