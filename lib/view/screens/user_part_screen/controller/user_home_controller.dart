import 'dart:convert';
import 'package:counta_flutter_app/service/api_check.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../service/api_client.dart';
import '../../../../service/api_url.dart';
import '../model/category_list_model.dart';
import '../model/slider_model.dart';

class UserHomeController extends GetxController {
  final List<String> imgList = [
    'https://c1.wallpaperflare.com/preview/127/366/443/library-book-bookshelf-read.jpg',
    'https://c4.wallpaperflare.com/wallpaper/569/784/53/macro-table-books-blur-wallpaper-preview.jpg',
    'https://c4.wallpaperflare.com/wallpaper/569/853/227/summer-mood-positive-morning-wallpaper-preview.jpg',
  ].obs;

  RxInt currentIndex = 0.obs;
  late PageController pageController;

  ///================= GET SLIDER IMAGE =================
  Rx<Status> sliderImageLoader = Status.loading.obs;
  RxList<SliderModel> sliderImage = <SliderModel>[].obs;

  ///================= CATEGORY LIST =================
  Rx<Status> categoryListLoader = Status.loading.obs;
  RxList<CategoryListModel> categoryList = <CategoryListModel>[].obs;

  ///================= FILTERED CATEGORY LIST =================
  RxList<CategoryListModel> filteredCategoryList = <CategoryListModel>[].obs;

  @override
  void onInit() {
    pageController = PageController(initialPage: currentIndex.value);
    pageController.addListener(() {
      currentIndex.value = pageController.page!.round();
    });

    getSliderImage();
    getCategoryList();
    super.onInit();
  }

  Future<void> getSliderImage() async {
    debugPrint('=======Method Call ==============>${ApiUrl.getSliderImage}');
    try {
      var response = await ApiClient.getData(ApiUrl.getSliderImage);
      if (response.statusCode == 200) {
        sliderImageLoader.value = Status.completed;
        var data = response.body['data'] ?? [];
        sliderImage.value = List<SliderModel>.from(
            data.map((x) => sliderModelFromJson(json.encode(x))));
      } else {
        sliderImageLoader.value = Status.error;
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      sliderImageLoader.value = Status.error;
      debugPrint('Error: $e');
    }
  }

  Future<void> getCategoryList() async {
    debugPrint('=======Method Call ==============>${ApiUrl.getCategoryList}');
    try {
      var response = await ApiClient.getData(ApiUrl.getCategoryList);
      if (response.statusCode == 200) {
        categoryListLoader.value = Status.completed;
        var data = response.body['data'] ?? [];
        categoryList.value = List<CategoryListModel>.from(
          data.map((item) => CategoryListModel.fromJson(item))
              .where((item) => item.name != null && item.name!.trim().isNotEmpty),
        );

        /// Initialize filtered list with all categories
        filteredCategoryList.value = List.from(categoryList);
      } else {
        categoryListLoader.value = Status.error;
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      categoryListLoader.value = Status.error;
      debugPrint('Error: $e');
    }
  }

  ///================= SEARCH CATEGORY =================
  void searchCategory(String query) {
    if (query.isEmpty) {
      filteredCategoryList.value = List.from(categoryList);
    } else {
      filteredCategoryList.value = categoryList
          .where((c) =>
              c.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}