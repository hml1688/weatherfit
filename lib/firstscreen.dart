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
    const HomeContent(),
    WeatherScreen(
      key: const PageStorageKey('weather'),
      onTemperatureRangeUpdate: _updateTemperatureRange,
    ),
    const HistoryScreen(),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
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
    final tempValues = tempRange.split('°C ~ ');
    final dayMin = double.tryParse(tempValues[0]) ?? 0.0;
    final dayMax = double.tryParse(tempValues[1].replaceAll('°C', '')) ?? 0.0;

    final outfit = recommender.recommend(dayMin, dayMax);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildRecommendationCard("👕 今日上衣推荐", outfit['top']!),
          const SizedBox(height: 20),
          _buildRecommendationCard("👖 今日下装推荐", outfit['bottom']!),
          const SizedBox(height: 20),
          Text(
            '今日温度范围: $tempRange',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(String title, String recommendation) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 18)),
            const Divider(),
            Text(
              recommendation,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}