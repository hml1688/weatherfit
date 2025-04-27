import '../models/clothing.dart';

final List<Clothing> wardrobe = [
  // 上装
  Clothing(name: "短袖T恤", minTemp: 22, maxTemp: 40, isTop: true),
  Clothing(name: "长袖衬衫", minTemp: 18, maxTemp: 25, isTop: true),
  Clothing(name: "薄针织衫", minTemp: 15, maxTemp: 22, isTop: true),
  Clothing(name: "卫衣", minTemp: 10, maxTemp: 18, isTop: true),
  Clothing(name: "毛衣", minTemp: 5, maxTemp: 15, isTop: true),
  Clothing(name: "羊毛衫", minTemp: 1, maxTemp: 10, isTop: true),
  Clothing(name: "西装外套", minTemp: 15, maxTemp: 20, isTop: true),
  Clothing(name: "牛仔夹克", minTemp: 10, maxTemp: 18, isTop: true),
  Clothing(name: "轻羽绒服", minTemp: 0, maxTemp: 10, isTop: true),
  Clothing(name: "厚羽绒服", minTemp: -20, maxTemp: 0, isTop: true), // 修改区间

  // 下装
  Clothing(name: "短裤/裙", minTemp: 22, maxTemp: 40, isTop: false),
  Clothing(name: "薄长裤", minTemp: 15, maxTemp: 25, isTop: false),
  Clothing(name: "牛仔裤", minTemp: 12, maxTemp: 25, isTop: false),
  Clothing(name: "灯芯绒裤", minTemp: 10, maxTemp: 16, isTop: false),
  Clothing(name: "加绒长裤", minTemp: 0, maxTemp: 10, isTop: false),
  Clothing(name: "羽绒裤", minTemp: -20, maxTemp: 0, isTop: false),
];