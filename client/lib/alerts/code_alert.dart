import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

Future<void> showCodeDialog(BuildContext context, String code) async {
  return await showDialog<void>(
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
  
  void onShare(BuildContext context) async {
    await Share.share(
        "Join my team at: http://localhost:3000/join/$code or go to http://localhost:3000/join and enter $code.",
        subject: "Join my team on Bor!"
    );
  }

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
          child: Text('Go back', style: GoogleFonts.ubuntu(color: Colors.deepPurpleAccent)),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),

        IconButton(
          icon: const Icon(Icons.share), onPressed: () => onShare(context),
        )
      ],
    );
  }
}