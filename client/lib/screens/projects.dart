import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({Key? key}) : super(key: key);

  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Text("Projects", style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: 30.0)),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              ProjectTile(
                onSelected: () {},
                title: "Very important project",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                    "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                status: Chip(
                  backgroundColor: Colors.green,
                  label: Text("In progress", style: GoogleFonts.ubuntu(color: Colors.white)),
                ),
              )
            ],
          )
        ],
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
          onSelected();
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

