import 'dart:convert';

import 'package:bor/auth/tokens.dart';
import 'package:bor/forms/validators.dart';
import 'package:bor/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String emailInput = "";
  String userInput = "";
  String passInput = "";
  final _formKey = GlobalKey<FormState>();
  FocusNode userNode = FocusNode();
  FocusNode pass1Node = FocusNode();
  FocusNode pass2Node = FocusNode();

  void handleSubmit() {
    _formKey.currentState!.validate();
    http.post(
        Uri.parse(serverPort + "/api/create-user"),
        headers: { 'Content-Type': 'application/json' },
        body: jsonEncode({
          'email': emailInput,
          'username': userInput,
          'password': passInput,
        })
    );

    http.post(
      Uri.parse(serverPort + "/api-token-auth/"),
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode({
        'username': userInput,
        'password': passInput,
      })
    ).then((value) {
      setToken(storage, json.decode(value.body)['token']);
      //Redirect to home page
    });
  }

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
              "Create an account",
              style: GoogleFonts.ubuntu(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500
              ),
            ),

            TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              onFieldSubmitted: (value){userNode.requestFocus();},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Required field.";
                }

                if (value.isNotEmpty) {
                  var message = validateEmail(value);

                  if (message != null) { return message; }

                  setState(() {
                    emailInput = value;
                  });
                }
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                focusColor: Colors.deepPurpleAccent,
                labelText: "Email",
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
              focusNode: userNode,
              onFieldSubmitted: (value){pass1Node.requestFocus();},
              enableSuggestions: false,
              autocorrect: false,
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
                focusColor: Colors.deepPurpleAccent,
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

            Row(
              children: [
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(right: 6),
                    child: TextFormField(
                      focusNode: pass1Node,
                      onFieldSubmitted: (value){pass2Node.requestFocus();},
                      enableSuggestions: false,
                      autocorrect: false,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required field.";
                        }

                        if (value.isNotEmpty) {
                          setState(() {
                            passInput = value;
                          });
                        } else {
                          return "Please enter a valid password";
                        }
                      },

                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        focusColor: Colors.deepPurpleAccent,
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
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 6),
                    child: TextFormField(
                      focusNode: pass2Node,
                      onFieldSubmitted: (value) => handleSubmit(),
                      enableSuggestions: false,
                      autocorrect: false,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required field.";
                        }

                        if (value.isNotEmpty) {
                          setState(() {
                            passInput = value;
                          });
                        } else {
                          return "Please enter a valid password";
                        }
                      },

                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        focusColor: Colors.deepPurpleAccent,
                        labelText: "Password (again)",
                        labelStyle: GoogleFonts.ubuntu(),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurpleAccent)
                        ),
                        floatingLabelStyle: GoogleFonts.ubuntu(
                            color: Colors.deepPurpleAccent
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 23.0, 15.0, 0.0),
                    child: ElevatedButton(
                      onPressed: () => handleSubmit(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Register",
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