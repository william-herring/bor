import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JoinTeamCard extends StatefulWidget {
  const JoinTeamCard({Key? key}) : super(key: key);

  @override
  _JoinTeamCardState createState() => _JoinTeamCardState();
}

class _JoinTeamCardState extends State<JoinTeamCard> {
  String codeInput = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.5),
      width: 500,
      height: 500,
      child: Form(
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
                if (value == null) {
                  return "Please enter a valid code";
                }

                if (value.length < 6 || value.length > 6) {
                  return "Please enter a valid code";
                }
              },

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
                  child: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
