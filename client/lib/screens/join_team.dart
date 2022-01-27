import 'package:bor/views/join_team_stack.dart';
import 'package:bor/objects/team_obj.dart';
import 'package:bor/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JoinTeamScreen extends StatelessWidget {
  final String code;
  const JoinTeamScreen({Key? key, this.code = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        leadingWidth: 400,
        leading: Container(
          margin: const EdgeInsets.all(5),
          child: Text(
            "Bor",
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.bold,
              fontSize: 46
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: IconButton(onPressed: () { toggleTheme(); },
                icon: Icon(App.themeNotifier.value == ThemeMode.light? Icons.dark_mode : Icons.light_mode,
                    size: 30.0)
            ),
          ),
        ],
      ),

      body: Center(
        child: code.isEmpty? const JoinTeamStack() : JoinTeamStack(code: code),
      )
    );
  }
}
