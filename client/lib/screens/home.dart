import 'dart:convert';

import 'package:bor/auth/tokens.dart';
import 'package:bor/buttons/team_selector_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../main.dart';

Future<String> fetchUsername() async {
  token = await getToken();
  final response = await http.get(
    Uri.parse(serverPort + "/api/get-username"),
    headers: { 'Content-Type': 'application/json', 'Authorization': 'Token ${token.toString()}' }
  );

  if (response.statusCode == 200) {
    String username = jsonDecode(response.body)['Username'];

    return username;
  }

  throw Exception('Failed to fetch username');
}


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  Future<String> username = fetchUsername();

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
                    return Row(
                      children: [
                        const Icon(Icons.account_circle_sharp, size: 30.0,),
                        Padding(
                            padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                            child: Text(snapshot.data!.toString(), style: GoogleFonts.ubuntu(fontSize: 16))
                        ),
                      ],
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
        )
    );
  }
}
