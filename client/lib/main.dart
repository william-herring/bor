import 'package:bor/screens/join_team.dart';
import 'package:bor/screens/teams.dart';
import 'package:flutter/material.dart';

bool isLoggedOut = true;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return MaterialApp(
      initialRoute: isLoggedOut ? '/join' : '/teams',

      title: 'Bor',
      debugShowCheckedModeBanner: false,
      routes: {
        '/join': (context) => const JoinTeamScreen(),
        '/teams': (context) => const TeamScreen(),
      },
    );
  }
}
