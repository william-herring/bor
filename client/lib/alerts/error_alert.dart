import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showErrorDialog(BuildContext context, String errorDetails) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return ErrorAlert(details: errorDetails);
    },
  );
}

class ErrorAlert extends StatefulWidget {
  String details;
  ErrorAlert({Key? key, required this.details}) : super(key: key);

  @override
  _ErrorAlertState createState() => _ErrorAlertState(details: details);
}

class _ErrorAlertState extends State<ErrorAlert> {
  bool _expanded = false;
  String details;

  _ErrorAlertState({required this.details});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Oops', style: GoogleFonts.ubuntu(color: Colors.deepPurpleAccent)),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Something went wrong.', style: GoogleFonts.ubuntu()),
            ExpansionPanelList(
              elevation: 0,
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              children: [
                ExpansionPanel(
                    headerBuilder: (context, isOpen) {
                      return Text("Advanced", style: GoogleFonts.ubuntu());
                    },
                    body: Text(details, style: GoogleFonts.ubuntu()),
                    isExpanded: _expanded,
                    canTapOnHeader: true,
                ),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Ok', style: GoogleFonts.ubuntu(color: Colors.deepPurpleAccent)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
