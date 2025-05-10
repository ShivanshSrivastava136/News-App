import 'package:get/get.dart';
import '../models/article_model.dart';
import '../services/api_service.dart';

class NewsController extends GetxController {
  var isLoading = true.obs;
  var articles = <ArticleModel>[].obs;
  var errorMessage = ''.obs;
  var selectedCategory = 'general'.obs;

  static final List<String> categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  @override
  void onInit() {
    fetchTrendingNews();
    super.onInit();
  }

  // Fetch trending news
  void fetchTrendingNews() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      var fetchedArticles = await ApiService.getTrendingNews();
      articles.value = fetchedArticles;
    } catch (e) {
      errorMessage.value = 'Failed to load trending news: $e';
      print(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch news by category
  void fetchNewsByCategory(String category) async {
    if (selectedCategory.value == category) return;

    selectedCategory.value = category;
    isLoading.value = true;
    errorMessage.value = '';

    try {
      var fetchedArticles = await ApiService.getNewsByCategory(category);
      articles.value = fetchedArticles;
    } catch (e) {
      errorMessage.value = 'Failed to load $category news: $e';
      print(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  // Search news
  void searchNews(String query) async {
    if (query.trim().isEmpty) {
      fetchTrendingNews();
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      var fetchedArticles = await ApiService.searchNews(query);
      articles.value = fetchedArticles;
    } catch (e) {
      errorMessage.value = 'Failed to search news: $e';
      print(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}