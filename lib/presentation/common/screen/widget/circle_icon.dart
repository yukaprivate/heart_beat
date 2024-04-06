import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    required this.icon,
    required this.color,
    this.size = 40,
    super.key,
  });

  final IconData icon;
  final Color color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Icon(icon),
    );
  }
}
