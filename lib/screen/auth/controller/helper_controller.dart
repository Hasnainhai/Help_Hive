import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class HelperController extends GetxController {
  final firstName = ''.obs;
  final middleName = ''.obs;
  final lastName = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final phone = ''.obs;
  final selectedGender = ''.obs;
  final briefDescription = ''.obs;
  var selectedJobs = <String>[].obs;
  final firstNameError = ''.obs;
  final middleNameError = ''.obs;
  final lastNameError = ''.obs;
  final emailError = ''.obs;
  final passwordError = ''.obs;
  final confirmPasswordError = ''.obs;
  final phoneError = ''.obs;
  final genderError = ''.obs;
  final descriptionError = ''.obs;
  var jobSelectionError = ''.obs;
  final pickedImage = Rxn<File>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  void toggleJobSelection(String job) {
    if (selectedJobs.contains(job)) {
      selectedJobs.remove(job);
    } else {
      selectedJobs.add(job);
    }
    jobSelectionError.value = ''; // Clear error when user interacts
  }

  Future<void> saveHelperProfile({
    required String role,
    String? displayName,
    String? googleEmail,
  }) async {
    print('saving info');
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    String? imageUrl;

    try {
      // Upload image if picked
      if (pickedImage.value != null) {
        final file = pickedImage.value!;
        final ref = FirebaseStorage.instance.ref().child(
          'profile_images/$uid.jpg',
        );
        await ref.putFile(file);
        imageUrl = await ref.getDownloadURL();
      }
      // Save user info to Firestore
      await FirebaseFirestore.instance.collection('helper').doc(uid).set({
        'firstName': firstName.value,
        'middleName': middleName.value,
        'lastName': lastName.value,
        'name': displayName,
        'email': email.value.isEmpty ? googleEmail : email.value,
        'phone': phone.value,
        'role': role,
        'gender': selectedGender.value,
        'description': briefDescription.value,
        'jonRoles': selectedJobs,
        'image': imageUrl ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving help seeker profile: $e');
    }
  }

  Future<void> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // Successfully created user
      final uid = userCredential.user?.uid;
      print("User created with UID: $uid");
    } catch (e) {
      print("Registration failed: $e");
    }
  }

  bool validateJobSelection() {
    if (selectedJobs.isEmpty) {
      jobSelectionError.value = 'Please select at least one job';
      return false;
    }
    jobSelectionError.value = '';
    return true;
  }

  void clearHelper() {
    firstName.value = '';
    middleName.value = '';
    lastName.value = '';
    email.value = '';
    password.value = '';
    confirmPassword.value = '';
    phone.value = '';
    selectedGender.value = '';
    descriptionError.value = '';
    selectedJobs.value = [];
  }
}
