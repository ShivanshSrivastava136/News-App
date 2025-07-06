import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../controllers/shop_controller.dart';
import '../models/shop_item_model.dart';

class ShopView extends StatelessWidget {
  final ShopController shopController = Get.find<ShopController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KKR Shop'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Obx(() => IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (shopController.cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFD700),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${shopController.cartItems.length}',
                        style: TextStyle(
                          color: Color(0xFF512B7C),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () => _showCartDialog(context),
          )),
        ],
      ),
      body: Column(
        children: [
          _buildCategorySelector(),
          Expanded(
            child: Obx(() {
              if (shopController.isLoading.value) {
                return Center(
                  child: SpinKitFadingCircle(color: Color(0xFF512B7C)),
                );
              }

              return GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: shopController.filteredItems.length,
                itemBuilder: (context, index) {
                  final item = shopController.filteredItems[index];
                  return _buildShopItemCard(item);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ShopController.categories.length,
        itemBuilder: (context, index) {
          final category = ShopController.categories[index];
          return Obx(() {
            final isSelected = category == shopController.selectedCategory.value;
            return GestureDetector(
              onTap: () => shopController.filterByCategory(category),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF512B7C) : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category[0].toUpperCase() + category.substring(1),
                  style: TextStyle(
                    color: isSelected ? Color(0xFFFFD700) : Colors.black,
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

  Widget _buildShopItemCard(ShopItemModel item) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                color: Colors.grey[200],
              ),
              child: Icon(
                Icons.shopping_bag,
                size: 60,
                color: Color(0xFF512B7C),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₹${item.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Color(0xFF512B7C),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => shopController.addToCart(item),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFD700),
                      foregroundColor: Color(0xFF512B7C),
                      minimumSize: Size(double.infinity, 32),
                    ),
                    child: Text('Add to Cart', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Shopping Cart'),
        content: Obx(() {
          if (shopController.cartItems.isEmpty) {
            return Text('Your cart is empty');
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...shopController.cartItems.map((item) => ListTile(
                title: Text(item.name),
                subtitle: Text('₹${item.price.toStringAsFixed(0)}'),
                trailing: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => shopController.removeFromCart(item),
                ),
              )),
              Divider(),
              Text(
                'Total: ₹${shopController.cartTotal.toStringAsFixed(0)}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          );
        }),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          Obx(() => ElevatedButton(
            onPressed: shopController.cartItems.isEmpty ? null : () {
              Navigator.pop(context);
              Get.snackbar('Order Placed', 'Thank you for your purchase!');
              shopController.cartItems.clear();
            },
            child: Text('Checkout'),
          )),
        ],
      ),
    );
  }
}