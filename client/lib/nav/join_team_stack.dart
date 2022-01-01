import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:bor/main.dart';
import 'package:bor/objects/team_obj.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class JoinTeamStack extends StatefulWidget {
  const JoinTeamStack({Key? key}) : super(key: key);

  @override
  _JoinTeamStackState createState() => _JoinTeamStackState();
}

class _JoinTeamStackState extends State<JoinTeamStack> {
  String codeInput = "";
  int stackIndex = 0;
  final _formKey = GlobalKey<FormState>();
  late Future<Team> requestedTeam;
  bool isTeamInitialized = false;

  Future<Team> fetchTeam(code) async {
    final response = await http.get(
        Uri.parse(port + "/api/get-team?code=$code"),
        headers: { 'Content-Type': 'application/json' }
    );

    if (response.statusCode == 200) {
      return Team.fromJson(jsonDecode(response.body));
    }

    throw Exception('Failed to load team data');
  }

  String getTeamCode() {
    var code = "";
    requestedTeam.then((value) => code = value.code);
    return code;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.5),
      width: 400,
      height: 400,
      child: IndexedStack(
        index: stackIndex,
        key: ValueKey<int>(stackIndex),

        children: [
          Form(
            key:_formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter your team code",
                  style: GoogleFonts.ubuntu(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500
                  )
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a valid code";
                    }

                    if (value.length < 6) {
                      setState(() {
                        codeInput = value;
                      });
                      return "Team code must be 6 characters long";
                    }

                    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
                    var message = "";

                    value.split('').forEach((c) => !chars.contains(c) ? message = "Unexpected character: $c" : message = message);
                    if (message.isNotEmpty) {
                      setState(() {
                        codeInput = value;
                      });
                      return message;
                    }


                    //Everything from this point could be far more efficient. At the moment, it has to send two identical requests.
                    Future<Team> team = fetchTeam(value).then((v) {
                      setState(() {
                        requestedTeam = fetchTeam(value);
                        isTeamInitialized = true;
                        codeInput = value;
                        stackIndex += 1;
                      });
                      return v;
                    }).onError((error, stackTrace) {
                      return fetchTeam(value);
                    });

                    return "Please enter a valid code";
                  },

                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    UpperCaseTextFormatter()
                  ],
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "Eg. AX3D70",
                    labelStyle: GoogleFonts.ubuntu(),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurpleAccent)
                    ),
                    floatingLabelStyle: GoogleFonts.ubuntu(
                      color: Colors.deepPurpleAccent
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: IconButton(onPressed: () => _formKey.currentState!.validate(),
                          icon: const Icon(Icons.arrow_forward)),
                    ),
                  ],
                )
              ],
            ),
          ),

          /* Index 1: This stack contains a FutureBuilder widget.
          The FutureBuilder builds the join card when the requestedTeam Future is initialized.
           */
          isTeamInitialized? FutureBuilder<Team>(
              future: requestedTeam,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Text(
                              snapshot.data!.title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ubuntu(
                                fontSize: 60.0,
                                fontWeight: FontWeight.bold,
                              )
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {},
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
                        ],
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  setState(() {
                    stackIndex = 0;
                  });
                }

                return const CircularProgressIndicator(color: Colors.deepPurpleAccent);
              }
          ) : const Text("Something went wrong, please try again.")
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
