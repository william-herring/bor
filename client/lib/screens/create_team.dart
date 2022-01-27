import 'package:bor/forms/create_team_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class CreateTeamScreen extends StatelessWidget {
  const CreateTeamScreen({Key? key}) : super(key: key);

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
                color: Colors.deepPurpleAccent,
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

      body: const Center(
        child: CreateTeamForm(),
      ),
    );
  }
}
