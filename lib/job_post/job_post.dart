import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/menu/job_post_controller.dart';
import '../utils/colors.dart';
import '../utils/widgets/brief_description.dart';
import '../utils/widgets/next_button.dart';

class JobPost extends StatelessWidget {
  const JobPost({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobPostController());

    return Scaffold(
      appBar: AppBar(title: const Text('Post a Job')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Role",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              decoration: _dropdownDecoration(),
              value:
                  controller.titleController.text.isEmpty
                      ? null
                      : controller.titleController.text,
              hint: const Text("Select Role"),
              items:
                  ['Nanny', 'Home Cleaner', 'House Maid']
                      .map(
                        (role) =>
                            DropdownMenuItem(value: role, child: Text(role)),
                      )
                      .toList(),
              onChanged: (value) => controller.setRole(value!),
            ),

            CustomBriefDescriptionField(
              label: "Job Description",
              controller: controller.descriptionController,
              maxLength: 500,
            ),

            const SizedBox(height: 16),
            const Text(
              "Job Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Full Time'),
                      value: 'Full Time',
                      activeColor: primaryBg,
                      groupValue: controller.jobType.value,
                      onChanged: (value) => controller.setJobType(value!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Part Time'),
                      value: 'Part Time',
                      activeColor: primaryBg,
                      groupValue: controller.jobType.value,
                      onChanged: (value) => controller.setJobType(value!),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            const Text(
              "Working Hours",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Obx(
              () => DropdownButtonFormField<String>(
                decoration: _dropdownDecoration(),
                value: controller.selectedWorkingHours.value,
                hint: const Text("Select Working Hours"),
                items:
                    controller.workingHours
                        .map(
                          (hour) => DropdownMenuItem(
                            value: hour,
                            child: Text('$hour Hour${hour == '1' ? '' : 's'}'),
                          ),
                        )
                        .toList(),
                onChanged: (value) => controller.setWorkingHours(value!),
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              "Salary Range",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Obx(
              () => DropdownButtonFormField<String>(
                decoration: _dropdownDecoration(),
                value: controller.selectedSalaryRange.value,
                hint: const Text("Select Salary Range"),
                items:
                    controller.salaryRanges
                        .map(
                          (range) => DropdownMenuItem(
                            value: range,
                            child: Text(range),
                          ),
                        )
                        .toList(),
                onChanged: (value) => controller.setSalaryRange(value!),
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              "Country",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Obx(
              () => DropdownButtonFormField<String>(
                decoration: _dropdownDecoration(),
                value: controller.selectedCountry.value,
                hint: const Text("Select Country"),
                items:
                    controller.countries
                        .map(
                          (country) => DropdownMenuItem(
                            value: country,
                            child: Text(country),
                          ),
                        )
                        .toList(),
                onChanged: (value) => controller.setCountry(value!),
              ),
            ),

            const SizedBox(height: 20),
            NextButton(label: 'Post a Job', onPressed: controller.submitJob),
          ],
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
