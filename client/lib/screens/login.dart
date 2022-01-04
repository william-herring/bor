import 'package:bor/forms/login_form.dart';
import 'package:bor/objects/team_obj.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 400,
          leading: Container(
            margin: const EdgeInsets.all(5),
            child: Text(
              "Bor",
              style: GoogleFonts.ubuntu(
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 46
              ),
            ),
          ),
        ),

        body: const Center(
          child: LoginForm(),
        )
    );
  }
}