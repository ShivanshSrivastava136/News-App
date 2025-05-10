import 'package:get/get.dart';
import '../models/article_model.dart';
import '../services/local_storage_service.dart';

class FavoritesController extends GetxController {
  var isLoading = true.obs;
  var favorites = <ArticleModel>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }

  // Load favorites from local storage
  void loadFavorites() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      var savedFavorites = await LocalStorageService.getFavorites();
      favorites.value = savedFavorites;
    } catch (e) {
      errorMessage.value = 'Failed to load favorites: $e';
      print(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  // Add article to favorites
  Future<bool> addToFavorites(ArticleModel article) async {
    try {
      bool added = await LocalStorageService.addToFavorites(article);
      if (added) {
        favorites.add(article);
        Get.snackbar('Success', 'Article added to favorites');
      }
      return added;
    } catch (e) {
      errorMessage.value = 'Failed to add to favorites: $e';
      print(errorMessage.value);
      return false;
    }
  }

  // Remove article from favorites
  Future<bool> removeFromFavorites(ArticleModel article) async {
    try {
      bool removed = await LocalStorageService.removeFromFavorites(article.url);
      if (removed) {
        favorites.removeWhere((item) => item.url == article.url);
        Get.snackbar('Success', 'Article removed from favorites');
      }
      return removed;
    } catch (e) {
      errorMessage.value = 'Failed to remove from favorites: $e';
      print(errorMessage.value);
      return false;
    }
  }

  // Check if article is in favorites
  Future<bool> isInFavorites(String url) async {
    return await LocalStorageService.isInFavorites(url);
  }
}