import 'package:bor/buttons/team_selector_button.dart';
import 'package:bor/utils/common_requests.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  Future<String> username = fetchUsername();

  void _showUserMenu(context) async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(double.infinity, double.negativeInfinity, 100, 100),
      items: [
        PopupMenuItem<String>(
            child: Text('Settings', style: GoogleFonts.ubuntu()), value: 'Details'),
        PopupMenuItem<String>(
            child: Text('Log out', style: GoogleFonts.ubuntu()), value: 'Log out'),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.deepPurpleAccent,
          actions: [
            FutureBuilder<String>(
                future: username,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return InkWell(
                      hoverColor: Colors.white.withOpacity(0),
                      onTap: () {
                        _showUserMenu(context);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.account_circle_sharp, size: 30.0,),
                          Padding(
                              padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                              child: Text(snapshot.data!.toString(), style: GoogleFonts.ubuntu(fontSize: 16))
                          ),
                        ],
                      ),
                    );
                  }
                  return const CircularProgressIndicator(color: Colors.deepPurpleAccent);
                }
            )
          ]
        ),
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
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "You're not part of any teams. To begin, join or create a team.",
              style: GoogleFonts.ubuntu(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/join');
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Join",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Create",
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurpleAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
