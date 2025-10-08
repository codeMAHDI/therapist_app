import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_strings/app_strings.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../popular_doctor_screen/controller/popular_doctor_controller.dart';
import '../popular_doctor_screen/model/popular_doctor_model.dart';
import '../widget/custom_available_slot.dart';
class RequestAppointmentScreen extends StatefulWidget {
  RequestAppointmentScreen({super.key});
  final PopularDoctorsModel popularDoctorsModel = Get.arguments;
  @override
  State<RequestAppointmentScreen> createState() =>
      _RequestAppointmentScreenState();
}
class _RequestAppointmentScreenState extends State<RequestAppointmentScreen> {
  final popularDoctorController = Get.find<PopularDoctorController>();
  DateTime today = DateTime.now();
  List<String> selectedSlots = [];
  String? selectedSlot; // Track the selected slot

  @override
  void initState() {
    super.initState();
    _updateAvailableSlots(today);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      today = selectedDay;
      selectedSlot = null; // Reset selection when the date changes
      _updateAvailableSlots(selectedDay);

      // Check if selected date is before today
      if (selectedDay.isBefore(today)) {
        // Show a message if selected day is in the past
        Get.snackbar(
          'Invalid Date',
          'Please select a future date.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    });
  }

  void _updateAvailableSlots(DateTime selectedDay) {
    final therapistProfile = widget.popularDoctorsModel.therapist?.profile;

    if (therapistProfile != null && therapistProfile.availabilities != null) {
      final availability = therapistProfile.availabilities!.firstWhere(
        (avail) => avail.dayIndex == selectedDay.weekday,
        orElse: () => Availability(),
      );

      setState(() {
        selectedSlots =
            availability.slotsPerDay?.map((slot) => slot.toString()).toList() ??
                [];
      });
    } else {
      setState(() {
        selectedSlots = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Select Time"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Select Date",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  bottom: 10.h,
                ),
              ),
              TableCalendar(
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(color: AppColors.primary),
                  todayDecoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(color: Colors.white),
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(color: Colors.white),
                ),
                locale: "en_US",
                rowHeight: 43,
                headerStyle: HeaderStyle(
                  titleTextStyle:
                      TextStyle(color: Colors.white, fontSize: 20.w),
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                onDaySelected: _onDaySelected,
                selectedDayPredicate: (selectedDay) =>
                    isSameDay(selectedDay, today),
                focusedDay: today,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 10, 16),
              ),
              SizedBox(height: 30.h),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Available Slot",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  bottom: 10.h,
                ),
              ),
              selectedSlots.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: selectedSlots.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSlot = selectedSlots[index];
                            });
                          },
                          child: CustomAvailableSlot(
                            text: selectedSlots[index],
                            isSelected: selectedSlot == selectedSlots[index],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CustomText(
                        text: "No Slots Available",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        top: 20.h,
                        color: Colors.red,
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: CustomButton(
          onTap: () {
            if (selectedSlot != null && selectedSlot!.isNotEmpty) {
              // Check if selected date is before today
              if (today.isBefore(DateTime.now())) {
                // Show a snackbar if the user tries to continue with a past date
                Get.snackbar(
                  'Invalid Date',
                  'Please select a future date.',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              } else {
                // Calculate the cost

                popularDoctorController.calculateCost(
                  selectedSlot ?? "",
                  widget.popularDoctorsModel.therapist?.profile?.chargePerHour
                          ?.amount
                          ?.toDouble() ??
                      0.0,
                );

                // Send the arguments properly as a List (not Set)
                Get.toNamed(AppRoutes.userPatientDetailsScreen, arguments: [
                  selectedSlot,
                  today, // today value for the selected date
                  widget.popularDoctorsModel
                ]);
              }
            } else {
              Get.snackbar("No Slot Selected",
                  "Please select a slot before continuing.");
            }
          },
          title: AppStrings.continueText,
        ),
      ),
    );
  }
}
