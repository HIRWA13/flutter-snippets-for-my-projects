import 'dart:math';

import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;

  const FlipCard({super.key, required this.front, required this.back});

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  void _flip() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, child) {
          double angle = _animation.value * pi;
          final isBack = angle > (pi / 2);

          return Transform(
            alignment: Alignment.center,
            transform:
                Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // depth
                  ..rotateY(angle),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child:
                  isBack
                      ? Transform(
                        alignment: Alignment.center,
                        // Apply counter-rotation to make back content appear normal
                        transform: Matrix4.identity()..rotateY(pi),
                        child: widget.back,
                      )
                      : widget.front,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
