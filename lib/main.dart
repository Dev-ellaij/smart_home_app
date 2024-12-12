import 'package:flutter/material.dart';
import 'package:smart_home_app/presentation%20/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
