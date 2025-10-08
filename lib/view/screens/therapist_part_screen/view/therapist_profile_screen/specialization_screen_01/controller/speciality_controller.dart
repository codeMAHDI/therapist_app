import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../service/api_check.dart';
import '../../../../../../../service/api_client.dart';
import '../../../../../../../service/api_url.dart';
import '../../../../../../../utils/app_const/app_const.dart';
import '../../../../../user_part_screen/model/category_list_model.dart';

class SpecialityController extends GetxController{
  ///================= GET CATEGORY LIST =================
  Rx<Status> categoryListLoader = Status.loading.obs;
  RxList<CategoryListModel> categoryList = <CategoryListModel>[].obs;
  Future<void> getCategoryList() async {
    debugPrint('======= Fetching Categories from API: ${ApiUrl.getCategoryList}');

    try {
      var response = await ApiClient.getData(ApiUrl.getCategoryList);
      if (response.statusCode == 200) {
        categoryListLoader.value = Status.completed;
        var data = response.body['data'] ?? [];

        // Ensure proper type conversion and debugging
        categoryList.value = data.map<CategoryListModel>((item) {
          debugPrint("Category Loaded: ${item['name']}");
          return CategoryListModel.fromJson(item);
        }).toList();

        refresh();
      } else {
        categoryListLoader.value = Status.error;
        ApiChecker.checkApi(response);
        refresh();
      }
    } catch (e) {
      categoryListLoader.value = Status.error;
      debugPrint('Error Fetching Categories: $e');
      refresh();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCategoryList();
  }
}