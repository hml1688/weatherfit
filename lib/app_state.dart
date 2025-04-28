import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

// 添加登录状态枚举
enum ApplicationLoginState {
  loggedOut,
  loggedIn,
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        _user = user;
        _temperatureRange = '0°C ~ 0°C';
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        _user = null;
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;
  bool get loggedIn => _loginState == ApplicationLoginState.loggedIn;

  User? _user;
  User? get user => _user;

  String _temperatureRange = '0°C ~ 0°C';
  String get temperatureRange => _temperatureRange;

  // 添加收藏列表
  final List<Map<String, String>> _favoriteOutfits = [];
  List<Map<String, String>> get favoriteOutfits => _favoriteOutfits;

  // 添加收藏方法
  void addFavoriteOutfit(Map<String, String> outfit) {
    _favoriteOutfits.add(outfit);
    notifyListeners();
  }

  // 移除收藏方法
  void removeFavoriteOutfit(int index) {
    if (index >= 0 && index < _favoriteOutfits.length) {
      _favoriteOutfits.removeAt(index);
      notifyListeners();
    }
  }

  void updateTemperatureRange(String range) {
    _temperatureRange = range;
    notifyListeners();
  }
}