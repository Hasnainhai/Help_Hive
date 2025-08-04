import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/next_button.dart';

class JobDetailsScreen extends StatelessWidget {
  final int jobIndex;

  const JobDetailsScreen({super.key, required this.jobIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        actions: [
          IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: primaryBg.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.work_outline,
                  size: 40,
                  color: primaryBg,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Housekeeper $jobIndex',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Doha, Qatar',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Job Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'We are looking for an experienced housekeeper to join our team. The ideal candidate should have at least 2 years of experience in residential cleaning and be familiar with modern cleaning techniques.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            const Text(
              'Responsibilities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildBulletPoint('Perform daily cleaning of residential premises'),
            _buildBulletPoint('Manage laundry and ironing tasks'),
            _buildBulletPoint('Organize and maintain household items'),
            _buildBulletPoint('Prepare light meals when required'),
            const SizedBox(height: 24),
            const Text(
              'Requirements',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildBulletPoint('Minimum 2 years housekeeping experience'),
            _buildBulletPoint('Valid QID and transferable visa'),
            _buildBulletPoint('Good communication skills in English'),
            _buildBulletPoint('Reference letter from previous employer'),
            const SizedBox(height: 24),
            const Text(
              'Salary & Benefits',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildIconDetail(Icons.attach_money, 'QAR 2,500 - 3,000 per month'),
            _buildIconDetail(Icons.flight, 'Annual return ticket'),
            _buildIconDetail(Icons.health_and_safety, 'Health insurance'),
            _buildIconDetail(Icons.house, 'Accommodation provided'),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: NextButton(
          label: 'Apply Now',
          onPressed: () {
            Get.back();
            Get.snackbar(
              'Application Sent',
              'Your application for Housekeeper $jobIndex has been submitted',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          },
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildIconDetail(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: primaryBg),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
