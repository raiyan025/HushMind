import 'package:flutter/material.dart';

class WriteEntryPage extends StatelessWidget {
  const WriteEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
