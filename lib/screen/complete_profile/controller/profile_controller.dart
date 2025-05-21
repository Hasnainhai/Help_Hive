import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  RxList<String> selectedJobs = <String>[].obs;
  Rx<File?> profileImage = Rx<File?>(null);
  TextEditingController descriptionController = TextEditingController();
  var selectedGender = RxString('Female');

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  void toggleJobSelection(String job) {
    if (selectedJobs.contains(job)) {
      selectedJobs.remove(job);
    } else {
      selectedJobs.add(job);
    }
  }
}
