import 'package:flutter/material.dart';

class RowButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  const RowButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.iconColor  ,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => debugPrint(label),
      icon: Icon(
        icon,
        color: iconColor,
      ),
      label: Text(
        label,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
