import 'package:bor/utils/common_requests.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bor/main.dart';

class CreateProjectForm extends StatefulWidget {
  final Function onSubmit;
  const CreateProjectForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _CreateProjectFormState createState() => _CreateProjectFormState(onSubmit);
}

class _CreateProjectFormState extends State<CreateProjectForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";
  bool open = true;
  final Function onSubmit;

  _CreateProjectFormState(this.onSubmit);

  void handleSubmit() {
    final validation = _formKey.currentState!.validate();
    if (validation) {
      createProject(title, description, open);
      onSubmit();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value == null) {
                return "Required field";
              }

              if (value.isEmpty) {
                return "Required field";
              }

              setState(() {
                title = value;
              });
            },

            maxLength: 75,
            enableSuggestions: false,
            autocorrect: false,
            textAlign: TextAlign.center,
            style: GoogleFonts.ubuntu(),
            decoration: InputDecoration(
              focusColor: Colors.deepPurpleAccent,
              labelText: "Title",
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
            validator: (value) {
              if (value == null) {
                return "Required field";
              }

              if (value.isEmpty) {
                return "Required field";
              }

              setState(() {
                description = value;
              });
            },

            maxLength: 150,
            enableSuggestions: false,
            autocorrect: false,
            textAlign: TextAlign.center,
            style: GoogleFonts.ubuntu(),
            decoration: InputDecoration(
              focusColor: Colors.deepPurpleAccent,
              labelText: "Description",
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(8.0),
                child: FilterChip(
                  onSelected: (value) => setState(() {
                    open = !open;
                  }),
                  backgroundColor: Colors.green,
                  checkmarkColor: Colors.white,
                  selected: open,
                  selectedColor: Colors.green,
                  label: Text("Open", style: GoogleFonts.ubuntu(color: Colors.white)),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: FilterChip(
                  onSelected: (value) => setState(() {
                    open = !open;
                  }),
                  backgroundColor: Colors.red,
                  checkmarkColor: Colors.white,
                  selected: !open,
                  selectedColor: Colors.red,
                  label: Text("Closed", style: GoogleFonts.ubuntu(color: Colors.white)),
                ),
              ),
            ],
          ),

          Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: TextButton(
                onPressed: () => handleSubmit(),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Create",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
