import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

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
      width: 400,
      height: 400,
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
                if (value == null || value.isEmpty) {
                  return "Please enter a valid code";
                }

                if (value.length < 6) {
                  return "Team code must be 6 characters long";
                }

                const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
                var message = "";

                value.split('').forEach((c) => !chars.contains(c) ? message = "Unexpected character: ${c}" : message = message);
                if (message.isNotEmpty) {
                  return message;
                }
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
                  child: IconButton(onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //TODO: Join room logic
                    }
                  },
                      icon: const Icon(Icons.arrow_forward)),
                )
              ],
            )
          ],
        ),
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
