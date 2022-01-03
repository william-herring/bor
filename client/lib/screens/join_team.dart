import 'package:bor/nav/join_team_stack.dart';
import 'package:bor/objects/team_obj.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JoinTeamScreen extends StatelessWidget {
  final String code;
  const JoinTeamScreen({Key? key, this.code = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var route = ModalRoute.of(context)?.settings.name;

    print(route);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      ),

      body: Center(
        child: code.isEmpty? const JoinTeamStack() : Text(code),
      )
    );
  }
}
