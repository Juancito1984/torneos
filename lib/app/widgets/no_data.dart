import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String title;

  const NoData(this.title, {super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
      child: Text(
        title.toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
