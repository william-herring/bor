import 'package:bor/alerts/form_alert.dart';
import 'package:bor/forms/create_project_form.dart';
import 'package:bor/forms/create_team_form.dart';
import 'package:bor/forms/login_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({Key? key}) : super(key: key);

  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  int selectedTiles = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        backgroundColor: Colors.deepPurpleAccent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))
        ),
        onPressed: () => showFormDialog(
            context,
            const [CreateProjectForm()],
            "Create project"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Text("Projects", style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: 30.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: (selectedTiles > 0)? [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                    color: Colors.deepPurpleAccent,
                    iconSize: 26,
                )
              ] : [],
            ),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                ProjectTile(
                  onSelected: (selected) => setState(() {
                    selectedTiles = selected? selectedTiles + 1 : selectedTiles - 1;
                  }),
                  title: "Very important project",
                  description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  status: Chip(
                    backgroundColor: Colors.green,
                    label: Text("Open", style: GoogleFonts.ubuntu(color: Colors.white)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProjectTile extends StatefulWidget {
  final String title;
  final String description;
  final Widget status;
  final Function onSelected;

  const ProjectTile({Key? key,
    required this.title,
    required this.description,
    required this.status,
    required this.onSelected}) : super(key: key);

  @override
  _ProjectTileState createState() => _ProjectTileState(title, description, status, onSelected);
}

class _ProjectTileState extends State<ProjectTile> {
  final String title;
  final String description;
  final Widget status;
  final Function onSelected;
  bool selected = false;

  _ProjectTileState(this.title, this.description, this.status, this.onSelected);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Checkbox(
        onChanged: (value) {
          onSelected(!selected);
          setState(() {
            selected = value!;
          });
        },
        value: selected,
        activeColor: Colors.deepPurpleAccent,
      ),
      title: Row(
        children: [
          Text(title, style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent)),
          Container(
            margin: const EdgeInsets.only(left: 6.0),
            child: status,
          )
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SelectableText(description, style: GoogleFonts.ubuntu()),
      ),
    );
  }
}

