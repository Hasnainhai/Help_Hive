import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobPostController extends GetxController {
  // Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Dropdown Lists
  final List<String> salaryRanges = [
    'QAR 500 - 1000',
    'QAR 2000 - 3000',
    'QAR 3000 - 4000',
  ];

  final List<String> workingHours = List.generate(
    12,
    (index) => '${index + 1}',
  );

  final List<String> countries = [
    'Saudi Arabia',
    'Bahrain',
    'Kuwait',
    'Oman',
    'Qatar',
    'Iraq',
  ];

  // Observables (reactive values)
  var selectedSalaryRange = RxnString();
  var selectedWorkingHours = RxnString();
  var selectedCountry = RxnString();
  var jobType = 'Full Time'.obs;

  // Methods
  void setRole(String role) {
    titleController.text = role;
  }

  void setJobType(String type) {
    jobType.value = type;
  }

  void setWorkingHours(String hours) {
    selectedWorkingHours.value = hours;
  }

  void setSalaryRange(String range) {
    selectedSalaryRange.value = range;
  }

  void setCountry(String country) {
    selectedCountry.value = country;
  }

  void submitJob() {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedCountry.value == null ||
        selectedSalaryRange.value == null ||
        selectedWorkingHours.value == null) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    // You can replace this with API/Database submission logic
    Get.snackbar("Success", "Job posted successfully");
    Get.back();
  }
}
