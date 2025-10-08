import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_images/app_images.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/user_home_controller.dart';

class SearchBarScreen extends StatelessWidget {
  SearchBarScreen({super.key});

  final UserHomeController homeController = Get.find<UserHomeController>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          image: DecorationImage(
            scale: 4,
            image: AssetImage(AppImages.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            CustomRoyelAppbar(leftIcon: true),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: AppColors.black_03),
                  hintText: AppStrings.searchForSomeone,
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  homeController.searchCategory(value);
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                if (homeController.filteredCategoryList.isEmpty) {
                  return Center(
                    child: Text(
                      "No categories found",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: homeController.filteredCategoryList.length,
                  itemBuilder: (context, index) {
                    final category = homeController.filteredCategoryList[index];
                    return CustomListTile(
                      imageUrl: ImageHandler.imagesHandle(category.image ?? ''),
                      title: category.name ?? "",
                      onTap: () {
                        searchController.clear();
                        // Navigate with arguments
                        Get.toNamed(AppRoutes.cardiologyScreen, arguments: category);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomListTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color.fromARGB(66, 255, 255, 255).withOpacity(0.1),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: Colors.white,
        ),
        onTap: onTap,
      ),
    );
  }
}
