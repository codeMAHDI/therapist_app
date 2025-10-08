import 'dart:convert';
import 'package:counta_flutter_app/service/api_client.dart';
import 'package:counta_flutter_app/service/api_url.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class RescheduleDialog extends StatefulWidget {
  final String bookingId; // <-- appointment.id থেকে আসবে

  const RescheduleDialog({super.key, required this.bookingId});

  @override
  State<RescheduleDialog> createState() => _RescheduleDialogState();
}

class _RescheduleDialogState extends State<RescheduleDialog> {
  // Generate 30 days from now
  final List<DateTime> availableDates =
      List.generate(30, (i) => DateTime.now().add(Duration(days: i)));

  final List<String> availableSlots = [
    "09 AM",
    "10 AM",
    "11 AM",
    "12 PM",
    "2 PM",
    "3 PM",
    "4 PM",
    "5 PM",
    "7 PM",
    "8 PM",
    "9 PM",
    "10 PM",
  ];

  DateTime? selectedDate;
  String? selectedSlot;
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = availableDates[0]; // default today
  }

  Future<void> onConfirm() async {
    if (selectedDate == null || selectedSlot == null) {
      Get.snackbar("Error", "Please select both date and time slot",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    try {
      final body = jsonEncode({
        "date": DateFormat("yyyy-MM-dd").format(selectedDate!),
        "slot": selectedSlot!,
        "reason": noteController.text,
      });

      // 🔍 Debug print before API call
      debugPrint(
          "📤 PATCH URL => ${ApiUrl.rescheduleBooking(bookingId: widget.bookingId)}");
      debugPrint("📤 Request Body (encoded) => $body");

      final response = await ApiClient.patchData(
        ApiUrl.rescheduleBooking(bookingId: widget.bookingId),
        body,
        isContentType: true,
      );

      // 🔍 Debug print after API call
      debugPrint("✅ Response Code: ${response.statusCode}");
      debugPrint("✅ Response Body: ${response.body}");
      debugPrint("✅ Response Text: ${response.statusText}");

      if (response.statusCode == 200) {
        Get.back(result: body); // close dialog & return data
        Get.snackbar("Success", "Booking rescheduled successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        Get.snackbar("Failed", response.statusText ?? "Something went wrong",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("❌ Exception: $e");
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  const Text(
                    "Reschedule",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Scrollable Date Selector (30 days)
              SizedBox(
                height: 90,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: availableDates.map((date) {
                      final isSelected = selectedDate == date;
                      return GestureDetector(
                        onTap: () => setState(() => selectedDate = date),
                        child: Container(
                          width: 70,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.primary,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat("E").format(date),
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.black : Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                DateFormat("d").format(date),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color:
                                      isSelected ? Colors.black : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Time Slots
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Available Time",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: availableSlots.map((slot) {
                  final isSelected = selectedSlot == slot;
                  return GestureDetector(
                    onTap: () => setState(() => selectedSlot = slot),
                    child: Container(
                      width: 70,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(6),
                        color:
                            isSelected ? AppColors.primary : Colors.transparent,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        slot,
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Note
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Note",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: noteController,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  hintText: "Write your note here...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.amber),
                        foregroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => Get.back(),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: onConfirm,
                      child: const Text("Confirm"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
