import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/article_model.dart';
import '../controllers/favorites_controller.dart';

class ArticleCard extends StatelessWidget {
  final ArticleModel article;
  final bool showFavoriteButton;
  final VoidCallback onTap;

  ArticleCard({
    required this.article,
    this.showFavoriteButton = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesController = Get.find<FavoritesController>();

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: article.urlToImage != null
                  ? CachedNetworkImage(
                imageUrl: article.urlToImage!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Icon(Icons.error),
                ),
              )
                  : Container(
                height: 180,
                width: double.infinity,
                color: Colors.grey[300],
                child: Icon(Icons.image_not_supported, size: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          article.source.name ?? 'Unknown Source',
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        _formatDate(article.publishedAt),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    article.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  if (article.description != null)
                    Text(
                      article.description!,
                      style: TextStyle(fontSize: 14),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (showFavoriteButton)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Obx(() {
                        final isInFavorites = favoritesController.favorites
                            .any((item) => item.url == article.url);

                        return IconButton(
                          icon: Icon(
                            isInFavorites
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isInFavorites ? Colors.red : null,
                          ),
                          onPressed: () {
                            if (isInFavorites) {
                              favoritesController.removeFromFavorites(article);
                            } else {
                              favoritesController.addToFavorites(article);
                            }
                          },
                        );
                      }),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(dateTime);
    } catch (e) {
      return 'Unknown date';
    }
  }
}