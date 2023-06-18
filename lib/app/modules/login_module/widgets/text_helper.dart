import 'package:flutter/material.dart';

class TextHelper extends StatelessWidget {
  final String title;
  final double size;

  const TextHelper({
    super.key,
    required this.title,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Text(
        title,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: size,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
