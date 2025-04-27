// lib/src/main_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'src/widgets.dart';
import 'weather_screen.dart';
import 'history_screen.dart';

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

// 将原来的 FirstScreen 内容移到这个新组件中
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Main Content Area'),
          const SizedBox(height: 20),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Text(
              '当前温度范围: ${appState.temperatureRange}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}