import 'package:flutter_test/flutter_test.dart';
import '../lib/services/recommender.dart'; // 替换为实际路径

void main() {
  final recommender = ClothingRecommender();

  group('Clothing recommendation test', () {
    test('There should be multiple options for the recommended temperature range of 18-22°C', () {
      final result = recommender.recommend(18, 22);
      
      // Verify the possibility of the coat
      expect(
        ["短袖T恤","长袖衬衫", "薄针织衫", "卫衣", "西装外套", "牛仔夹克"],
        contains(result['top'])
      );
      
      // Verify the possibility of the pants
      expect(
        ["薄长裤", "牛仔裤"],
        contains(result['bottom'])
      );
    });

    test('25°C triggers summer mode', () {
      final result = recommender.recommend(30, 35);
      expect(result['top'], "短袖T恤");
      expect(result['bottom'], "短裤/裙");
    });

    test('-10°C triggers winter mode', () {
      final result = recommender.recommend(-10, -8);
      expect(result['top'], "厚羽绒服");
      expect(result['bottom'], "羽绒裤");
    });
  });
}