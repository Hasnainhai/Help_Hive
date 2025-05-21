import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/screen/auth/controller/helper_controller.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/brief_description.dart';
import '../../utils/widgets/custom_linear_indicator.dart';
import 'controller/profile_controller.dart';

class PersonalScreen extends StatelessWidget {
  HelperController helperController = Get.put(HelperController());
  PersonalScreen({super.key});

  final TextEditingController briefDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // 👈 Important for keyboard to push content
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            // 👈 Makes the whole screen scrollable
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
                const SizedBox(height: 20),
                _buildGenderSelection(),
                Obx(
                  () => CustomBriefDescriptionField(
                    label: 'Brief Description (about yourself)',
                    controller: briefDescriptionController,
                    errorText:
                        helperController.descriptionError.value.isNotEmpty ? helperController.descriptionError.value : null,
                  ),
                ),
                const SizedBox(height: 32),
                NextButton(
                  label: 'Next',
                  onPressed: () {
                    bool isValid = true;

                    if (helperController.selectedGender.value.isEmpty) {
                      helperController.genderError.value = 'Please select a gender';
                      isValid = false;
                    } else {
                      helperController.genderError.value = '';
                    }

                    if (briefDescriptionController.text.trim().isEmpty) {
                      helperController.descriptionError.value = 'Description is required';
                      isValid = false;
                    } else {
                      helperController.descriptionError.value = '';
                    }

                    if (isValid) {
                      helperController.briefDescription.value = briefDescriptionController.text.trim();
                      Get.toNamed('/jobSelection');
                    }
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

Widget _buildGenderSelection() {
  final HelperController helperController = Get.put(HelperController());
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Gender*", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          if (helperController.genderError.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(helperController.genderError.value, style: TextStyle(color: Colors.red, fontSize: 12)),
            ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Radio<String>(
                    activeColor: primaryBg,
                    value: 'Male',
                    groupValue: helperController.selectedGender.value,
                    onChanged: (value) => helperController.selectedGender.value = value!,
                  ),
                  const Text("Male"),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    activeColor: primaryBg,
                    value: 'Female',
                    groupValue: helperController.selectedGender.value,
                    onChanged: (value) => helperController.selectedGender.value = value!,
                  ),
                  const Text("Female"),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
