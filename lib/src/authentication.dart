import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({super.key, required this.loggedIn, required this.signOut});

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!loggedIn)
            BlueActionButton(
              onPressed: () => context.push('/sign-in'),
              text: 'Login',
            )
          else
            StyledButton(
              onPressed: signOut,
              child: const Text('Logout'),
            ),
          if (loggedIn)
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: StyledButton(
                onPressed: () => context.push('/profile'),
                child: const Text('Profile'),
              ),
            ),
        ],
      ),
    );
  }
}