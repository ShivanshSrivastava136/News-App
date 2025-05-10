import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../controllers/news_controller.dart';
import '../widgets/article_card.dart';
import '../widgets/category_selector.dart';
import 'news_detail_view.dart';

class HomeView extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final NewsController newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search news...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    newsController.fetchTrendingNews();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  newsController.searchNews(value);
                }
              },
            ),
          ),
          CategorySelector(),
          Expanded(
            child: Obx(() {
              if (newsController.isLoading.value) {
                return Center(
                  child: SpinKitFadingCircle(color: Colors.blue),
                );
              }

              if (newsController.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 60, color: Colors.red),
                      SizedBox(height: 16),
                      Text(
                        'Error loading news',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          newsController.errorMessage.value,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => newsController.fetchTrendingNews(),
                        child: Text('Try Again'),
                      ),
                    ],
                  ),
                );
              }

              if (newsController.articles.isEmpty) {
                return Center(
                  child: Text(
                    'No news articles found',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  if (_searchController.text.trim().isNotEmpty) {
                    newsController.searchNews(_searchController.text);
                  } else {
                    newsController.fetchNewsByCategory(newsController.selectedCategory.value);
                  }
                },
                child: ListView.builder(
                  itemCount: newsController.articles.length,
                  itemBuilder: (context, index) {
                    final article = newsController.articles[index];
                    return ArticleCard(
                      article: article,
                      onTap: () => Get.to(() => NewsDetailView(article: article)),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}