import 'package:flutter/material.dart';
import 'package:flutter_animations/pages/shimmer_loading.dart/shmmer_card.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Shimmer Loading")),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (_, index) => const ShimmerCard(),
      ),
    );
  }
}
