import 'package:bor/screens/join_team.dart';
import 'package:bor/screens/home.dart';
import 'package:bor/views/login-register-view.dart';
import 'package:flutter/material.dart';
import 'package:bor/auth/tokens.dart';

const serverPort = "http://127.0.0.1:8000";
const dev = true; // REMOVE IN PRODUCTION
String? token = "";

void main() async {
  token = await getToken();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return MaterialApp(
      initialRoute: token == null? '/login' : '/',
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
        '/': (context) => HomeScreen(),
        '/join': (context) => const JoinTeamScreen(),
        '/login': (context) => LoginRegisterView(viewIndex: 0),
        '/register': (context) => LoginRegisterView(viewIndex: 1),
      },
    );
  }
}
