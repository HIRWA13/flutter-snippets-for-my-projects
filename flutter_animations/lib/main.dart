import 'package:flutter/material.dart';
import 'package:flutter_animations/pages/flip_card/flit_card_page.dart';
// import 'package:flutter_animations/pages/glass_dashboard/glass_dashboard.dart';
// import 'package:flutter_animations/pages/shimmer_loading.dart/shimmer_loading.dart';
// import 'package:flutter_animations/pages/animated_cross_fade/animated_cross_fade.dart';
// import 'package:flutter_animations/pages/swipe_to_delete/swipe_to_delete.dart';
// import 'package:flutter_animations/pages/animated_demo.dart';
// import 'package:flutter_animations/pages/hero_animation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: FlipCardPage()
    );
  }
}
