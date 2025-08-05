import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/utils/colors.dart';

import '../screen/home/job_detail_screen.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Saved Jobs'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) => _buildJobCard(context, index),
        ),
      ),
    );
  }

  Widget _buildJobCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => Get.to(() => JobDetailsScreen(jobIndex: index)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Housekeeper ${index + 1}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Icon(Icons.bookmark_border, color: Colors.grey.shade600),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildIconText(Icons.location_on_outlined, 'Doha, Qatar'),
                  const SizedBox(width: 16),
                  _buildIconText(Icons.work_outline, 'Full-time'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildIconText(Icons.attach_money, 'QAR 2,000 - QAR 3,000'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${index + 2}d ago',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: primaryBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: primaryBg, size: 20),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: Colors.grey.shade700)),
      ],
    );
  }
}
