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

  // Interval overlap detection method
  bool matchesRange(double dayMin, double dayMax) {
  // Automatically handle the temperature sequence
  final lowerDay = dayMin < dayMax ? dayMin : dayMax;
  final upperDay = dayMin > dayMax ? dayMin : dayMax;

  return (lowerDay <= maxTemp) && (minTemp <= upperDay);
}
}
