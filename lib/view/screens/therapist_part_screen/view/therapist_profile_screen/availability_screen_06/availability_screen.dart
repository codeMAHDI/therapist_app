import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/therapist_profile_controller.dart';
import '../../widget/custom_availability_time_set.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';


class AvailabilityScreen extends StatelessWidget {
  AvailabilityScreen({super.key});

  final TherapistProfileController availabilityController =
  Get.find<TherapistProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        // titleName: AppStrings.availability, // Using a more specific title
        titleName: "Set Your Availability",
        leftIcon: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Obx(() {
              return Column(
                children: [
                  // --- Sunday ---
                  CustomAvailabilityTimeSet(
                    // FIX: Invert the logic. The UI switch is ON when the day is OPEN.
                    // The controller variable `sunDayClose` is `false` when OPEN. So, !false = true (ON).
                    value: !availabilityController.sunDayClose.value,
                    onChanged: (value) {
                      // When the switch is toggled, update the controller state.
                      availabilityController.sunDayClose.value = !value;
                    },
                    dayNames: "Sun",
                    endTimeShow: availabilityController.sunEndTime.value,
                    startTimeShow: availabilityController.sunStartTime.value,
                    perDay: availabilityController.sunDayAppointment.value,
                    endTimeButton: () {
                      // Only allow setting time if the day is OPEN
                      if (!availabilityController.sunDayClose.value) {
                        // FIX: Use correct parameters: dayIndex and isStartTimeFlag
                        availabilityController.timeSet(context, dayIndex: 0, isStartTimeFlag: false);
                      } else {
                        // FIX: Use ToastMsg
                       // ToastMsg().errorToast("Sunday is Closed. Please open it first.");
                      }
                    },
                    startTimeButton: () {
                      if (!availabilityController.sunDayClose.value) {
                        // FIX: Use correct parameters
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
                        // FIX: Use correct parameters
                        availabilityController.timeSet(context, dayIndex: 1, isStartTimeFlag: true);
                      } else {
                        //ToastMsg().errorToast("Monday is Closed. Please open it first.");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.monDayClose.value) {
                        // FIX: Use correct parameters
                        availabilityController.timeSet(context, dayIndex: 1, isStartTimeFlag: false);
                      } else {
                        //ToastMsg().errorToast("Monday is Closed. Please open it first.");
                      }
                    },
                  ),

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
                      if (!availabilityController.tueDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 2, isStartTimeFlag: true);
                      } else {
                        //ToastMsg().errorToast("Tuesday is Closed. Please open it first.");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.tueDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 2, isStartTimeFlag: false);
                      } else {
                        //ToastMsg().errorToast("Tuesday is Closed. Please open it first.");
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
                      if (!availabilityController.wedDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 3, isStartTimeFlag: true);
                      } else {
                        //ToastMsg().errorToast("Wednesday is Closed. Please open it first.");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.wedDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 3, isStartTimeFlag: false);
                      } else {
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
                      if (!availabilityController.thuDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 4, isStartTimeFlag: true);
                      } else {
                        //ToastMsg().errorToast("Thursday is Closed. Please open it first.");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.thuDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 4, isStartTimeFlag: false);
                      } else {
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
                      if (!availabilityController.friDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 5, isStartTimeFlag: true);
                      } else {
                      //  ToastMsg().errorToast("Friday is Closed. Please open it first.");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.friDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 5, isStartTimeFlag: false);
                      } else {
                       // ToastMsg().errorToast("Friday is Closed. Please open it first.");
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
                      if (!availabilityController.satDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 6, isStartTimeFlag: true);
                      } else {
                        //ToastMsg().errorToast("Saturday is Closed. Please open it first.");
                      }
                    },
                    endTimeButton: () {
                      if (!availabilityController.satDayClose.value) {
                        availabilityController.timeSet(context, dayIndex: 6, isStartTimeFlag: false);
                      } else {
                        //ToastMsg().errorToast("Saturday is Closed. Please open it first.");
                      }
                    },
                  ),
                  SizedBox(height: 30.h),
                  Obx(
                        () => availabilityController.therapistRegisterLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                      // This screen is for the initial sign-up flow, so calling therapistRegister() is correct here.
                      onTap: () {
                        availabilityController.therapistRegister();
                      },
                      title: AppStrings.signUp,
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

/*class AvailabilityController extends GetxController {
  String getDayName(int index) {
    const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return days[index];
  }
  //=======sun Day =======
  RxString sunStartTime = "09:00 AM".obs;
  RxString sunEndTime = "09:00 PM".obs;
  RxBool sunDayClose = false.obs;
  Rx<TextEditingController> sunDayAppointment = TextEditingController().obs;

  //=======Mon Day =======
  RxString monStartTime = "09:00 AM".obs;
  RxString monEndTime = "09:00 PM".obs;
  RxBool monDayClose = false.obs;
  Rx<TextEditingController> monDayAppointment = TextEditingController().obs;

  //=======Tue Day =======
  RxString tueStartTime = "09:00 AM".obs;
  RxString tueEndTime = "09:00 PM".obs;
  RxBool tueDayClose = false.obs;
  Rx<TextEditingController> tueDayAppointment = TextEditingController().obs;

  //=======Wed Day =======
  RxString wedStartTime = "09:00 AM".obs;
  RxString wedEndTime = "09:00 PM".obs;
  RxBool wedDayClose = false.obs;
  Rx<TextEditingController> wedDayAppointment = TextEditingController().obs;

  //=======Thu Day =======
  RxString thuStartTime = "09:00 AM".obs;
  RxString thuEndTime = "09:00 PM".obs;
  RxBool thuDayClose = false.obs;
  Rx<TextEditingController> thuDayAppointment = TextEditingController().obs;

  //=======Fri Day =======
  RxString friStartTime = "09:00 AM".obs;
  RxString friEndTime = "09:00 PM".obs;
  RxBool friDayClose = false.obs;
  Rx<TextEditingController> friDayAppointment = TextEditingController().obs;

  //=======Sat Day =======
  RxString satStartTime = "09:00 AM".obs;
  RxString satEndTime = "09:00 PM".obs;
  RxBool satDayClose = false.obs;
  Rx<TextEditingController> satDayAppointment = TextEditingController().obs;


  timeSet(BuildContext context, {required int day, required int time}) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: endTime.value,
    );
    if (pickedTime != null) {
      //======== Sun
      if (day == 1 && time == 1) {
        sunStartTime.value = formatTime(pickedTime);
        refresh();
      } else if (day == 1 && time == 2) {
        sunEndTime.value = formatTime(pickedTime);
      }
      //======== Mon
      else if (day ==2 && time ==1){
        monStartTime.value=formatTime(pickedTime);
        refresh();
      }else if (day ==2 && time ==2){
        monEndTime.value =formatTime(pickedTime);
      }
      //======== Tue
      else if (day ==3 && time ==1){
        tueStartTime.value=formatTime(pickedTime);
        refresh();
      }else if (day ==3 && time ==2){
        tueEndTime.value =formatTime(pickedTime);
      }
      //======== Wed
      else if (day ==4 && time ==1){
        wedStartTime.value=formatTime(pickedTime);
        refresh();
      }else if (day ==4 && time ==2){
        wedEndTime.value =formatTime(pickedTime);
      }
      //======== Thu
      else if (day ==5 && time ==1){
        thuStartTime.value=formatTime(pickedTime);
        refresh();
      }else if (day ==5 && time ==2){
        thuEndTime.value =formatTime(pickedTime);
      }
      //======== Fri
      else if (day ==6 && time ==1){
        friStartTime.value=formatTime(pickedTime);
        refresh();
      }else if (day ==6 && time ==2){
        friEndTime.value =formatTime(pickedTime);
      }
      //======== Sat
      else if (day ==7 && time ==1){
        satStartTime.value=formatTime(pickedTime);
        refresh();
      }else if (day ==7 && time ==2){
        satEndTime.value =formatTime(pickedTime);
      }
    }
  }

  String formatTime(TimeOfDay timeOfDay) {
    final now = DateTime(0, 0, 0, timeOfDay.hour, timeOfDay.minute);
    final format = DateFormat.jm(); // "jm" is for the "09:00 AM" format
    return format.format(now);
  }

  Rx<TimeOfDay> startTime = TimeOfDay(hour: 9, minute: 10).obs;
  Rx<TimeOfDay> endTime = TimeOfDay(hour: 9, minute: 10).obs;

  // Start Time Picker
  Future<void> pickStartTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: startTime.value,
    );
    if (pickedTime != null) {
      startTime.value = pickedTime;
    }
  }

  // End Time Picker
  Future<void> pickEndTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: endTime.value,
    );
    if (pickedTime != null) {
      endTime.value = pickedTime;
    }
  }
}*/
