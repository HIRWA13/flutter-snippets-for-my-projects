import 'package:flutter/material.dart';
import 'dart:ui';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details View', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          // Background radial gradient and blur
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.blueAccent, Colors.black],
                center: Alignment.center,
                radius: 1.2,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),

          // Main content
          SafeArea(
            child: Stack(
              children: [
                // Hero card content
                Center(
                  child: Hero(
                    tag: 'hero-card',
                    child: Material(
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 40,
                          ),
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.asset(
                                  'assets/images/lion.jpg',
                                  height: 180,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Expanded Hero Card',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'This flying card uses Hero animation + backdrop blur + gradient for max effect.',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Back button (top-left)
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pop(); // Automatically reverses the Hero + fade
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
