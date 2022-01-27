import 'package:bor/screens/login.dart';
import 'package:bor/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class LoginRegisterView extends StatefulWidget {
  int viewIndex = 0;
  LoginRegisterView({Key? key, viewIndex = 0}) : super(key: key);

  @override
  _LoginRegisterViewState createState() => _LoginRegisterViewState(viewIndex: viewIndex);
}

class _LoginRegisterViewState extends State<LoginRegisterView> {
  int viewIndex = 0;
  late final PageController controller;
  _LoginRegisterViewState({viewIndex = 0});


  @override
  initState() {
    super.initState();
    controller = PageController(initialPage: viewIndex);
  }

  switchView() {
    switch (viewIndex) {
      case 0:
        controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        setState(() {
          viewIndex = 1;
        });
        break;
      case 1:
        controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        setState(() {
          viewIndex = 0;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        leadingWidth: 400,
        leading: Container(
          margin: const EdgeInsets.all(5),
          child: Text(
            "Bor",
            style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.bold,
                fontSize: 46
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: IconButton(onPressed: () { toggleTheme(); setState(() {}); },
                icon: Icon(App.themeNotifier.value == ThemeMode.light? Icons.dark_mode : Icons.light_mode,
                    size: 30.0)
            ),
          ),
        ],
      ),

      body: PageView(
        controller: controller,
        children: [
          LoginScreen(switchView: switchView),
          RegisterScreen(switchView: switchView)
        ],
      ),
    );
  }
}

