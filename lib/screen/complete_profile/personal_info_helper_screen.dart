import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/screen/auth/controller/helper_controller.dart';
import 'package:helpers_hive/screen/complete_profile/personal_helper_screen.dart';
import 'package:helpers_hive/utils/widgets/custom_linear_indicator.dart';
import 'package:helpers_hive/utils/widgets/custom_text_field.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';
import 'package:helpers_hive/utils/widgets/phone_field.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final HelperController helperController = Get.put(HelperController());
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      helperController.pickedImage.value = File(
        pickedFile.path,
      ); // 👈 Set in controller
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            // 🔧 Wrap with scroll view
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLinearProgressIndicator(value: 1 / 3),
                const SizedBox(height: 20),
                Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey[200],
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Complete Your Profile",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const Text(
                  'Rest assured, your personal data is visible only to you. No one else will have access to it.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Obx(() {
                    return Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              helperController.pickedImage.value != null
                                  ? FileImage(
                                    helperController.pickedImage.value!,
                                  )
                                  : const AssetImage('assets/images/logo.png')
                                      as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.grey[300],
                              child: const Icon(
                                Icons.edit,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => CustomTextField(
                    label: 'Email*',
                    controller: _emailController,
                    errorText:
                        helperController.emailError.value.isNotEmpty
                            ? helperController.emailError.value
                            : null,
                  ),
                ),
                Obx(
                  () => CustomTextField(
                    label: 'Password',
                    controller: _passwordController,
                    errorText:
                        helperController.passwordError.value.isNotEmpty
                            ? helperController.passwordError.value
                            : null,
                  ),
                ),
                Obx(
                  () => CustomTextField(
                    label: 'Confirm Password',
                    controller: _confirmPasswordController,
                    errorText:
                        helperController.confirmPasswordError.value.isNotEmpty
                            ? helperController.confirmPasswordError.value
                            : null,
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => PhoneField(
                    label: 'Phone',
                    controller: _phoneController,
                    errorText:
                        helperController.phoneError.value.isNotEmpty
                            ? helperController.phoneError.value
                            : null,
                  ),
                ),
                const SizedBox(height: 32), // 👈 Instead of Spacer
                NextButton(
                  label: 'Next',
                  onPressed: () async {
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();
                    final confirmPassword =
                        _confirmPasswordController.text.trim();
                    final phone = _phoneController.text.trim();
                    bool isValid = true;
                    if (email.isEmpty) {
                      helperController.emailError.value = 'Please enter Email';
                      isValid = false;
                    } else {
                      helperController.emailError.value = '';
                    }
                    if (password.isEmpty) {
                      helperController.passwordError.value =
                          'Please enter Password';
                      isValid = false;
                    } else if (password.length < 6) {
                      helperController.passwordError.value =
                          'Password must be at least 6 characters';
                      isValid = false;
                    } else {
                      helperController.passwordError.value = '';
                    }
                    if (confirmPassword.isEmpty) {
                      helperController.confirmPasswordError.value =
                          'Please confirm Password';
                      isValid = false;
                    } else if (confirmPassword != password) {
                      helperController.confirmPasswordError.value =
                          'Passwords do not match';
                      isValid = false;
                    } else {
                      helperController.confirmPasswordError.value = '';
                    }
                    if (phone.isEmpty || phone.length < 10) {
                      helperController.phoneError.value =
                          "Enter a valid phone number";
                    } else {
                      helperController.phoneError.value = '';
                    }
                    if (!isValid) return;
                    final querySnapshot =
                        await helperController.firestore
                            .collection('helper')
                            .where('email', isEqualTo: email)
                            .limit(1)
                            .get();

                    if (querySnapshot.docs.isNotEmpty) {
                      helperController.emailError.value =
                          'An account already exists for this email';
                      return;
                    }
                    helperController.email.value = email;
                    helperController.password.value = password;
                    helperController.confirmPassword.value = confirmPassword;
                    helperController.phone.value = phone;
                    Get.to(PersonalScreen());
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
