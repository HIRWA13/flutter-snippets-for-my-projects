import 'package:flutter/material.dart';
// import 'package:flutter_animations/pages/animated_demo.dart';
import 'package:flutter_animations/pages/hero_animation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen()
    );
  }
}
