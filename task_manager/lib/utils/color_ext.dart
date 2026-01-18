import 'package:flutter/material.dart';

extension ColorUtils on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final f = 1 - amount;
    return Color.fromARGB(
        alpha, (red * f).round(), (green * f).round(), (blue * f).round());
  }
}
