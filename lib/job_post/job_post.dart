import 'package:flutter/material.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';
import '../utils/colors.dart';
import '../utils/widgets/brief_description.dart';
import '../utils/widgets/custom_text_field.dart';

class JobPost extends StatefulWidget {
  const JobPost({super.key});

  @override
  State<JobPost> createState() => _JobPostState();
}

class _JobPostState extends State<JobPost> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final List<String> salaryRanges = ['QAR 500 - 1000', 'QAR 2000 - 3000', 'QAR 3000 - 4000'];
  final List<String> workingHours = List.generate(12, (index) => '${index + 1}');
  final List<String> countries = ['Saudi Arabia', 'Bahrain', 'Kuwait', 'Oman', 'Qatar', 'Iraq'];
  String? selectedSalaryRange;
  String? selectedWorkingHours;
  String? selectedCountry;
  String jobType = 'Full Time';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post a Job')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Role", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              value: titleController.text.isEmpty ? null : titleController.text,
              hint: const Text("Select Role"),
              items:
                  [
                    'Nanny',
                    'Home Cleaner',
                    'House Maid',
                  ].map((role) => DropdownMenuItem<String>(value: role, child: Text(role))).toList(),
              onChanged: (value) {
                setState(() {
                  titleController.text = value!;
                });
              },
            ),
            CustomBriefDescriptionField(label: "Job Description", controller: descriptionController, maxLength: 500),

            const SizedBox(height: 16),
            const Text("Job Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Full Time'),
                    value: 'Full Time',
                    activeColor: primaryBg,
                    groupValue: jobType,
                    onChanged: (value) {
                      setState(() {
                        jobType = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Part Time'),
                    value: 'Part Time',
                    activeColor: primaryBg,
                    groupValue: jobType,
                    onChanged: (value) {
                      setState(() {
                        jobType = value!;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            const Text("Working Hours", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              value: selectedWorkingHours,
              hint: const Text("Select Working Hours"),
              items:
                  workingHours.map((hour) {
                    return DropdownMenuItem<String>(value: hour, child: Text('$hour Hour${hour == '1' ? '' : 's'}'));
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedWorkingHours = value;
                });
              },
            ),

            const SizedBox(height: 16),
            const Text("Salary Range", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              value: selectedSalaryRange,
              hint: const Text("Select Salary Range"),
              items:
                  salaryRanges.map((range) {
                    return DropdownMenuItem<String>(value: range, child: Text(range));
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSalaryRange = value;
                });
              },
            ),

            const SizedBox(height: 16),
            const Text("Country", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              value: selectedCountry,
              hint: const Text("Select Country"),
              items:
                  countries.map((country) {
                    return DropdownMenuItem<String>(value: country, child: Text(country));
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCountry = value;
                });
              },
            ),

            const SizedBox(height: 20),
            NextButton(
              label: 'Post a Job',
              onPressed: () {
                // Handle submission logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
