import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/screen/auth/controller/help_seeker_controller.dart';

class IdUploadScreen extends StatelessWidget {
  IdUploadScreen({super.key});
  final HelpSeekerController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload ID')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ID Requirements',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Clear photo of your government-issued ID\n'
              '• Both sides required if applicable\n'
              '• All information must be visible\n'
              '• No glare or reflections\n'
              '• Valid and unexpired document',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.idFile.value != null) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: FileImage(controller.idFile.value!),
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
                      'No ID selected',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),
            Obx(
              () =>
                  controller.idError.value.isNotEmpty
                      ? Text(
                        controller.idError.value,
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
                    onPressed: controller.pickId,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (controller.idFile.value != null)
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.cloud_upload),
                      label: const Text('Upload'),
                      onPressed: controller.uploadId,
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
              if (controller.isUploadingId.value) {
                return const LinearProgressIndicator();
              }
              if (controller.idUrl.isNotEmpty) {
                return const Text(
                  '✓ ID uploaded successfully',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                  textAlign: TextAlign.center,
                );
              }
              return const SizedBox();
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (controller.idUrl.isNotEmpty) {
                  Get.back();
                } else if (controller.idFile.value != null) {
                  controller.uploadId();
                } else {
                  Get.snackbar(
                    'Missing Document',
                    'Please upload your ID',
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
