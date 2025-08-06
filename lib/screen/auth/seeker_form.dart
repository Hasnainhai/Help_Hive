import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/screen/auth/signin_screen.dart';
import 'package:helpers_hive/screen/bottom_navigation/bottom_navigation.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/custom_text_field.dart';
import '../../utils/widgets/next_button.dart';
import 'auth_service.dart';
import 'controller/help_seeker_controller.dart';

class HelpSeekerForm extends StatefulWidget {
  final TabController tabController;
  const HelpSeekerForm({super.key, required this.tabController});

  @override
  State<HelpSeekerForm> createState() => _HelpSeekerFormState();
}

class _HelpSeekerFormState extends State<HelpSeekerForm> {
  final HelpSeekerController helpSeekerController = Get.put(
    HelpSeekerController(),
  );
  final TextEditingController helperFirstNameController =
      TextEditingController();
  final TextEditingController helperMiddleNameController =
      TextEditingController();
  final TextEditingController helperLastNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => CustomTextField(
              label: "First Name*",
              controller: helperFirstNameController,
              errorText: helpSeekerController.firstNameError.value,
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
              errorText: helpSeekerController.lastNameError.value,
            ),
          ),
          const SizedBox(height: 20),
          NextButton(
            label: 'Next',
            onPressed: () {
              Get.to(() => BottomNavScreen(userRole: 'helpSeeker'));
              // if (helpSeekerController.validateBasicInfo(
              //   helperFirstNameController.text,
              //   helperLastNameController.text,
              // )) {
              //   helpSeekerController.firstName.value =
              //       helperFirstNameController.text;
              //   helpSeekerController.middleName.value =
              //       helperMiddleNameController.text;
              //   helpSeekerController.lastName.value =
              //       helperLastNameController.text;

              //   if (widget.tabController.index == 0) {
              //     Get.toNamed('/seekerPrimaryInfo');
              //   } else {
              //     Get.toNamed('/personalInfo');
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
                    await helpSeekerController.saveHelpSeekerProfile(
                      role: 'seeker',
                      displayName: user.displayName,
                      googleEmail: user.email,
                    );
                    Get.to(BottomNavScreen(userRole: 'helpSeeker'));
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

                    await helpSeekerController.saveHelpSeekerProfile(
                      role: 'helpSeeker',
                      displayName:
                          displayName.isNotEmpty ? displayName : 'Apple User',
                      googleEmail: email,
                    );

                    Get.to(BottomNavScreen(userRole: 'helpSeeker'));
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
                  Get.to(SignInScreen());
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
