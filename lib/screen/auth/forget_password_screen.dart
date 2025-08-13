import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';

import '../../utils/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _isLoading = false.obs;

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => Column(
            children: [
              Text(
                'Enter your email to receive a password reset link',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'Email',
                controller: _emailController,
                isPassword: false,

                // keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              _isLoading.value
                  ? CircularProgressIndicator()
                  : NextButton(
                    label: 'Send Reset Link',
                    onPressed: _sendResetEmail,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendResetEmail() async {
    final email = _emailController.text.trim();

    if (email.isEmpty || !email.isEmail) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      _isLoading.value = true;

      // Use the sendPasswordResetEmail method directly
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // Always show success message for security reasons
      Get.back();
      Get.snackbar(
        'Reset Email Sent',
        'You will receive a password reset link via email. '
            'Please check your inbox',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Failed to send reset email';

      if (e.code == 'invalid-email') {
        message = 'Invalid email address';
      } else if (e.code == 'user-not-found') {
        // Don't reveal that user doesn't exist for security
        message = 'If this email is registered, you will receive a reset link';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many requests. Please try again later';
      } else if (e.code == 'missing-android-pkg-name' ||
          e.code == 'missing-continue-uri') {
        message = 'Configuration error. Please contact support';
      }

      Get.snackbar(
        'Notice',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }
}
