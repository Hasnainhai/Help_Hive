import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HelpSeekerController extends GetxController {
  final firstName = ''.obs;
  final middleName = ''.obs;
  final lastName = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final companyName = ''.obs;
  final phone = ''.obs;
  final country = ''.obs;
  final website = ''.obs;
  final address = ''.obs;
  final zipCode = ''.obs;
  final firstNameError = RxnString();
  final lastNameError = RxnString();
  final emailError = ''.obs;
  final passwordError = ''.obs;
  final confirmPasswordError = ''.obs;
  final companyNameError = ''.obs;
  final phoneError = ''.obs;
  final countryError = ''.obs;
  final websiteError = ''.obs;
  final addressError = ''.obs;
  final zipCodeError = ''.obs;
  // pass and if files
  final passportFile = Rx<File?>(null);
  final idFile = Rx<File?>(null);
  final passportUrl = ''.obs;
  final idUrl = ''.obs;
  final isUploadingPassport = false.obs;
  final isUploadingId = false.obs;
  final passportError = ''.obs;
  final idError = ''.obs;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<String> countries = [
    'Saudi Arabia',
    'Bahrain',
    'Kuwait',
    'Oman',
    'Qatar',
    'Iraq',
  ];

  bool validateBasicInfo(String firstNameInput, String lastNameInput) {
    bool isValid = true;

    if (firstNameInput.trim().isEmpty) {
      firstNameError.value = 'Please enter First Name';
      isValid = false;
    } else {
      firstNameError.value = null;
    }

    if (lastNameInput.trim().isEmpty) {
      lastNameError.value = 'Please enter Last Name';
      isValid = false;
    } else {
      lastNameError.value = null;
    }

    return isValid;
  }

  void clearHelpSeeker() {
    firstName.value = '';
    middleName.value = '';
    lastName.value = '';
    email.value = '';
    password.value = '';
    companyName.value = '';
    phone.value = '';
    country.value = '';
    website.value = '';
    address.value = '';
    zipCode.value = '';
    passportFile.value = null;
    idFile.value = null;
    passportUrl.value = '';
    idUrl.value = '';
  }

  // upload passport and id files
  Future<void> pickPassport() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        passportFile.value = File(image.path);
        passportError.value = '';
      }
    } catch (e) {
      passportError.value = 'Failed to pick passport image';
    }
  }

  Future<void> pickId() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        idFile.value = File(image.path);
        idError.value = '';
      }
    } catch (e) {
      idError.value = 'Failed to pick ID image';
    }
  }

  Future<String> uploadFile(File file, String path) async {
    try {
      final bytes = await file.readAsBytes();
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putData(bytes);
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw 'Upload failed: ${e.toString()}';
    }
  }

  Future<void> uploadPassport() async {
    if (passportFile.value == null) {
      passportError.value = 'Please select a passport file';
      return;
    }

    try {
      isUploadingPassport.value = true;
      final uid = auth.currentUser?.uid ?? 'unknown';
      passportUrl.value = await uploadFile(
        passportFile.value!,
        'helpSeekers/$uid/passport_${DateTime.now().millisecondsSinceEpoch}',
      );
      passportError.value = '';
    } catch (e) {
      passportError.value = e.toString();
    } finally {
      isUploadingPassport.value = false;
    }
  }

  Future<void> uploadId() async {
    if (idFile.value == null) {
      idError.value = 'Please select an ID file';
      return;
    }

    try {
      isUploadingId.value = true;
      final uid = auth.currentUser?.uid ?? 'unknown';
      idUrl.value = await uploadFile(
        idFile.value!,
        'helpSeekers/$uid/id_${DateTime.now().millisecondsSinceEpoch}',
      );
      idError.value = '';
    } catch (e) {
      idError.value = e.toString();
    } finally {
      isUploadingId.value = false;
    }
  }

  Future<void> saveHelpSeekerProfile({
    required String role,
    String? displayName,
    String? googleEmail,
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    // Verify both documents are uploaded
    if (passportUrl.isEmpty || idUrl.isEmpty) {
      Get.snackbar(
        'Error',
        'Please upload both passport and ID documents',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      await firestore.collection('helpSeeker').doc(uid).set({
        'firstName': firstName.value,
        'middleName': middleName.value,
        'lastName': lastName.value,
        'name': displayName,
        'email': email.value.isEmpty ? googleEmail : email.value,
        'companyName': companyName.value,
        'phone': phone.value,
        'country': country.value,
        'website': website.value,
        'address': address.value,
        'zipCode': zipCode.value,
        'role': role,
        'passportUrl': passportUrl.value,
        'idUrl': idUrl.value,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error saving help seeker profile: $e');
      rethrow;
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
}
