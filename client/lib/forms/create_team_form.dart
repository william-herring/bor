import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTeamForm extends StatefulWidget {
  const CreateTeamForm({Key? key}) : super(key: key);

  @override
  _CreateTeamFormState createState() => _CreateTeamFormState();
}

class _CreateTeamFormState extends State<CreateTeamForm> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  bool receiveNotifications = false;
  bool createRanks = false;

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
                enableSuggestions: false,
                autocorrect: false,
                textAlign: TextAlign.center,
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
                value: receiveNotifications,
                onChanged: (bool? newValue) {
                  setState(() {
                    receiveNotifications = !receiveNotifications;
                  });
                },
                activeColor: Colors.deepPurpleAccent,
                title: Text("Receive notifications", style: GoogleFonts.ubuntu()),
            ),

            CheckboxListTile(
              value: createRanks,
              onChanged: (bool? newValue) {
                setState(() {
                  createRanks = !createRanks;
                });
              },
              activeColor: Colors.deepPurpleAccent,
              title: Text("Create team ranks", style: GoogleFonts.ubuntu()),
            )
          ],
        ),
      ),
    );
  }
}
