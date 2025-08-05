import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  RxInt selectedOption = 0.obs;
  RxInt? selectedCategoryIndex = RxInt(0);
  RxInt? selectedProfileIndex = RxInt(0);

  // Helper categories
  final List<String> helperCategories = [
    'Housekeeper',
    'Nanny',
    'Cook',
    'Driver',
    'Elderly Care',
    'Gardener',
  ];

  // Helper profiles
  final List<String> helperProfiles = [
    'Primary Profile',
    'Secondary Profile',
    'Specialized Profile',
  ];

  void selectOption(int index) {
    selectedOption.value = index;
  }

  void selectCategory(int? index) {
    selectedCategoryIndex?.value = index!;
  }

  void selectProfile(int? index) {
    selectedProfileIndex?.value = index!;
  }

  void subscribe(String userRole) {
    if (userRole == 'helper') {
      if ((selectedOption.value == 0 && selectedProfileIndex?.value == null) ||
          (selectedOption.value == 1 && selectedCategoryIndex?.value == null)) {
        Get.snackbar(
          'Error',
          'Please select a profile or category',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final selectedType =
          selectedOption.value == 0
              ? 'Profile: ${helperProfiles[selectedProfileIndex!.value]}'
              : 'Category: ${helperCategories[selectedCategoryIndex!.value]}';

      print("Subscribed to: $selectedType");
    } else {
      final plans = ['Monthly', 'Quarterly', 'Yearly'];
      print("Subscribed to: ${plans[selectedOption.value]} plan");
    }

    Get.snackbar(
      'Success',
      'Subscription successful!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
