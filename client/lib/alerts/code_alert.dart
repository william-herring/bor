import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showCodeDialog(BuildContext context, String code) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CodeAlert(code: code);
    },
  );
}

class CodeAlert extends StatefulWidget {
  String code;
  CodeAlert({Key? key, required this.code}) : super(key: key);

  @override
  _CodeAlertState createState() => _CodeAlertState(code: code);
}

class _CodeAlertState extends State<CodeAlert> {
  String code;

  _CodeAlertState({required this.code});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Your team code', style: GoogleFonts.ubuntu(color: Colors.deepPurpleAccent)),

      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(code, style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: 30.0)),
        ],
      ),

      actions: <Widget>[
        TextButton(
          child: Text('Go home', style: GoogleFonts.ubuntu(color: Colors.deepPurpleAccent)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),

        IconButton(
          icon: const Icon(Icons.share), onPressed: () {  },
        )
      ],
    );
  }
}