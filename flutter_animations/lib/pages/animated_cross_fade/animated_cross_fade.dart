import 'dart:ui';
import 'package:flutter/material.dart';

class AnimatedCrossFadeDemo extends StatefulWidget {
  const AnimatedCrossFadeDemo({super.key});

  @override
  State<AnimatedCrossFadeDemo> createState() => AnimatedCrossFadeDemoState();
}

class AnimatedCrossFadeDemoState extends State<AnimatedCrossFadeDemo> {
  bool _showLogo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: GestureDetector(
            onTap: () => setState(() => _showLogo = !_showLogo),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: Offset(0, 8),
                  ),
                ],
                backgroundBlendMode: BlendMode.overlay,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: AnimatedCrossFade(
                    firstChild: const FlutterLogo(size: 120),
                    secondChild: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Flutter at 5 AM',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: _showLogo ? 0 : 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Consistency beats intensity.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    crossFadeState:
                        _showLogo
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 900),
                    firstCurve: Curves.easeOutBack,
                    secondCurve: Curves.easeInOut,
                    sizeCurve: Curves.easeInOutCubic,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
