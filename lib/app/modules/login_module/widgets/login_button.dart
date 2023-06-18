import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginButtom extends StatelessWidget {
  final Function()? onPressed;
  final Icon icon;
  final String label;

  const LoginButtom({
    super.key,
    this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(label),
    );
  }
}
