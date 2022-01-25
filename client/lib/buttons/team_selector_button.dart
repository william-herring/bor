import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamSelectorButton extends StatefulWidget {
  String currentTeamName;
  List<String> teamList;
  final Function onSelected;
  TeamSelectorButton({Key? key, this.currentTeamName = "No team selected", this.teamList = const ["No team selected"], required this.onSelected}) : super(key: key);

  @override
  _TeamSelectorButtonState createState() => _TeamSelectorButtonState(currentTeamName, teamList, onSelected);
}

class _TeamSelectorButtonState extends State<TeamSelectorButton> {
  String teamValue = "";
  List<String> teams = ["No team selected"];
  final Function onSelected;

  _TeamSelectorButtonState(this.teamValue, this.teams, this.onSelected);

  void _showSettingsMenu() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(double.infinity, 0, 0, 0),
      items: [
        PopupMenuItem<String>(
            child: Text('Join team', style: GoogleFonts.ubuntu()),
            value: 'Join',
            onTap: () => Future(() => Navigator.pushNamed(context, '/join')),
        ),
        PopupMenuItem<String>(
            child: Text('Create team', style: GoogleFonts.ubuntu()),
            value: 'Create team',
            onTap: () => Future(() => Navigator.pushNamed(context, '/create')),
        ),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
                value: teamValue,

                onChanged: (String? value) {
                  onSelected(value);
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
          IconButton(icon: const Icon(Icons.settings, color: Colors.black45), onPressed: () => _showSettingsMenu()),
        ],
      ),
    );
  }
}
