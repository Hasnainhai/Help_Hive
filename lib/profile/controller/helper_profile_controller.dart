import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/employment_model.dart';

class HelperProfileController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  var selectedGender = ''.obs;
  TextEditingController dobController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var selectedRoles = ''.obs;
  final Set<String> selectedJobRoles = {};
  List<EmploymentExperience> experiences = [EmploymentExperience()];

  final firstNameError = ''.obs;
  final middleNameError = ''.obs;
  final lastNameError = ''.obs;
  final genderError = ''.obs;
  final dobError = ''.obs;
  final descriptionError = ''.obs;
  final jobRoleError = ''.obs;
}
