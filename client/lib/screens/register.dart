import 'package:bor/forms/register_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  final Function switchView;
  const RegisterScreen({Key? key, required this.switchView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () => switchView(),

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
