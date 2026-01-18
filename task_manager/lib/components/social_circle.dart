import 'package:flutter/material.dart';

class SocialCircle extends StatelessWidget {
  final IconData icon;
  const SocialCircle({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      child: Icon(icon, color: Colors.black87),
    );
  }
}
