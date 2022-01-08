import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamSelectorButton extends StatefulWidget {
  String currentTeamName;
  TeamSelectorButton({Key? key, this.currentTeamName = "No team selected"}) : super(key: key);

  @override
  _TeamSelectorButtonState createState() => _TeamSelectorButtonState(currentTeamName);
}

class _TeamSelectorButtonState extends State<TeamSelectorButton> {
  String teamValue = "";

  _TeamSelectorButtonState(this.teamValue);

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
            items: <String>[
              'No team selected', //Need to find a way to change this to the teamValue
              'Test1',
              'Test2',
              'Test3'
            ]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: GoogleFonts.ubuntu()),
              );
            }).toList(),
        ),
      ),
    );
  }
}
