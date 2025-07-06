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
    'cricket',
    'kkr',
    'ipl',
    'sports',
    'team news',
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
      // Fetch KKR and cricket-related news by searching for relevant terms
      var fetchedArticles = await ApiService.searchNews('Kolkata Knight Riders OR KKR OR IPL cricket');
      articles.value = fetchedArticles;
    } catch (e) {
      errorMessage.value = 'Failed to load trending KKR news: $e';
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
      var fetchedArticles;
      // Map categories to search terms for KKR-focused content
      switch (category) {
        case 'kkr':
          fetchedArticles = await ApiService.searchNews('Kolkata Knight Riders OR KKR');
          break;
        case 'cricket':
          fetchedArticles = await ApiService.searchNews('cricket OR IPL');
          break;
        case 'ipl':
          fetchedArticles = await ApiService.searchNews('IPL OR Indian Premier League');
          break;
        case 'team news':
          fetchedArticles = await ApiService.searchNews('KKR team news OR Kolkata Knight Riders players');
          break;
        case 'sports':
          fetchedArticles = await ApiService.getNewsByCategory('sports');
          break;
        default:
          fetchedArticles = await ApiService.searchNews('Kolkata Knight Riders OR cricket OR IPL');
      }
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
      // Enhance search query to include KKR context
      final enhancedQuery = '$query KKR OR cricket OR IPL';
      var fetchedArticles = await ApiService.searchNews(enhancedQuery);
      articles.value = fetchedArticles;
    } catch (e) {
      errorMessage.value = 'Failed to search news: $e';
      print(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}