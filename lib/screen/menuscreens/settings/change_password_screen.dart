import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/utils/widgets/custom_text_field.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';
import '../../../controller/auth/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Change Password"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              label: 'Current Password',
              controller: controller.currentPasswordController,
              isPassword: true,
            ),

            const SizedBox(height: 12),
            CustomTextField(
              label: 'New Password',
              controller: controller.newPasswordController,
              isPassword: true,
            ),

            const SizedBox(height: 12),
            CustomTextField(
              label: 'Confirm New Password',
              controller: controller.confirmPasswordController,
              isPassword: true,
            ),
            const SizedBox(height: 40),
            Obx(
              () =>
                  controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : NextButton(
                        label: 'Change Password',
                        onPressed: controller.changePassword,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
