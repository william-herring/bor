import 'package:bor/buttons/team_selector_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(26.0),
              bottomRight: Radius.circular(26.0)
          ),
          child: Drawer(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                Text(
                  "Bor",
                  style: GoogleFonts.ubuntu(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 46
                  ),
                ),
                TeamSelectorButton()
              ]
            ),
          ),
        )
    );
  }
}
