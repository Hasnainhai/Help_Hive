import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/screen/auth/controller/help_seeker_controller.dart';

class PassportUploadScreen extends StatelessWidget {
  PassportUploadScreen({super.key});
  final HelpSeekerController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Passport')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Passport Requirements',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Clear photo of your passport\n'
              '• All information must be visible\n'
              '• No glare or reflections\n'
              '• Valid and unexpired document',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.passportFile.value != null) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: FileImage(controller.passportFile.value!),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.photo, size: 50, color: Colors.grey),
                    const SizedBox(height: 10),
                    Text(
                      'No passport selected',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),
            Obx(
              () =>
                  controller.passportError.value.isNotEmpty
                      ? Text(
                        controller.passportError.value,
                        style: const TextStyle(color: Colors.red),
                      )
                      : const SizedBox(),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Select Photo'),
                    onPressed: controller.pickPassport,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (controller.passportFile.value != null)
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.cloud_upload),
                      label: const Text('Upload'),
                      onPressed: controller.uploadPassport,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
              ],
            ),
            const Spacer(),
            Obx(() {
              if (controller.isUploadingPassport.value) {
                return const LinearProgressIndicator();
              }
              if (controller.passportUrl.isNotEmpty) {
                return const Text(
                  '✓ Passport uploaded successfully',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                  textAlign: TextAlign.center,
                );
              }
              return const SizedBox();
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (controller.passportUrl.isNotEmpty) {
                  Get.back();
                } else if (controller.passportFile.value != null) {
                  controller.uploadPassport();
                } else {
                  Get.snackbar(
                    'Missing Document',
                    'Please upload your passport',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
