import 'package:bor/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String userInput = "";
  String passInput = "";
  final _formKey = GlobalKey<FormState>();
  FocusNode passwordField = FocusNode();


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
              "Log in",
              style: GoogleFonts.ubuntu(
                fontSize: 25.0,
                fontWeight: FontWeight.w500
              ),
            ),

            TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              onFieldSubmitted: (value ) {passwordField.requestFocus();},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Required field.";
                }

                if (value.isNotEmpty) {
                  setState(() {
                    userInput = value;
                  });
                }
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: "Username",
                labelStyle: GoogleFonts.ubuntu(),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurpleAccent)
                ),
                floatingLabelStyle: GoogleFonts.ubuntu(
                  color: Colors.deepPurpleAccent
                ),
              ),

            ),

            TextFormField(
              focusNode: passwordField,
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              onFieldSubmitted: (value) {
                _formKey.currentState!.validate();
                http.post(
                    Uri.parse(serverPort + '/api-token-auth'),
                    headers: { 'Content-Type': 'application/json' },
                    body: {
                      'username': userInput,
                      'password': passInput,
                    }
                );},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Required field.";
                }

                if (value.isNotEmpty) {
                  setState(() {
                    passInput = value;
                  });
                }

                return "Please enter a valid password";
              },

              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: "Password",
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

                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.all(15.0),
                      child: Text(
                        "Forgot password?",
                        style: GoogleFonts.ubuntu(
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    )
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),
                  child: ElevatedButton(
                    onPressed: () {
                        _formKey.currentState!.validate();
                        http.post(
                            Uri.parse(serverPort + '/api-token-auth'),
                            headers: { 'Content-Type': 'application/json' },
                            body: {
                              'username': userInput,
                              'password': passInput,
                            }
                        );
                      },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Log in",
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

