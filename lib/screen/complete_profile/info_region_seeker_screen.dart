import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/screen/auth/controller/help_seeker_controller.dart';
import 'package:helpers_hive/utils/routes.dart';
import 'package:helpers_hive/utils/widgets/custom_text_field.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';
import '../../utils/widgets/custom_linear_indicator.dart';

class InfoRegionSeekerScreen extends StatelessWidget {
  InfoRegionSeekerScreen({super.key});
  final HelpSeekerController helpSeekerController = Get.put(HelpSeekerController());

  final TextEditingController _countryController = TextEditingController();
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
                                child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text("Complete Your Profile", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                        const Text(
                          'Rest assured, your personal data is visible only to you. No one else will have access to it.',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        /// Country & Website
                        Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Country*', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 5),
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        errorText:
                                            helpSeekerController.countryError.value.isNotEmpty
                                                ? helpSeekerController.countryError.value
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
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                      ),
                                      value:
                                          helpSeekerController.country.value.isEmpty ? null : helpSeekerController.country.value,
                                      items:
                                          helpSeekerController.countries
                                              .map((country) => DropdownMenuItem<String>(value: country, child: Text(country)))
                                              .toList(),
                                      onChanged: (value) {
                                        helpSeekerController.country.value = value ?? '';
                                        helpSeekerController.countryError.value = '';
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Obx(
                                () => CustomTextField(
                                  label: 'Website',
                                  controller: _websiteController,
                                  errorText:
                                      helpSeekerController.websiteError.value.isNotEmpty
                                          ? helpSeekerController.websiteError.value
                                          : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        /// Address & ZipCode
                        Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => CustomTextField(
                                  label: 'Address*',
                                  controller: _addressController,
                                  errorText:
                                      helpSeekerController.addressError.value.isNotEmpty
                                          ? helpSeekerController.addressError.value
                                          : null,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(child: CustomTextField(label: 'ZipCode', controller: _zipCodeController)),
                          ],
                        ),
                        const SizedBox(height: 24),

                        /// Complete Profile Button
                        NextButton(
                          label: 'Complete Profile',
                          onPressed: () async {
                            // Validation
                            bool isValid = true;

                            if (helpSeekerController.country.value.isEmpty) {
                              helpSeekerController.countryError.value = 'Please enter Country';
                              isValid = false;
                            } else {
                              helpSeekerController.countryError.value = '';
                            }

                            if (_websiteController.text.trim().isNotEmpty && !_websiteController.text.trim().startsWith('http')) {
                              helpSeekerController.websiteError.value = 'Website must start with http or https';
                              isValid = false;
                            } else {
                              helpSeekerController.websiteError.value = '';
                            }

                            if (_addressController.text.trim().isEmpty) {
                              helpSeekerController.addressError.value = 'Please enter Address';
                              isValid = false;
                            } else {
                              helpSeekerController.addressError.value = '';
                            }

                            // if (_zipCodeController.text.trim().isEmpty) {
                            //   helpSeekerController.zipCodeError.value = 'Please enter ZipCode';
                            //   isValid = false;
                            // } else {
                            //   helpSeekerController.zipCodeError.value = '';
                            // }

                            if (!isValid) return;

                            // Assign to controller
                            helpSeekerController.country.value = _countryController.text.trim();
                            helpSeekerController.website.value = _websiteController.text.trim();
                            helpSeekerController.address.value = _addressController.text.trim();
                            helpSeekerController.zipCode.value = _zipCodeController.text.trim();

                            // Continue
                            await helpSeekerController.registerUser(
                              helpSeekerController.email.value,
                              helpSeekerController.password.value,
                            );
                            await helpSeekerController.saveHelpSeekerProfile(role: 'seeker');
                            Get.toNamed(AppRoutes.bottomNav, arguments: 'helpSeeker');
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
}
