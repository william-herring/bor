import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showFormDialog(BuildContext context, List<Widget> form, String title) async {
  return await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return FormAlert(form: form, title: title);
    },
  );
}

class FormAlert extends StatelessWidget {
  final List<Widget> form;
  final String title;
  const FormAlert({Key? key, required this.form, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(16.0),
      title: Text(title, style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold)),
      children: form,
    );
  }
}
