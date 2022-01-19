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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Text("Your feed", style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: 30.0)),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              FutureBuilder<http.Response>(
                future: invites,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SelectableText(snapshot.data!.body);
                  }
                  return Placeholder();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
