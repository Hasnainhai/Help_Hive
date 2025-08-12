import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';
import '../../../controller/auth/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Current Password"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "New Password"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm New Password",
              ),
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
