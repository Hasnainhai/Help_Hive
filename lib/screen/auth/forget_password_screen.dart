import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';
import 'package:helpers_hive/utils/widgets/custom_text_field.dart';

import '../../controller/auth/forget_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final ForgotPasswordController controller = Get.put(
    ForgotPasswordController(),
  );

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
        child: Column(
          children: [
            Text(
              'Enter your email to receive a password reset link',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Email',
              controller: controller.emailController,
              isPassword: false,
            ),
            const SizedBox(height: 20),
            Obx(
              () =>
                  controller.isLoading.value
                      ? CircularProgressIndicator()
                      : NextButton(
                        label: 'Send Reset Link',
                        onPressed: controller.sendResetEmail,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
