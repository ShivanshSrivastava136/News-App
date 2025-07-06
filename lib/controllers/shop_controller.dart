import 'package:get/get.dart';
import '../models/shop_item_model.dart';

class ShopController extends GetxController {
  var isLoading = true.obs;
  var shopItems = <ShopItemModel>[].obs;
  var cartItems = <ShopItemModel>[].obs;
  var selectedCategory = 'all'.obs;

  static final List<String> categories = [
    'all',
    'jerseys',
    'accessories',
    'caps',
    'souvenirs',
  ];

  @override
  void onInit() {
    loadShopItems();
    super.onInit();
  }

  void loadShopItems() {
    isLoading.value = true;
    
    // Mock data for KKR shop items
    final items = [
      ShopItemModel(
        id: '1',
        name: 'KKR Official Jersey 2024',
        description: 'Official KKR team jersey with player name customization',
        price: 2999.0,
        imageUrl: 'https://via.placeholder.com/300x300?text=KKR+Jersey',
        category: 'jerseys',
      ),
      ShopItemModel(
        id: '2',
        name: 'KKR Purple Cap',
        description: 'Official KKR purple cap with embroidered logo',
        price: 899.0,
        imageUrl: 'https://via.placeholder.com/300x300?text=KKR+Cap',
        category: 'caps',
      ),
      ShopItemModel(
        id: '3',
        name: 'KKR Keychain',
        description: 'Metal keychain with KKR logo',
        price: 299.0,
        imageUrl: 'https://via.placeholder.com/300x300?text=KKR+Keychain',
        category: 'souvenirs',
      ),
      ShopItemModel(
        id: '4',
        name: 'KKR Water Bottle',
        description: 'Insulated water bottle with KKR branding',
        price: 799.0,
        imageUrl: 'https://via.placeholder.com/300x300?text=KKR+Bottle',
        category: 'accessories',
      ),
    ];

    shopItems.value = items;
    isLoading.value = false;
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
  }

  List<ShopItemModel> get filteredItems {
    if (selectedCategory.value == 'all') {
      return shopItems;
    }
    return shopItems.where((item) => item.category == selectedCategory.value).toList();
  }

  void addToCart(ShopItemModel item) {
    cartItems.add(item);
    Get.snackbar('Added to Cart', '${item.name} added to cart');
  }

  void removeFromCart(ShopItemModel item) {
    cartItems.remove(item);
  }

  double get cartTotal {
    return cartItems.fold(0.0, (sum, item) => sum + item.price);
  }
}