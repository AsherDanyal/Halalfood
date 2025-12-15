import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Gradient? gradient;

  const GradientText({
    super.key,
    required this.text,
    this.fontSize = 24.0,
    this.fontWeight = FontWeight.bold,
    this.textAlign = TextAlign.center,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final defaultGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF81C784), // Light green (top)
        Color(0xFF388E3C), // Dark green (bottom)
      ],
    );

    return ShaderMask(
      shaderCallback: (bounds) => (gradient ?? defaultGradient).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.white,
        ),
      ),
    );
  }
}

