import 'package:flutter/material.dart';
import 'package:play_videos/widgets/custom_video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomVideoPlayer(videoId: "1SkfS5tnSoMjp48QOfaX3J4EgVaYN01R2"),
    );
  }
}
