import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/home_view.dart';
import 'views/shop_view.dart';
import 'views/matches_view.dart';
import 'views/players_view.dart';
import 'views/favorites_view.dart';
import 'controllers/news_controller.dart';
import 'controllers/favorites_controller.dart';
import 'controllers/shop_controller.dart';
import 'controllers/matches_controller.dart';
import 'controllers/players_controller.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KKR Fan Page',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Color(0xFF512B7C), // KKR Purple
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF512B7C),
          secondary: Color(0xFFFFD700), // KKR Gold
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF512B7C),
          foregroundColor: Color(0xFFFFD700),
          iconTheme: IconThemeData(color: Color(0xFFFFD700)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      home: MainScreen(),
    );
  }
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NewsController());
    Get.put(FavoritesController());
    Get.put(ShopController());
    Get.put(MatchesController());
    Get.put(PlayersController());
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeView(),
    ShopView(),
    MatchesView(),
    PlayersView(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Color(0xFF512B7C), // KKR Purple
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_cricket),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Players',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}