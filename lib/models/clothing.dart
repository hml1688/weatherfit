class Clothing {
  final String name;
  final double minTemp;
  final double maxTemp;
  final bool isTop;

  const Clothing({
    required this.name,
    required this.minTemp,
    required this.maxTemp,
    required this.isTop,
  });

  // 区间重叠检测方法
  bool matchesRange(double dayMin, double dayMax) {
    return dayMax >= minTemp && dayMin <= maxTemp;
  }
}
