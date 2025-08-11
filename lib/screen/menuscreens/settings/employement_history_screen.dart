import 'package:flutter/material.dart';

class EmploymentHistoryScreen extends StatelessWidget {
  final List<Map<String, String>> history = [
    {
      "jobTitle": "Nanny",
      "employer": "Smith Family",
      "startDate": "Jan 2023",
      "endDate": "Dec 2023",
      "description":
          "Provided childcare for 2 children, prepared meals, and assisted with homework.",
    },
    {
      "jobTitle": "Elderly Caregiver",
      "employer": "Johnson Family",
      "startDate": "Feb 2022",
      "endDate": "Nov 2022",
      "description":
          "Assisted elderly member with daily tasks, medication, and companionship.",
    },
  ];

  EmploymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employment History"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final job = history[index];
          return Card(
            elevation: 1,
            margin: EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job["jobTitle"] ?? "",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    job["employer"] ?? "",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${job["startDate"]} - ${job["endDate"]}",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  Text(
                    job["description"] ?? "",
                    style: TextStyle(fontSize: 14),
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
