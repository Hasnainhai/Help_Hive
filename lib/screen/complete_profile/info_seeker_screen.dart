import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/screen/auth/controller/help_seeker_controller.dart';
import 'package:helpers_hive/utils/widgets/custom_text_field.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';
import 'package:helpers_hive/utils/widgets/phone_field.dart';
import '../../utils/widgets/custom_linear_indicator.dart';

class InfoSeekerScreen extends StatelessWidget {
  InfoSeekerScreen({super.key});

  final HelpSeekerController helpSeekerController = Get.put(HelpSeekerController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLinearProgressIndicator(value: 2 / 3),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Get.back(),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey[200],
                                child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text("Complete Your Profile", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                        const Text(
                          'Rest assured, your personal data is visible only to you. No one else will have access to it.',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Obx(
                          () => CustomTextField(
                            label: 'Email*',
                            controller: _emailController,
                            errorText:
                                helpSeekerController.emailError.value.isNotEmpty ? helpSeekerController.emailError.value : null,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => CustomTextField(
                            label: 'Password*',
                            controller: _passwordController,
                            isPassword: true,
                            errorText:
                                helpSeekerController.passwordError.value.isNotEmpty
                                    ? helpSeekerController.passwordError.value
                                    : null,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => CustomTextField(
                            label: 'Confirm Password*',
                            controller: _confirmPasswordController,
                            isPassword: true,
                            errorText:
                                helpSeekerController.confirmPasswordError.value.isNotEmpty
                                    ? helpSeekerController.confirmPasswordError.value
                                    : null,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => CustomTextField(
                                  label: 'Company Name*',
                                  controller: _companyNameController,
                                  errorText:
                                      helpSeekerController.companyNameError.value.isNotEmpty
                                          ? helpSeekerController.companyNameError.value
                                          : null,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Obx(
                                () => PhoneField(
                                  label: 'Phone',
                                  controller: _phoneController,
                                  errorText:
                                      helpSeekerController.phoneError.value.isNotEmpty
                                          ? helpSeekerController.phoneError.value
                                          : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        NextButton(
                          label: 'Next',
                          onPressed: () async {
                            String email = _emailController.text.trim();
                            String password = _passwordController.text.trim();
                            String confirmPassword = _confirmPasswordController.text.trim();
                            bool isValid = true;

                            // Validation
                            if (email.isEmpty) {
                              helpSeekerController.emailError.value = 'Please enter Email';
                              isValid = false;
                            } else {
                              helpSeekerController.emailError.value = '';
                            }
                            if (password.isEmpty) {
                              helpSeekerController.passwordError.value = 'Please enter Password';
                              isValid = false;
                            } else if (password.length < 6) {
                              helpSeekerController.passwordError.value = 'Password must be at least 6 characters';
                              isValid = false;
                            } else {
                              helpSeekerController.passwordError.value = '';
                            }
                            if (confirmPassword.isEmpty) {
                              helpSeekerController.confirmPasswordError.value = 'Please confirm Password';
                              isValid = false;
                            } else if (confirmPassword != password) {
                              helpSeekerController.confirmPasswordError.value = 'Passwords do not match';
                              isValid = false;
                            } else {
                              helpSeekerController.confirmPasswordError.value = '';
                            }
                            if (_companyNameController.text.trim().isEmpty) {
                              helpSeekerController.companyNameError.value = 'Please enter Company Name';
                              isValid = false;
                            } else {
                              helpSeekerController.companyNameError.value = '';
                            }
                            if (_phoneController.text.trim().isEmpty) {
                              helpSeekerController.phoneError.value = 'Please enter Phone Number';
                              isValid = false;
                            } else {
                              helpSeekerController.phoneError.value = '';
                            }
                            if (!isValid) return;

                            // 🔍 Firestore Email Check
                            final querySnapshot =
                                await helpSeekerController.firestore
                                    .collection('users')
                                    .where('email', isEqualTo: email)
                                    .limit(1)
                                    .get();

                            if (querySnapshot.docs.isNotEmpty) {
                              helpSeekerController.emailError.value = 'An account already exists for this email';
                              return;
                            }

                            // Store validated values
                            helpSeekerController.email.value = email;
                            helpSeekerController.password.value = password;
                            helpSeekerController.companyName.value = _companyNameController.text.trim();
                            helpSeekerController.phone.value = _phoneController.text.trim();

                            // Navigate to next screen
                            Get.toNamed('/locationDetailScreen');
                          },
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
