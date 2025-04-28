class GuestBookMessage {
  GuestBookMessage({required this.name, required this.message});

  final String name;
  final String message;
}

class FavoriteItem {
  FavoriteItem({
    required this.temperatureRange,
    required this.outfit,
    required this.timestamp,
    required this.userId,
    required this.userName,
  });

  final String temperatureRange;
  final String outfit;
  final int timestamp;
  final String userId;
  final String userName;
}