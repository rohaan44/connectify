import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:myapp/resources/ApiConfig.dart';


class DashboardController extends GetxController with SingleGetTickerProviderMixin {
  var isLoading = true.obs;
  var error = ''.obs;
  var stories = <Map<String, dynamic>>[].obs;
  var posts = <Map<String, dynamic>>[].obs;
  late TabController tabController;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    fetchStories();
    fetchPosts();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void fetchStories() async {
    try {
      isLoading(true);
      stories.value = await apiService.fetchStories();
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      posts.value = await apiService.fetchPosts();
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
