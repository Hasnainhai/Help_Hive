import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

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
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<String> countries = ['Saudi Arabia', 'Bahrain', 'Kuwait', 'Oman', 'Qatar', 'Iraq'];

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
  }

  Future<void> saveHelpSeekerProfile({required String role, String? displayName, String? googleEmail}) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
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
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving help seeker profile: $e');
    }
  }

  Future<void> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Successfully created user
      final uid = userCredential.user?.uid;
      print("User created with UID: $uid");
    } catch (e) {
      print("Registration failed: $e");
    }
  }
}
