import 'package:flutter/material.dart';
import '../utils/color_ext.dart';

class TagPill extends StatelessWidget {
  final String tag;
  final String priority;
  const TagPill({super.key, required this.tag, required this.priority});

  Color _priorityColor(String p) {
    switch (p.toLowerCase()) {
      case 'high':
        return Colors.redAccent;
      case 'medium':
        return Colors.orangeAccent;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _priorityColor(priority);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
        color: color.withOpacity(0.04),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: color.darken(0.05),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
