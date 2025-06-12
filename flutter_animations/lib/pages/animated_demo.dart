import 'package:flutter/material.dart';

class AnimatedPage extends StatefulWidget {
  const AnimatedPage({super.key});

  @override
  State<AnimatedPage> createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<AnimatedPage> {
  bool _toggled = false;
  double _width = 100;
  double _height = 100;
  Color _color = Colors.blue;
  double _radius = 12;
  double _elevation = 4;
  double _turns = 0;
  double _scale = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Animations')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _toggled = !_toggled;
              _width = _toggled ? 200 : 100;
              _height = _toggled ? 200 : 100;
              _color = _toggled ? Colors.blue.shade300 : Colors.blue;
              // shape and shadow
              _radius = _toggled ? 100 : 12;
              _elevation = _toggled ? 20 : 4;
              // rotation and scale
              _turns = _toggled ? .25 : 0;
              _scale = _toggled ? 1.3 : 1;
            });
          },
          child: AnimatedRotation(
            turns: _turns,
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            child: AnimatedScale(
              scale: _scale,
              duration: Duration(milliseconds: 600),
              curve: Curves.easeOutBack,
              child: AnimatedContainer(
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(_radius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: _elevation,
                      spreadRadius: _elevation / 12,
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
