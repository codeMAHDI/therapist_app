import 'package:counta_flutter_app/view/screens/testing_view/testing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestingUserSignUpScreen extends StatelessWidget {
  final TestingController userController = Get.find<TestingController>();

  TestingUserSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create User')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: userController.firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: userController.lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: userController.emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: userController.phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: userController.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: userController.roleController,
              decoration: InputDecoration(labelText: 'Role'),
            ),
            TextField(
              controller: userController.addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: userController.dateOfBirthController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            TextField(
              controller: userController.genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            ElevatedButton(
              onPressed: () => userController.pickImage(),
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: () => userController.createUser(),
              child: Text('Create User'),
            ),
          ],
        ),
      ),
    );
  }
}
