import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/screen/complete_profile/job_selection_helper.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/custom_text_field.dart';
import '../../utils/widgets/next_button.dart';
import '../bottom_navigation/bottom_navigation.dart';
import 'auth_service.dart';
import 'controller/helper_controller.dart';

class HelperForm extends StatefulWidget {
  final TabController tabController;
  const HelperForm({super.key, required this.tabController});

  @override
  State<HelperForm> createState() => HelperFormState();
}

class HelperFormState extends State<HelperForm> {
  final helperController = Get.put(HelperController());
  bool agree = false;
  final TextEditingController helperFirstNameController =
      TextEditingController();
  final TextEditingController helperMiddleNameController =
      TextEditingController();
  final TextEditingController helperLastNameController =
      TextEditingController();

  void clearHelperFormField() {
    helperFirstNameController.clear();
    helperMiddleNameController.clear();
    helperLastNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => CustomTextField(
              label: "First Name*",
              controller: helperFirstNameController,
              errorText: helperController.firstNameError.value,
            ),
          ),
          CustomTextField(
            label: "Middle Name",
            controller: helperMiddleNameController,
          ),
          Obx(
            () => CustomTextField(
              label: "Last Name*",
              controller: helperLastNameController,
              errorText: helperController.lastNameError.value,
            ),
          ),
          NextButton(
            label: 'Next',
            onPressed: () {
              Get.to(() => BottomNavScreen(userRole: 'helper'));
              // bool isValid = true;

              // if (helperFirstNameController.text.trim().isEmpty) {
              //   helperController.firstNameError.value = 'First name is required';
              //   isValid = false;
              // } else {
              //   helperController.firstNameError.value = '';
              // }

              // if (helperLastNameController.text.trim().isEmpty) {
              //   helperController.lastNameError.value = 'Last name is required';
              //   isValid = false;
              // } else {
              //   helperController.lastNameError.value = '';
              // }

              // if (isValid) {
              //   helperController.firstName.value = helperFirstNameController.text.trim();
              //   helperController.middleName.value = helperMiddleNameController.text.trim();
              //   helperController.lastName.value = helperLastNameController.text.trim();

              //   if (widget.tabController.index == 0) {
              //     Get.toNamed('/infoSeeker');
              //   } else {
              //     Get.to(PersonalInfoScreen());
              //   }
              // }
            },
          ),
          SizedBox(height: 32),
          const Text(
            'Or Continue With',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 32),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SignInButton(
                Buttons.google,
                text: 'Sign-up With Google',
                onPressed: () async {
                  final user = await GoogleAuthService().signInWithGoogle();
                  if (user != null) {
                    print('The data of the user is : ${user.displayName}');
                    // You can store the data in Firestore or move to another screen
                    print("Google Sign-In successful: ${user.email}");
                    Get.to(
                      JobSelection(
                        displayName: user.displayName,
                        googleEmail: user.email,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SignInButton(
                Buttons.apple,
                text: 'Sign-up With Apple',
                onPressed: () async {
                  try {
                    final credential =
                        await SignInWithApple.getAppleIDCredential(
                          scopes: [
                            AppleIDAuthorizationScopes.email,
                            AppleIDAuthorizationScopes.fullName,
                          ],
                        );

                    final displayName =
                        '${credential.givenName ?? ''} ${credential.familyName ?? ''}'
                            .trim();
                    final email =
                        credential.email ??
                        'hidden@apple.com'; // Apple sometimes hides it

                    print('Apple Sign-in success: $displayName, $email');

                    await helperController.saveHelpSeekerProfile(
                      role: 'seeker',
                      displayName:
                          displayName.isNotEmpty ? displayName : 'Apple User',
                      googleEmail: email,
                    );

                    Get.to(BottomNavScreen(userRole: 'helper'));
                  } catch (e) {
                    print('Apple sign-in failed: $e');
                    Get.snackbar(
                      'Sign-In Failed',
                      'Apple Sign-In was not successful',
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              TextButton(
                onPressed: () {
                  Get.toNamed('/signIn');
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: primaryBg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
