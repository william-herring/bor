import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({Key? key}) : super(key: key);

  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.outgoing_mail, color: Colors.white),
        backgroundColor: Colors.deepPurpleAccent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))
        ),
        onPressed: () {}
      ),

      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Text("Members", style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: 30.0)),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: const Icon(
                      Icons.account_circle_sharp,
                      color: Colors.deepPurpleAccent,
                      size: 30.0
                  ),
                  title: Text("wherring", style: GoogleFonts.ubuntu()),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                      Icons.account_circle_sharp,
                      color: Colors.deepPurpleAccent,
                      size: 30.0
                  ),
                  title: Text("testuser", style: GoogleFonts.ubuntu()),
                  onTap: () {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
