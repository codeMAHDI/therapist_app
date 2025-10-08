import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../../../utils/ToastMsg/toast_message.dart';

class TestingController extends GetxController {
  // Text controllers
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var roleController = TextEditingController();
  var addressController = TextEditingController();
  var dateOfBirthController = TextEditingController();
  var genderController = TextEditingController();

  // Image file to be uploaded
  Rx<File?> image = Rx<File?>(null);
  // Method to pick image from gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  // Method to create user and send POST request
  Future<void> createUser() async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        roleController.text.isEmpty ||
        addressController.text.isEmpty ||
        dateOfBirthController.text.isEmpty ||
        genderController.text.isEmpty) {
      showCustomSnackBar('Please fill in all fields', isError: true);
      return;
    }

    try {
      // Check if the image is selected
      if (image.value == null) {
        showCustomSnackBar('Please select an image', isError: true);
        return;
      }

      // Ensure the correct format for dateOfBirth
      String dateOfBirth = dateOfBirthController.text;  // Expected format: "yyyy-MM-dd"
      if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(dateOfBirth)) {
        showCustomSnackBar('Date of Birth should be in the format yyyy-MM-dd', isError: true);
        return;
      }

      // Make sure to use the full URL, including the scheme and host
      var uri = Uri.parse("http://10.0.60.55:5002/v1/user/create");  // <-- Update with your actual base URL

      var request = http.MultipartRequest('POST', uri);

      // Add fields (text inputs)
      request.fields['firstName'] = firstNameController.text;
      request.fields['lastName'] = lastNameController.text;
      request.fields['email'] = emailController.text;
      request.fields['phone'] = phoneController.text;
      request.fields['password'] = passwordController.text;
      request.fields['role'] = roleController.text;
      request.fields['address'] = addressController.text;
      request.fields['dateOfBirth'] = dateOfBirth;
      request.fields['gender'] = genderController.text;

      // Add the image if available
      if (image.value != null) {
        var mimeType = lookupMimeType(image.value!.path);
        var imageStream = http.ByteStream(image.value!.openRead());
        var length = await image.value!.length();

        var multipartFile = http.MultipartFile(
            'image', imageStream, length,
            filename: image.value!.path.split('/').last,
            contentType: mimeType != null ? MediaType.parse(mimeType) : MediaType('image', 'jpg')
        );

        request.files.add(multipartFile);
      }

      // Send the request
      var response = await request.send();

      if (response.statusCode == 201) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);
        debugPrint('Response: $jsonResponse');
        // Handle the response, e.g., show success message
      } else {
        // Handle error response
        var errorResponse = await response.stream.bytesToString();
        debugPrint('Error Response: $errorResponse');
        showCustomSnackBar('Failed to create user: ${response.statusCode}', isError: true);
      }
    } catch (e) {
      debugPrint('Error: $e');
      showCustomSnackBar('Something went wrong!', isError: true);
    }
  }
}