import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'src/authentication.dart';
import 'src/widgets.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (appState.loggedIn) ...[
            const Header('My Favorite'),
            Expanded(
              child: ListView.builder(
                itemCount: appState.favorites.length,
                itemBuilder: (context, index) {
                  final favorite = appState.favorites[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User: ${favorite.userName}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text('Temperature Range: ${favorite.temperatureRange}'),
                          const SizedBox(height: 8),
                          Text('Outfit recommendation: ${favorite.outfit}'),
                          const SizedBox(height: 8),
                          Text(
                            'Time: ${DateTime.fromMillisecondsSinceEpoch(favorite.timestamp).toString()}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
