import 'package:flutter/material.dart';

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
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
      ),
    );
  }
}
