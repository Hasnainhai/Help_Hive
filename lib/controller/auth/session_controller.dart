import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../screen/bottom_navigation/bottom_navigation.dart';
import '../../screen/onboarding/onboarding_screen.dart';

class SessionController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _checkUserSession();
  }

  Future<void> _checkUserSession() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Check role from Firestore
      final uid = user.uid;

      final helperDoc =
          await FirebaseFirestore.instance.collection('helper').doc(uid).get();
      final helpSeekerDoc =
          await FirebaseFirestore.instance
              .collection('helpSeeker')
              .doc(uid)
              .get();

      if (helperDoc.exists) {
        Get.offAll(() => BottomNavScreen(userRole: 'helper'));
      } else if (helpSeekerDoc.exists) {
        Get.offAll(() => BottomNavScreen(userRole: 'helpSeeker'));
      } else {
        await _auth.signOut();
        Get.offAll(() => const OnboardingScreen());
      }
    } else {
      Get.offAll(() => const OnboardingScreen());
    }
  }
}
