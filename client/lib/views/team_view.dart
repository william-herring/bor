import 'package:bor/auth/tokens.dart';
import 'package:bor/buttons/team_selector_button.dart';
import 'package:bor/objects/team_obj.dart';
import 'package:bor/screens/home.dart';
import 'package:bor/screens/no_team.dart';
import 'package:bor/screens/projects.dart';
import 'package:bor/utils/common_requests.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class TeamView extends StatefulWidget {
  const TeamView({Key? key}) : super(key: key);

  @override
  _TeamViewState createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  Future<String> username = fetchUsername();
  Future<List<Team>> teams = fetchUserTeams();
  late final PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 1);

    teams.then((value) {
      // This function is only called when teams[] is initialized, so we can update the PageView.
      if (value.isEmpty) {
        controller.jumpToPage(0);
      }
    });
  }

  List<String> getTeamNames(List<Team> teams) {
    List<String> result = [];

    for (var i in teams) {
      result.add(i.title);
    }

    return result;
  }

  void _showUserMenu() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(0, 0, 0, 0),
      items: [
        PopupMenuItem<String>(
            child: Text('Settings', style: GoogleFonts.ubuntu()),
            value: 'Settings'
        ),
        PopupMenuItem<String>(
            onTap: () => Future(() {
              deleteToken();
              Navigator.pushReplacementNamed(context, '/login');
            }),
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
                        _showUserMenu();
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
                FutureBuilder<List<Team>>(
                  future: teams,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final teamList = getTeamNames(snapshot.data!);
                      if (teamList.isEmpty) {
                        return TeamSelectorButton();
                      }
                      return TeamSelectorButton(currentTeamName: teamList[0], teamList: teamList);
                    }

                    return const CircularProgressIndicator(color: Colors.deepPurpleAccent);
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.home_filled, color: Colors.deepPurpleAccent, size: 26.0),
                  title: Text("Home", style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500,
                      color: Colors.deepPurpleAccent)),
                  onTap: () => controller.jumpToPage(1),
                ),
                ListTile(
                  trailing: const Icon(Icons.library_books_sharp, size: 26.0),
                  title: Text("Projects", style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500)),
                  onTap: () => controller.jumpToPage(2),
                ),
                ListTile(
                  trailing: const Icon(Icons.dashboard, size: 26.0),
                  title: Text("Team board", style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                ListTile(
                  trailing: const Icon(Icons.task_sharp, size: 26.0),
                  title: Text("Tasks", style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                ListTile(
                  trailing: const Icon(Icons.show_chart, size: 26.0),
                  title: Text("Statistics", style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                ListTile(
                  trailing: const Icon(Icons.people_sharp, size: 26.0),
                  title: Text("Members", style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
              ]
            ),
          ),
        ),
      body: PageView(
        controller: controller,
        children: const [
          NoTeamScreen(), //Index 0 is always reserved for no team display.
          HomeScreen(),
          ProjectListScreen(),
        ],
      ),
    );
  }
}
