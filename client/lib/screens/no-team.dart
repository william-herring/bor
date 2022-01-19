import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoTeamScreen extends StatelessWidget {
  const NoTeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "You're not part of any teams. To begin, join or create a team.",
            style: GoogleFonts.ubuntu(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/join');
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Join",
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurpleAccent,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/create');
            },
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
          ),
        ],
      ),
    );
  }
}
