import 'package:flutter/material.dart';
import 'package:flutter_animations/pages/flip_card/flit_card.dart';

class FlipCardPage extends StatelessWidget {
  const FlipCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flipping Card')),
      backgroundColor: Colors.grey.shade400,
      body: Center(
        child: FlipCard(front: _buildFrontCard(), back: _buildBackCard()),
      ),
    );
  }

  Widget _buildFrontCard() {
    return Container(
      width: 240,
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        image: const DecorationImage(
          image: NetworkImage("https://i.pravatar.cc/400"),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "Ava Sinclair",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Product Designer", style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      width: 240,
      height: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Bio",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: const Text(
              "I craft delightful product experiences and help teams bring ideas to life. Passionate about clean UX and a11y.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.location_pin, color: Colors.grey),
              SizedBox(width: 4),
              Text("San Francisco, CA", style: TextStyle(fontSize: 14)),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: Colors.deepPurple,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text("Connect", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
