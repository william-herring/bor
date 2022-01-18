import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamSelectorButton extends StatefulWidget {
  String currentTeamName;
  List<String> teamList;
  TeamSelectorButton({Key? key, this.currentTeamName = "No team selected", this.teamList = const ["No team selected"]}) : super(key: key);

  @override
  _TeamSelectorButtonState createState() => _TeamSelectorButtonState(currentTeamName, teamList);
}

class _TeamSelectorButtonState extends State<TeamSelectorButton> {
  String teamValue = "";
  List<String> teams = ["No team selected"];

  _TeamSelectorButtonState(this.teamValue, this.teams);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 8.0),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          value: teamValue,

            onChanged: (String? value) {
              setState(() {
                teamValue = value!;
              });
            },
            icon: const Icon(Icons.arrow_drop_down_sharp),
            items: teams.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: GoogleFonts.ubuntu()),
                alignment: AlignmentDirectional.centerStart,
              );
            }).toList(),
        ),
      ),
    );
  }
}
