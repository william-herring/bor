import 'package:bor/alerts/form_alert.dart';
import 'package:bor/forms/create_project_form.dart';
import 'package:bor/forms/create_team_form.dart';
import 'package:bor/forms/login_form.dart';
import 'package:bor/objects/project_obj.dart';
import 'package:bor/utils/common_requests.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({Key? key}) : super(key: key);

  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  int selectedTiles = 0;
  Future<List<Project>> projects = fetchProjects();

  void _showMenu(Offset offset) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        PopupMenuItem<String>(
          onTap: () {},
            child: Text('Edit', style: GoogleFonts.ubuntu()),
            value: 'Test'
        ),
        PopupMenuItem<String>(
            onTap: () {},
            child: Text('Delete', style: GoogleFonts.ubuntu()),
            value: 'Test1'
        ),
      ],
      elevation: 8.0,
    );
  }

  List<Widget> buildTiles(List<Project> data) {
    List<Widget> tiles = [];
    for (var i in data) {
      final t = ProjectTile(
          title: i.title,
          description: i.description,
          status: Chip(
            label: Text(i.open? "Open" : "Closed", style: GoogleFonts.ubuntu(color: Colors.white)),
            backgroundColor: i.open? Colors.green : Colors.red,
          ),
          onSelected: (selected) => setState(() {
            selectedTiles = selected? selectedTiles + 1 : selectedTiles - 1;
          }),
      );

      tiles.add(t);
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create, color: Colors.white),
        backgroundColor: Colors.deepPurpleAccent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))
        ),
        onPressed: () => showFormDialog(
            context,
            [CreateProjectForm(onSubmit: () => setState(() {}))], //In future, this should rebuild the list
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
                InkWell(
                  onTap: () {},
                  onTapDown: (details) => _showMenu(details.globalPosition),
                  child: const Icon(Icons.more_vert, color: Colors.deepPurpleAccent, size: 26),
                )
              ] : [],
            ),
            FutureBuilder<List<Project>>(
              future: projects,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator(color: Colors.deepPurpleAccent);
                }
                if (snapshot.data!.isNotEmpty) {
                  return ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: buildTiles(snapshot.data!)
                  );
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("No projects yet",
                        style: GoogleFonts.ubuntu(),
                        ),
                      ),
                      const CircularProgressIndicator(color: Colors.deepPurpleAccent)
                    ],
                  );
                }
              }
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    projects = fetchProjects();
                  }),
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

