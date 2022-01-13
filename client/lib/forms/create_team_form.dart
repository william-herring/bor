import 'package:bor/utils/common_requests.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CreateTeamForm extends StatefulWidget {
  const CreateTeamForm({Key? key}) : super(key: key);

  @override
  _CreateTeamFormState createState() => _CreateTeamFormState();
}

class _CreateTeamFormState extends State<CreateTeamForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String title = "";
  bool receiveNotifications = false;
  bool emailCode = true;
  Future<http.Response> searchResult = searchUsers("");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,

      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Text(
                "Create team",
                style: GoogleFonts.ubuntu(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500
                ),
              ),

              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return "Required field";
                  }

                  if (value.isEmpty) {
                    return "Required field";
                  }

                  setState(() {
                    title = value;
                  });
                },

                enableSuggestions: false,
                autocorrect: false,
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(),
                decoration: InputDecoration(
                  focusColor: Colors.deepPurpleAccent,
                  labelText: "Title",
                  labelStyle: GoogleFonts.ubuntu(),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurpleAccent)
                  ),
                  floatingLabelStyle: GoogleFonts.ubuntu(
                      color: Colors.deepPurpleAccent
                  ),
                ),

              ),

            CheckboxListTile(
              value: emailCode,
              onChanged: (bool? newValue) {
                setState(() {
                  emailCode = !emailCode;
                });
              },
              activeColor: Colors.deepPurpleAccent,
              title: Text("Email me the invite code", style: GoogleFonts.ubuntu()),
            ),
            
            CheckboxListTile(
                value: receiveNotifications,
                onChanged: (bool? newValue) {
                  setState(() {
                    receiveNotifications = !receiveNotifications;
                  });
                },
                activeColor: Colors.deepPurpleAccent,
                title: Text("Receive notifications", style: GoogleFonts.ubuntu()),
            ),


            Container(
              margin: const EdgeInsets.only(top: 26.0),
              child: ExpansionTile(
                textColor: Colors.deepPurpleAccent,
                iconColor: Colors.deepPurpleAccent,
                trailing: const Icon(Icons.person_add),
                title: Text(
                  "Invite users", style: GoogleFonts.ubuntu()
                ),
                children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      //May change to TextFormField
                      child: TextField(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.search, color: Colors.grey),
                          focusColor: Colors.deepPurpleAccent,
                          iconColor: Colors.deepPurpleAccent,
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurpleAccent)
                          ),
                          prefixStyle: GoogleFonts.ubuntu(color: Colors.deepPurpleAccent),
                          hintText: "Search users"
                        ),
                      ),
                    ),
                  FutureBuilder<http.Response> (
                    future: searchResult,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!.body);
                      }

                      return Text("No results found");
                    }
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: ElevatedButton(
                      onPressed: () => _formKey.currentState!.validate(),
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
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
