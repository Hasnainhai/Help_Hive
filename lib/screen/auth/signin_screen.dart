import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helpers_hive/screen/bottom_navigation/bottom_navigation.dart';
import 'package:helpers_hive/utils/widgets/custom_text_field.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../../utils/colors.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  void _signInUser() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email and password cannot be empty',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Sign in the user
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final uid = userCredential.user?.uid;
      if (uid == null) throw Exception('User ID not found');

      // Check if the user exists in helper collection
      final helperDoc =
          await FirebaseFirestore.instance.collection('helper').doc(uid).get();

      // Check if the user exists in helpSeeker collection
      final helpSeekerDoc =
          await FirebaseFirestore.instance
              .collection('helpSeeker')
              .doc(uid)
              .get();

      if (helperDoc.exists) {
        // Navigate to helper dashboard
        Get.offAll(BottomNavScreen(userRole: 'helper'));
      } else if (helpSeekerDoc.exists) {
        // Navigate to helpSeeker dashboard
        Get.offAll(BottomNavScreen(userRole: 'helpSeeker'));
      } else {
        // No matching account found
        Get.snackbar(
          'Unauthorized',
          'No account found for these credentials',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        await FirebaseAuth.instance.signOut();
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Sign-In Failed',
        e.message ?? 'An error occurred',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
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
            child: Column(
              children: [
                Row(
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
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Sign in to your account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Welcome back! You have been missed',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                _buildSignInForm(),
                const SizedBox(height: 32),
                const Text(
                  'Or Continue With',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SignInButton(
                      Buttons.google,
                      onPressed: () {
                        // TODO: Implement Google Sign In
                        _signInWithGoogle();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SignInButton(
                      Buttons.apple,
                      onPressed: () {
                        // TODO: Implement Apple Sign In
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Create new account?"),
                    TextButton(
                      onPressed: () => Get.toNamed('/signup'),
                      child: const Text(
                        "Sign Up",
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
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      isLoading.value = true;

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        isLoading.value = false;
        return; // User cancelled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with Google credentials
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final uid = userCredential.user?.uid;
      if (uid == null) throw Exception('User ID not found');

      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        // If first-time sign in, create user document
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'email': userCredential.user?.email,
          'name': userCredential.user?.displayName,
          'role': 'helpSeeker',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      final role = userDoc.data()?['role'] ?? 'helpSeeker';

      Get.offAll(BottomNavScreen(userRole: role));
    } catch (e) {
      Get.snackbar(
        'Google Sign-In Failed',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Widget _buildSignInForm() {
    return Obx(
      () => Column(
        children: [
          CustomTextField(label: 'Email', controller: _emailController),
          CustomTextField(
            label: 'Password',
            controller: _passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text('Forgot Password?', style: TextStyle(color: primaryBg)),
          ),
          const SizedBox(height: 8),
          isLoading.value
              ? const CircularProgressIndicator()
              : NextButton(label: 'Sign In', onPressed: _signInUser),
        ],
      ),
    );
  }
}
