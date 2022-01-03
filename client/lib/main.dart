import 'package:bor/screens/join_team.dart';
import 'package:bor/screens/teams.dart';
import 'package:flutter/material.dart';

bool isLoggedOut = true;
const port = "http://127.0.0.1:8000";
const dev = true;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return MaterialApp(
      //initialRoute: isLoggedOut ? '/join' : '/teams', //join to be replaced by login
      onGenerateRoute: (settings) {
        String route = settings.name as String;

        if (route.startsWith('/join/')) {
          String code = route.split('/join/')[1];
          if (code.isEmpty) {
            return MaterialPageRoute(
                builder: (context) {
                  return const JoinTeamScreen();
                }
            );
          }

          return MaterialPageRoute(
              builder: (context) {
                return JoinTeamScreen(code: code);
              }
          );
        }
      },

      title: 'Bor',
      debugShowCheckedModeBanner: false,
      routes: {
        '/teams': (context) => const TeamScreen(),
      },

      home: const JoinTeamScreen(), //Temporary
    );
  }
}
