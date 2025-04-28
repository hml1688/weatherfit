import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';    
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'guest_book_message.dart';   

// Add the login status enumeration
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
        _loggedIn = true;
        _guestBookSubscription = FirebaseFirestore.instance
            .collection('guestbook')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _guestBookMessages = [];
          for (final doc in snapshot.docs) {
            _guestBookMessages.add(
              GuestBookMessage(
                name: doc.data()['name'] as String,
                message: doc.data()['text'] as String,
              ),
            );
          }
          notifyListeners();
        });
        _subscribeToFavorites();
      } else {
        _loggedIn = false;
        _guestBookMessages = [];
        _guestBookSubscription?.cancel();
        _favorites = [];
        _favoritesSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  List<GuestBookMessage> _guestBookMessages = [];
  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

  StreamSubscription<QuerySnapshot>? _favoritesSubscription;
  List<FavoriteItem> _favorites = [];
  List<FavoriteItem> get favorites => _favorites;

  String _temperatureRange = 'Waiting for the update...';
  String get temperatureRange => _temperatureRange;

  void _subscribeToFavorites() {
    _favoritesSubscription = FirebaseFirestore.instance
        .collection('favorites')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      _favorites = [];
      for (final doc in snapshot.docs) {
        _favorites.add(
          FavoriteItem(
            temperatureRange: doc.data()['temperatureRange'] as String,
            outfit: doc.data()['outfit'] as String,
            timestamp: doc.data()['timestamp'] as int,
            userId: doc.data()['userId'] as String,
            userName: doc.data()['userName'] as String,
          ),
        );
      }
      notifyListeners();
    });
  }

  Future<void> addToFavorites(String outfit) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('favorites')
        .add(<String, dynamic>{
      'temperatureRange': _temperatureRange,
      'outfit': outfit,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'userName': FirebaseAuth.instance.currentUser!.displayName ?? 'Anonymous',
    });
  }

  void updateTemperatureRange(String range) {
    _temperatureRange = range;
    notifyListeners();
  }
}