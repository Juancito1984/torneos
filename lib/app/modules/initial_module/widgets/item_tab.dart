import 'package:flutter/material.dart';

class ItemTab extends StatelessWidget {
  final IconData icon;
  final String title;

  const ItemTab({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(icon, size: 16.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 13.0),
      ),
    );
  }
}
