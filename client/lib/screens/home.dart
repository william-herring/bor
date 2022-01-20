import 'dart:convert';
import 'dart:io';

import 'package:bor/utils/common_requests.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<http.Response> invites = fetchUserInvites();
  int _index = 0;

  List<Step> buildInvites(data) {
    List<Step> steps = [];
    for (var i in data) {
      steps.add(Step(
          title: Text('You were invited to a team', style: GoogleFonts.ubuntu()),
          content: Container(
            alignment: Alignment.centerLeft,
            child: Text("Click continue to proceed to invite", style: GoogleFonts.ubuntu(color: Colors.grey)),
          )
        )
      );
    }

    return steps;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Text("Your feed", style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: 30.0)),
          FutureBuilder<http.Response>(
            future: invites,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final inviteSteps = buildInvites(jsonDecode(snapshot.data!.body));
                if (inviteSteps.isNotEmpty) {
                  return Theme(
                    data: ThemeData(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                            primary: Colors.deepPurpleAccent
                        )
                    ),
                    child: Stepper(
                        currentStep: _index,
                        onStepCancel: () {
                          if (_index > 0) {
                            setState(() {
                              _index -= 1;
                            });
                          }
                        },
                        onStepContinue: () => Navigator.pushNamed(context, '/join/${jsonDecode(snapshot.data!.body)[_index]['join_code']}'),
                        onStepTapped: (int index) {
                          setState(() {
                            _index = index;
                          });
                        },
                        steps: inviteSteps
                    ),
                  );
                } else {
                    return Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Text("Nothing new here", style: GoogleFonts.ubuntu(color: Colors.deepPurpleAccent)),
                    );
                }
              }
              return const CircularProgressIndicator(color: Colors.deepPurpleAccent);
            }
          )
        ],
      ),
    );
  }
}
