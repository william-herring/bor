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
                TeamSelectorButton(),
                ListTile(
                  trailing: const Icon(Icons.home_filled, color: Colors.deepPurpleAccent, size: 36.0),
                  title: Text("Home", style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500, color: Colors.deepPurpleAccent)),
                  onTap: () {},
                ),
                ListTile(
                  trailing: const Icon(Icons.library_books_sharp, size: 36.0),
                  title: Text("Projects", style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                ListTile(
                  trailing: const Icon(Icons.dashboard, size: 36.0),
                  title: Text("Team board", style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                ListTile(
                  trailing: const Icon(Icons.task_sharp, size: 36.0),
                  title: Text("Tasks", style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                ListTile(
                  trailing: const Icon(Icons.show_chart, size: 36.0),
                  title: Text("Statistics", style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                ListTile(
                  trailing: const Icon(Icons.people_sharp, size: 36.0),
                  title: Text("Members", style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500)),
                  onTap: () {},
                )
              ]
            ),
          ),
        )
    );
  }
}
