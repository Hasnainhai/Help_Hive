import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/screen/auth/controller/helper_controller.dart';
import 'package:helpers_hive/screen/bottom_navigation/bottom_navigation.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/custom_linear_indicator.dart';

class JobSelection extends StatelessWidget {
  final String? displayName;
  final String? googleEmail;
  final HelperController helperController = Get.put(HelperController());
  JobSelection({super.key, this.displayName, this.googleEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CustomLinearProgressIndicator(value: 3 / 3),
              SizedBox(height: 20),
              Container(
                width: Get.width,
                color: Colors.white,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Complete Your Profile",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              Text(
                'Rest assured, your personal data is visible only to you. No one else will have access to it.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildJobSelection(),
              Spacer(),
              NextButton(
                label: 'Complete Profile',
                onPressed: () async {
                  if (helperController.validateJobSelection()) {
                    await helperController.registerUser(
                      helperController.email.value,
                      helperController.password.value,
                    );
                    await helperController.saveHelpSeekerProfile(
                      role: 'helper',
                      displayName: displayName,
                      googleEmail: googleEmail,
                    );
                    Get.to(() => BottomNavScreen(userRole: 'helper'));
                    // Get.toNamed(AppRoutes.bottomNav, arguments: 'helper');
                  }
                },
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildJobSelection() {
  final HelperController helperController = Get.put(HelperController());
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "What describes you best? (select one or more)",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            Obx(
              () => CheckboxListTile(
                activeColor: primaryBg,
                title: const Text("Nanny/Babysitter"),
                value: helperController.selectedJobs.contains(
                  'Nanny/Babysitter',
                ),
                onChanged: (bool? selected) {
                  if (selected != null) {
                    helperController.toggleJobSelection('Nanny/Babysitter');
                  }
                },
              ),
            ),
            Obx(
              () => CheckboxListTile(
                activeColor: primaryBg,
                title: const Text("Home Cleaner"),
                value: helperController.selectedJobs.contains('Home Cleaner'),
                onChanged: (bool? selected) {
                  if (selected != null) {
                    helperController.toggleJobSelection('Home Cleaner');
                  }
                },
              ),
            ),
            Obx(
              () => CheckboxListTile(
                activeColor: primaryBg,
                title: const Text("House Maid"),
                value: helperController.selectedJobs.contains('House Maid'),
                onChanged: (bool? selected) {
                  if (selected != null) {
                    helperController.toggleJobSelection('House Maid');
                  }
                },
              ),
            ),
            Obx(
              () =>
                  helperController.jobSelectionError.value.isNotEmpty
                      ? Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          helperController.jobSelectionError.value,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                      : SizedBox.shrink(),
            ),
          ],
        ),
      ],
    ),
  );
}
