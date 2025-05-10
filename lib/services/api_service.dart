import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class ApiService {
  // Replace this with your actual API key from newsapi.org
  static const String apiKey = '59e1a3987e414db4b25e5915048eb9e7';
  static const String baseUrl = 'https://newsapi.org/v2';

  // Get trending news
  static Future<List<ArticleModel>> getTrendingNews() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final articles = jsonData['articles'] as List;
        return articles.map((article) => ArticleModel.fromJson(article)).toList();
      } else {
        print('Failed to load trending news: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load trending news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching trending news: $e');
      throw Exception('Error fetching trending news: $e');
    }
  }

  // Get news by category
  static Future<List<ArticleModel>> getNewsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/top-headlines?country=us&category=$category&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final articles = jsonData['articles'] as List;
        return articles.map((article) => ArticleModel.fromJson(article)).toList();
      } else {
        print('Failed to load $category news: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load $category news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching $category news: $e');
      throw Exception('Error fetching $category news: $e');
    }
  }

  // Search news
  static Future<List<ArticleModel>> searchNews(String query) async {
    try {
      final encodedQuery = Uri.encodeComponent(query);
      final response = await http.get(
        Uri.parse('$baseUrl/everything?q=$encodedQuery&sortBy=relevancy&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final articles = jsonData['articles'] as List;
        return articles.map((article) => ArticleModel.fromJson(article)).toList();
      } else {
        print('Failed to search news: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to search news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching news: $e');
      throw Exception('Error searching news: $e');
    }
  }
}