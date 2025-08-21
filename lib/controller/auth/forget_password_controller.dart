import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  Future<void> sendResetEmail() async {
    final email = emailController.text.trim();

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
      isLoading.value = true;
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      Get.back();
      Get.snackbar(
        'Reset Email Sent',
        'You will receive a password reset link via email. Please check your inbox',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    } on FirebaseAuthException catch (e) {
      _handleFirebaseError(e);
    } finally {
      isLoading.value = false;
    }
  }

  void _handleFirebaseError(FirebaseAuthException e) {
    String message = 'Failed to send reset email';

    switch (e.code) {
      case 'invalid-email':
        message = 'Invalid email address';
        break;
      case 'user-not-found':
        message = 'If this email is registered, you will receive a reset link';
        break;
      case 'too-many-requests':
        message = 'Too many requests. Please try again later';
        break;
      case 'missing-android-pkg-name':
      case 'missing-continue-uri':
        message = 'Configuration error. Please contact support';
        break;
    }

    Get.snackbar(
      'Notice',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
