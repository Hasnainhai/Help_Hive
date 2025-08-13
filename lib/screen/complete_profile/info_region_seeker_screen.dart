import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/screen/auth/controller/help_seeker_controller.dart';
import 'package:helpers_hive/utils/widgets/custom_text_field.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';
import '../../utils/widgets/custom_linear_indicator.dart';
import '../bottom_navigation/bottom_navigation.dart';

class InfoRegionSeekerScreen extends StatelessWidget {
  InfoRegionSeekerScreen({super.key});
  final HelpSeekerController helpSeekerController = Get.find();

  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLinearProgressIndicator(value: 3 / 3),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Get.back(),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey[200],
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Complete Your Profile",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          'Rest assured, your personal data is visible only to you. No one else will have access to it.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        /// Country
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Country*',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  errorText:
                                      helpSeekerController
                                              .countryError
                                              .value
                                              .isNotEmpty
                                          ? helpSeekerController
                                              .countryError
                                              .value
                                          : null,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                ),
                                value:
                                    helpSeekerController.country.value.isEmpty
                                        ? null
                                        : helpSeekerController.country.value,
                                items:
                                    helpSeekerController.countries
                                        .map(
                                          (country) => DropdownMenuItem<String>(
                                            value: country,
                                            child: Text(country),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (value) {
                                  helpSeekerController.country.value =
                                      value ?? '';
                                  helpSeekerController.countryError.value = '';
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Website
                        Obx(
                          () => CustomTextField(
                            label: 'Website',
                            controller: _websiteController,
                            errorText:
                                helpSeekerController
                                        .websiteError
                                        .value
                                        .isNotEmpty
                                    ? helpSeekerController.websiteError.value
                                    : null,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Address
                        Obx(
                          () => CustomTextField(
                            label: 'Address*',
                            controller: _addressController,
                            errorText:
                                helpSeekerController
                                        .addressError
                                        .value
                                        .isNotEmpty
                                    ? helpSeekerController.addressError.value
                                    : null,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // ZipCode
                        CustomTextField(
                          label: 'ZipCode',
                          controller: _zipCodeController,
                        ),
                        const SizedBox(height: 24),

                        // Document Upload Section
                        const Text(
                          'Identity Verification*',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Please upload clear photos of your documents for identity verification',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),

                        // Passport Upload
                        Obx(
                          () => _buildDocumentUpload(
                            label: 'Passport',
                            isUploaded:
                                helpSeekerController.passportUrl.isNotEmpty,
                            file: helpSeekerController.passportFile.value,
                            isLoading:
                                helpSeekerController.isUploadingPassport.value,
                            error: helpSeekerController.passportError.value,
                            onPick: helpSeekerController.pickPassport,
                            onUpload: helpSeekerController.uploadPassport,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ID Upload
                        Obx(
                          () => _buildDocumentUpload(
                            label: 'Id',
                            isUploaded: helpSeekerController.idUrl.isNotEmpty,
                            file: helpSeekerController.idFile.value,
                            isLoading: helpSeekerController.isUploadingId.value,
                            error: helpSeekerController.idError.value,
                            onPick: helpSeekerController.pickId,
                            onUpload: helpSeekerController.uploadId,
                          ),
                        ),
                        const SizedBox(height: 24),

                        /// Complete Profile Button
                        NextButton(
                          label: 'Complete Profile',
                          onPressed: () async {
                            // Validation
                            bool isValid = true;
                            bool documentsUploaded = true;

                            // Country validation
                            if (helpSeekerController.country.value.isEmpty) {
                              helpSeekerController.countryError.value =
                                  'Please select Country';
                              isValid = false;
                            } else {
                              helpSeekerController.countryError.value = '';
                            }

                            // Website validation
                            if (_websiteController.text.trim().isNotEmpty &&
                                !_websiteController.text.trim().startsWith(
                                  'http',
                                )) {
                              helpSeekerController.websiteError.value =
                                  'Website must start with http or https';
                              isValid = false;
                            } else {
                              helpSeekerController.websiteError.value = '';
                            }

                            // Address validation
                            if (_addressController.text.trim().isEmpty) {
                              helpSeekerController.addressError.value =
                                  'Please enter Address';
                              isValid = false;
                            } else {
                              helpSeekerController.addressError.value = '';
                            }

                            // // Document validation
                            // if (helpSeekerController.passportUrl.isEmpty) {
                            //   helpSeekerController.passportError.value =
                            //       'Please upload passport';
                            //   documentsUploaded = false;
                            // }

                            // if (helpSeekerController.idUrl.isEmpty) {
                            //   helpSeekerController.idError.value =
                            //       'Please upload ID';
                            //   documentsUploaded = false;
                            // }

                            if (!isValid) {
                              Get.snackbar(
                                'Missing Information',
                                'Please complete all required fields and upload documents',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              return;
                            }

                            // Assign to controller
                            helpSeekerController.website.value =
                                _websiteController.text.trim();
                            helpSeekerController.address.value =
                                _addressController.text.trim();
                            helpSeekerController.zipCode.value =
                                _zipCodeController.text.trim();

                            // Continue
                            await helpSeekerController.registerUser(
                              helpSeekerController.email.value,
                              helpSeekerController.password.value,
                            );
                            await helpSeekerController.saveHelpSeekerProfile(
                              role: 'helpSeeker',
                            );
                            Get.offAll(
                              () => BottomNavScreen(userRole: 'helpSeeker'),
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentUpload({
    required String label,
    required bool isUploaded,
    required File? file,
    required bool isLoading,
    required String error,
    required VoidCallback onPick,
    required VoidCallback onUpload,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label*',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),

        // Image preview
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isUploaded ? Colors.green : Colors.transparent,
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              if (file != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    file,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              else if (isUploaded)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$label Uploaded',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.photo, size: 40, color: Colors.grey),
                      const SizedBox(height: 8),
                      Text(
                        'No $label selected',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

              if (isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),

        // if (error.isNotEmpty)
        //   Padding(
        //     padding: const EdgeInsets.only(top: 4),
        //     child: Text(
        //       error,
        //       style: const TextStyle(color: Colors.red, fontSize: 12),
        //     ),
        //   ),
        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.photo_library),
                label: Text('Select $label'),
                onPressed: isLoading ? null : onPick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.cloud_upload),
                label: Text('Upload $label'),
                onPressed: (isLoading || file == null) ? null : onUpload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isUploaded ? Colors.green : Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
