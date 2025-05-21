import 'package:flutter/material.dart';
import 'package:helpers_hive/utils/colors.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> savedJobs = [
      {'title': 'Plumber Needed', 'salary': 'QAR 2,500 - QAR 3,200', 'postedAgo': '1d ago'},
      {'title': 'Electrician Required', 'salary': 'QAR 3,000 - QAR 4,000', 'postedAgo': '2d ago'},
      {'title': 'AC Technician', 'salary': 'QAR 2,200 - QAR 3,000', 'postedAgo': '3d ago'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(automaticallyImplyLeading: false, title: const Text('Saved Jobs'), backgroundColor: Colors.white),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: savedJobs.length,
        itemBuilder: (context, index) {
          final job = savedJobs[index];
          return Card(
            elevation: 1,
            // color: Colors.white,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Salary: ${job['salary']}', style: const TextStyle(color: primaryBg)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(job['postedAgo'], style: const TextStyle(color: Colors.black, fontSize: 12)),
                      const SizedBox(width: 8),
                      const Icon(Icons.bookmark, color: Colors.black),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
