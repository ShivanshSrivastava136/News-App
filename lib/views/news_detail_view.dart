import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article_model.dart';
import '../controllers/favorites_controller.dart';

class NewsDetailView extends StatelessWidget {
  final ArticleModel article;

  NewsDetailView({required this.article});

  @override
  Widget build(BuildContext context) {
    final favoritesController = Get.find<FavoritesController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Obx(() {
            final isInFavorites = favoritesController.favorites
                .any((item) => item.url == article.url);

            return IconButton(
              icon: Icon(
                isInFavorites ? Icons.favorite : Icons.favorite_border,
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
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _launchUrl(article.url),
        label: Text('Read Full Article'),
        icon: Icon(Icons.open_in_browser),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              CachedNetworkImage(
                imageUrl: article.urlToImage!,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: Icon(Icons.error, size: 50),
                ),
              )
            else
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.grey[300],
                child: Icon(Icons.image_not_supported, size: 50),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.newspaper, size: 16, color: Colors.blue[800]),
                      SizedBox(width: 4),
                      Text(
                        article.source.name ?? 'Unknown Source',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Text(
                        _formatDate(article.publishedAt),
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  if (article.author != null) ...[
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.person, size: 16, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'By ${article.author}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 16),
                  if (article.description != null)
                    Text(
                      article.description!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 12),
                  if (article.content != null)
                    Text(
                      _cleanContent(article.content!),
                      style: TextStyle(fontSize: 16),
                    ),
                  SizedBox(height: 80), // Space for FAB
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
      return DateFormat('MMMM dd, yyyy').format(dateTime);
    } catch (e) {
      return 'Unknown date';
    }
  }

  String _cleanContent(String content) {
    // Remove character count indicators like "[+2000 chars]"
    return content.replaceAll(RegExp(r'\[\+\d+ chars\]$'), '');
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar('Error', 'Could not open the article URL',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}