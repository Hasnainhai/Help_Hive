import 'package:flutter/material.dart';
import 'package:helpers_hive/utils/colors.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double? value;

  const CustomLinearProgressIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      minHeight: 8,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      color: primaryBg,
      backgroundColor: Colors.grey[300],
    );
  }
}
