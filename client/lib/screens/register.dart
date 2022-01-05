import 'package:bor/forms/register_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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

        floatingActionButton: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },

              child: Container(
                margin: const EdgeInsets.fromLTRB(0.0, 15.0, 0, 15.0),
                child: Text(
                  "Already have an account? Log in",
                  style: GoogleFonts.ubuntu(
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              )
          ),
        ),

        body: const Center(
          child: RegisterForm(),
        )
    );
  }
}
