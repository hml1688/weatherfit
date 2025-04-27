// lib/src/main_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'src/widgets.dart';
import 'weather_screen.dart';
import 'history_screen.dart';
import '../services/recommender.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _selectedIndex = 0;

  // 使用 PageStorage 保存页面状态
  final PageStorageBucket _bucket = PageStorageBucket();

  void _updateTemperatureRange(String range) {
    context.read<ApplicationState>().updateTemperatureRange(range);
  }

  late final List<Widget> _screens = [
    WeatherScreen(
      key: const PageStorageKey('weather'),
      onTemperatureRangeUpdate: _updateTemperatureRange,
    ),
    const HomeContent(key: PageStorageKey('home')), // 添加唯一key
  const HistoryScreen(key: PageStorageKey('history')), // 添加唯一key
  ];

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // 用户必须点击按钮才能关闭
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reminder'),
          content: const Text('Are you sure you want to log out of the current account?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Sure'),
              onPressed: () {
                Navigator.of(context).pop(); // 先关闭对话框
                FirebaseAuth.instance.signOut();
                context.go('/');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 新增此行
        title: const Text('Weatherfit'),
        actions: [
          Consumer<ApplicationState>(
            builder: (context, appState, _) => IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _showLogoutConfirmation(context),
            ),
          ),
        ],
      ),
      //body: _screens[_selectedIndex],
      body: PageStorage( // 包裹页面
        bucket: _bucket,
        child: _screens[_selectedIndex],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
    BottomNavigationBarItem( // 第一项：Weather
      icon: Icon(Icons.cloud),
      label: 'Weather',
    ),
    BottomNavigationBarItem( // 第二项：Home
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem( // 第三项：History
      icon: Icon(Icons.history),
      label: 'History',
    ),
  ],
      ),
    );
  }
}

// 在firstscreen.dart的HomeContent组件中
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<ApplicationState>();
    final recommender = ClothingRecommender();
    
    // 从temperatureRange中提取温度范围
    final tempRange = appState.temperatureRange;
    double dayMin = 0.0;
    double dayMax = 0.0;
    
    try {
      if (tempRange.contains('°C ~ ')) {
        final tempValues = tempRange.split('°C ~ ');
        dayMin = double.tryParse(tempValues[0]) ?? 0.0;
        dayMax = double.tryParse(tempValues[1].replaceAll('°C', '')) ?? 0.0;
      }
    } catch (e) {
      print('Error parsing temperature range: $e');
    }

    final outfit = recommender.recommend(dayMin, dayMax);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's recommendation:",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.deepPurple[800],
              fontFamily: 'PlaywriteAUSA',
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Temperature range: $tempRange',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          _buildRecommendationCard(
            "👕 Top",
            outfit['top']!,
            _getClothingImage(outfit['top']!),
          ),
          const SizedBox(height: 20),
          _buildRecommendationCard(
            "👖 Bottoms",
            outfit['bottom']!,
            _getClothingImage(outfit['bottom']!),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(String title, String recommendation, String imagePath) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 20)),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Center(
                      child: Text(
                        recommendation,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      imagePath,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, size: 50);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getClothingImage(String clothingName) {
    // 根据服装名称返回对应的图片路径
    final Map<String, String> imageMap = {
      'short T-shirt': 'assets/clothes/short T.png',
      'T-shirt': 'assets/clothes/T-shirt.jpg',
      'sweater': 'assets/clothes/sweater.jpg',
      'knitwear': 'assets/clothes/knitwear.jpg',
      'hoodies': 'assets/clothes/hoodies.jpg',
      'wool sweater': 'assets/clothes/wool sweater.jpg',
      'suit jacket': 'assets/clothes/suit jacket.jpg',
      'jean jacket': 'assets/clothes/jean jacket.png',
      'light down jacket': 'assets/clothes/light down jacket.png',
      'down jacket': 'assets/clothes/down jacket.jpg',
      'jeans': 'assets/clothes/jeans.jpg',
      'trousers': 'assets/clothes/trousers.jpg',
      'cotton-wadded trousers': 'assets/clothes/cotton-wadded trousers.jpg',
      'fleece pants': 'assets/clothes/fleece pants.jpg',
      'down pants': 'assets/clothes/down pants.png',
      'shorts': 'assets/clothes/shorts.png',
    };

    return imageMap[clothingName] ?? 'assets/clothes/T-shirt.jpg'; // 默认图片
  }
}