import 'dart:math';
import '../models/clothing.dart';
import '../data/wardrobe.dart';

class ClothingRecommender {
  final Random _random = Random();

  Map<String, String> recommend(double dayMin, double dayMax) {
    // 极端温度处理
    if (dayMax > 30) {
      return _summerOutfit();
    }
    if (dayMin < -10) {
      return _winterOutfit();
    }

    // 正常推荐逻辑
    return {
      'top': _pickClothing(dayMin, dayMax, isTop: true),
      'bottom': _pickClothing(dayMin, dayMax, isTop: false),
    };
  }

  String _pickClothing(double dayMin, double dayMax, {required bool isTop}) {
    final candidates = wardrobe.where((item) {
      return item.isTop == isTop && item.matchesRange(dayMin, dayMax);
    }).toList();

    if (candidates.isEmpty) {
      return isTop ? "无合适上衣" : "无合适下装";
    }

    return candidates[_random.nextInt(candidates.length)].name;
  }

  // 夏季固定搭配
  Map<String, String> _summerOutfit() {
    return {
      'top': "短袖T恤",
      'bottom': "短裤/裙",
    };
  }

  // 冬季固定搭配
  Map<String, String> _winterOutfit() {
    return {
      'top': "厚羽绒服",
      'bottom': "羽绒裤",
    };
  }
}