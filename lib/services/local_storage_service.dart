import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article_model.dart';

class LocalStorageService {
  static const String _favoritesKey = 'favorites';

  // Get all favorites
  static Future<List<ArticleModel>> getFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];

      return favoritesJson
          .map((json) => ArticleModel.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      print('Error getting favorites: $e');
      return [];
    }
  }

  // Add article to favorites
  static Future<bool> addToFavorites(ArticleModel article) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = prefs.getStringList(_favoritesKey) ?? [];

      // Check if article already exists in favorites
      bool exists = favorites.any((json) {
        final savedArticle = ArticleModel.fromJson(jsonDecode(json));
        return savedArticle.url == article.url;
      });

      if (!exists) {
        favorites.add(jsonEncode(article.toJson()));
        await prefs.setStringList(_favoritesKey, favorites);
      }

      return !exists; // Return true if article was added, false if it already existed
    } catch (e) {
      print('Error adding to favorites: $e');
      return false;
    }
  }

  // Remove article from favorites
  static Future<bool> removeFromFavorites(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = prefs.getStringList(_favoritesKey) ?? [];

      final updatedFavorites = favorites.where((json) {
        final savedArticle = ArticleModel.fromJson(jsonDecode(json));
        return savedArticle.url != url;
      }).toList();

      await prefs.setStringList(_favoritesKey, updatedFavorites);
      return true;
    } catch (e) {
      print('Error removing from favorites: $e');
      return false;
    }
  }

  // Check if article is in favorites
  static Future<bool> isInFavorites(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = prefs.getStringList(_favoritesKey) ?? [];

      return favorites.any((json) {
        final savedArticle = ArticleModel.fromJson(jsonDecode(json));
        return savedArticle.url == url;
      });
    } catch (e) {
      print('Error checking favorites: $e');
      return false;
    }
  }
}