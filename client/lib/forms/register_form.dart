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
                  setState(() {
                    emailInput = value;
                  });
                }
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
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
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 6),
                    child: TextFormField(
                      focusNode: pass2Node,
                      onFieldSubmitted: (value){
                        _formKey.currentState!.validate();//please note that this may not be ideal (it's copy pasted from button meaning to change that you need to edit it twice)
                      },
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
                        }

                        return "Please enter a valid password";
                      },

                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
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
                      onPressed: () => _formKey.currentState!.validate(),
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