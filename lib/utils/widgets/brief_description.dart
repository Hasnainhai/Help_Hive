import 'package:flutter/material.dart';

class CustomBriefDescriptionField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int? maxLength;
  final String? errorText;

  const CustomBriefDescriptionField({super.key, required this.label, required this.controller, this.maxLength, this.errorText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 5),
          TextField(
            maxLength: maxLength ?? 200,
            maxLines: 4,
            controller: controller,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              errorText: errorText,
            ),
          ),
        ],
      ),
    );
  }
}
