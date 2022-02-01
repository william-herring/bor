import 'dart:convert';

import 'package:bor/alerts/form_alert.dart';
import 'package:bor/objects/user_obj.dart';
import 'package:bor/utils/common_requests.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({Key? key}) : super(key: key);

  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  late Future<List<User>> searchResult;
  List<User> inviteUsers = [];
  
  void initState() {
    super.initState();
    searchResult = searchUsers("");
  }

  List<Widget> buildUserTiles(List<User> users) {
    List<Widget> tiles = [];

    for (var i in inviteUsers) {
      final username = i.username;

      tiles.add(
          ListTile(
            onTap: () {
              setState(() {
                inviteUsers.remove(i);
              });
            },
            tileColor: Colors.deepPurpleAccent,
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.account_circle_sharp, size: 30.0),
            trailing: Text(username, style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.bold
            )),
          )
      );
    }


    for (var i in users) {
      final username = i.username;

      List<String> invitedUsernames = [];
      for (var i in inviteUsers) {
        invitedUsernames.add(i.username);
      }

      if (invitedUsernames.contains(username)) {
        continue;
      }

      tiles.add(
          ListTile(
            onTap: () {
              setState(() {
                inviteUsers.add(i);
              });
            },
            tileColor: Colors.transparent,
            iconColor: getThemeMode() == ThemeMode.dark? Colors.white : Colors.deepPurpleAccent,
            textColor: getThemeMode() == ThemeMode.dark? Colors.white : Colors.black,
            leading: const Icon(Icons.account_circle_sharp, size: 30.0),
            trailing: Text(username, style: GoogleFonts.ubuntu()),
          )
      );
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Text("Members", style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: 30.0)),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: const Icon(
                      Icons.account_circle_sharp,
                      color: Colors.deepPurpleAccent,
                      size: 30.0
                  ),
                  title: Text("wherring", style: GoogleFonts.ubuntu()),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                      Icons.account_circle_sharp,
                      color: Colors.deepPurpleAccent,
                      size: 30.0
                  ),
                  title: Text("testuser", style: GoogleFonts.ubuntu()),
                  onTap: () {},
                )
              ],
            ),

            Container(
              margin: const EdgeInsets.only(top: 26.0),
              child: ExpansionTile(
                textColor: Colors.deepPurpleAccent,
                iconColor: Colors.deepPurpleAccent,
                trailing: const Icon(Icons.person_add),
                title: Text(
                    "Invite users", style: GoogleFonts.ubuntu()
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    //May change to TextFormField
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchResult = searchUsers(value);
                        });
                      },
                      decoration: InputDecoration(
                          icon: const Icon(Icons.search, color: Colors.grey),
                          focusColor: Colors.deepPurpleAccent,
                          iconColor: Colors.deepPurpleAccent,
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurpleAccent)
                          ),
                          prefixStyle: GoogleFonts.ubuntu(color: Colors.deepPurpleAccent),
                          hintText: "Search users"
                      ),
                    ),
                  ),

                  FutureBuilder<List<User>> (
                      future: searchResult,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: buildUserTiles(snapshot.data!),
                          );
                        }

                        return ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: buildUserTiles(inviteUsers),
                        );
                      }
                  ),
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        onPressed: () {
                          for (var i in inviteUsers) {
                            inviteUser(currentTeam.code, i.email);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Invite",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent,
                        ),
                      )
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ElevatedButton(
                  onPressed: () => setState(() {}),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Reload",
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurpleAccent,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
