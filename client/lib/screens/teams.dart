import 'package:flutter/material.dart';
import '../main.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          token.toString()
        ),
      ),
    );
  }
}
