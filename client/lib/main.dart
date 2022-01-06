import 'package:bor/screens/join_team.dart';
import 'package:bor/screens/register.dart';
import 'package:bor/screens/teams.dart';
import 'package:bor/screens/login.dart';
import 'package:flutter/material.dart';

var token;
const serverPort = "http://127.0.0.1:8000";
const dev = true; // REMOVE IN PRODUCTION

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return MaterialApp(
      initialRoute:  token == null? '/login' : '/teams',
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
        '/join': (context) => const JoinTeamScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
