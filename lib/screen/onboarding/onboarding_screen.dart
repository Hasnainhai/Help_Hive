import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/screen/bottom_navigation/bottom_navigation.dart';
import 'package:helpers_hive/utils/colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/onboarding.png',
                fit: BoxFit.cover, // Keeps it full screen
                alignment: Alignment.topCenter, // Focus image from top
              ),
            ),
            Positioned(
              bottom:
                  MediaQuery.of(context).viewPadding.bottom +
                  10, // Respect safe area
              left: 20,
              right: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // Get.toNamed(AppRoutes.signup);
                        Get.to(() => BottomNavScreen(userRole: 'helper'));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Let's Get Started",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
