import 'package:flutter/material.dart';


class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    required this.style,
  });

  final String text;
  final TextStyle style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}


Center buildTextWinoMeter() {
    return const Center(
      child: GradientText(
        'Win-o-Meter',
        style: TextStyle(fontSize: 16),
        gradient: LinearGradient(colors: [
          Colors.red,
          Colors.deepOrange,
          Colors.orange,
          Colors.amber,
          Colors.lightGreen,
        ]),
      ),
    );
  }