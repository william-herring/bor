import 'package:bor/screens/create_team.dart';
import 'package:bor/screens/join_team.dart';
import 'package:bor/views/team_view.dart';
import 'package:bor/views/login_register_view.dart';
import 'package:flutter/material.dart';
import 'package:bor/auth/tokens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'objects/team_obj.dart';

// GLOBALS
const apiPort = "http://127.0.0.1:8000";
late SharedPreferences prefs;
String? token = "";
late Team currentTeam;

// Entry point
void main() async {
  prefs = await SharedPreferences.getInstance();
  token = await getToken();
  runApp(const App());
}

// Theme preferences
void toggleTheme() {
  bool isLight = App.themeNotifier.value == ThemeMode.light;
  App.themeNotifier.value = isLight?
  ThemeMode.dark : ThemeMode.light;

  prefs.setString("theme", isLight? "dark" : "light");
}

ThemeMode getThemeMode() {
  final theme = prefs.getString("theme");

  if (theme != null) {
    return theme == "light"? ThemeMode.light : ThemeMode.dark;
  }

  return ThemeMode.system;
}

// App widget
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(getThemeMode());

  @override
  Widget build(context) {
    //ValueListener to handle theme toggle
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode currentMode, widget) {
        //MaterialApp starts here
        return MaterialApp(
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
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
            '/': (context) => const TeamView(),
            '/join': (context) => const JoinTeamScreen(),
            '/create': (context) => const CreateTeamScreen(),
            '/login': (context) => LoginRegisterView(viewIndex: 0),
            '/register': (context) => LoginRegisterView(viewIndex: 1),
          },
        );
      },
    );
  }
}
