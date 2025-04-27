import '../models/clothing.dart';

final List<Clothing> wardrobe = [
  // jacket
  Clothing(name: "short T-shirt", minTemp: 22, maxTemp: 40, isTop: true),
  Clothing(name: "T-shirt", minTemp: 18, maxTemp: 25, isTop: true),
  Clothing(name: "knitwear", minTemp: 10, maxTemp: 18, isTop: true),
  Clothing(name: "hoodies", minTemp: 15, maxTemp: 22, isTop: true),
  Clothing(name: "sweater", minTemp: 5, maxTemp: 15, isTop: true),
  Clothing(name: "wool sweater", minTemp: 1, maxTemp: 10, isTop: true),
  Clothing(name: "suit jacket", minTemp: 15, maxTemp: 20, isTop: true),
  Clothing(name: "jean jacket", minTemp: 10, maxTemp: 18, isTop: true),
  Clothing(name: "light down jacket", minTemp: 0, maxTemp: 10, isTop: true),
  Clothing(name: "down jacket", minTemp: -20, maxTemp: 0, isTop: true),

  // pants
  Clothing(name: "shorts", minTemp: 22, maxTemp: 40, isTop: false),
  Clothing(name: "trousers", minTemp: 15, maxTemp: 25, isTop: false),
  Clothing(name: "jeans", minTemp: 12, maxTemp: 25, isTop: false),
  Clothing(name: "fleece pants", minTemp: 5, maxTemp: 15, isTop: false),
  Clothing(name: "cotton-wadded trousers", minTemp: 0, maxTemp: 10, isTop: false),
  Clothing(name: "down pants", minTemp: -20, maxTemp: 0, isTop: false),
];