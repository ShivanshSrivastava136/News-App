import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';

class CategorySelector extends StatelessWidget {
  CategorySelector();

  @override
  Widget build(BuildContext context) {
    final newsController = Get.find<NewsController>();

    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: NewsController.categories.length,
        itemBuilder: (context, index) {
          final category = NewsController.categories[index];

          return Obx(() {
            final isSelected = category == newsController.selectedCategory.value;

            return GestureDetector(
              onTap: () => newsController.fetchNewsByCategory(category),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category[0].toUpperCase() + category.substring(1),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}