import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../colors.dart'; // Adjust this path as needed

class PhoneField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? errorText;

  const PhoneField({super.key, required this.label, required this.controller, this.errorText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label*", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 5),
          IntlPhoneField(
            controller: controller,
            cursorColor: primaryBg,
            disableLengthCheck: true,
            initialCountryCode: 'US',
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              errorText: errorText,
            ),
            onChanged: (phone) {
              // Do not modify controller.text here
              // Use controller.text = phone.completeNumber in onSaved or when form is submitted
            },
            onSaved: (phone) {
              controller.text = phone?.completeNumber ?? '';
            },
          ),
        ],
      ),
    );
  }
}
