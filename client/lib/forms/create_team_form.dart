import 'dart:convert';

import 'package:bor/alerts/code_alert.dart';
import 'package:bor/objects/user_obj.dart';
import 'package:bor/utils/common_requests.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CreateTeamForm extends StatefulWidget {
  const CreateTeamForm({Key? key}) : super(key: key);

  @override
  _CreateTeamFormState createState() => _CreateTeamFormState();
}

class _CreateTeamFormState extends State<CreateTeamForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String title = "";
  bool receiveNotifications = false;
  bool emailCode = true;
  late Future<List<User>> searchResult;
  List<User> inviteUsers = [];

  @override
  void initState() {
    searchResult = searchUsers("");
  }

  void handleSubmit() {
    _formKey.currentState!.validate();
    final response = createTeam(title);

    response.then((value) {
      for (var i in inviteUsers) {
        inviteUser(jsonDecode(value.body)["code"], i.email);
      }

      showCodeDialog(context, jsonDecode(value.body)["code"]);
    });
  }

  List<Widget> buildUserTiles(List<User> users) {
    List<Widget> tiles = [];

    for (var i in inviteUsers) {
      final username = i.username;
      final email = i.email;

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
      final email = i.email;

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
          iconColor: Colors.deepPurpleAccent,
          textColor: Colors.black,
          leading: const Icon(Icons.account_circle_sharp, size: 30.0),
          trailing: Text(username, style: GoogleFonts.ubuntu()),
        )
      );
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,

      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Text(
                "Create team",
                style: GoogleFonts.ubuntu(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500
                ),
              ),

              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return "Required field";
                  }

                  if (value.isEmpty) {
                    return "Required field";
                  }

                  setState(() {
                    title = value;
                  });
                },

                maxLength: 75,
                enableSuggestions: false,
                autocorrect: false,
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(),
                decoration: InputDecoration(
                  focusColor: Colors.deepPurpleAccent,
                  labelText: "Title",
                  labelStyle: GoogleFonts.ubuntu(),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurpleAccent)
                  ),
                  floatingLabelStyle: GoogleFonts.ubuntu(
                      color: Colors.deepPurpleAccent
                  ),
                ),

              ),

            CheckboxListTile(
              value: emailCode,
              onChanged: (bool? newValue) {
                setState(() {
                  emailCode = !emailCode;
                });
              },
              activeColor: Colors.deepPurpleAccent,
              title: Text("Show me the invite code", style: GoogleFonts.ubuntu()),
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
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: ElevatedButton(
                      onPressed: () => handleSubmit(),
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
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
