import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../controllers/favorites_controller.dart';
import '../widgets/article_card.dart';
import 'news_detail_view.dart';

class FavoritesView extends StatelessWidget {
  final FavoritesController favoritesController = Get.find<FavoritesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Articles'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        if (favoritesController.isLoading.value) {
          return Center(
            child: SpinKitFadingCircle(color: Colors.blue),
          );
        }

        if (favoritesController.favorites.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 60, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No favorite articles yet',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Start adding some articles to your favorites',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: favoritesController.favorites.length,
          itemBuilder: (context, index) {
            final article = favoritesController.favorites[index];
            return ArticleCard(
              article: article,
              onTap: () => Get.to(() => NewsDetailView(article: article)),
            );
          },
        );
      }),
    );
  }
}