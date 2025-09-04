import 'package:flutter/material.dart';

ScaffoldFeatureController snackBar({
  required String text,
  required BuildContext context,
}) {
  return ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(text)));
}
