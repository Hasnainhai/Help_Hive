import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelperApplicationsController extends GetxController {
  RxString currentFilter = 'All'.obs;
  final List<String> filterOptions = ['All', 'Pending', 'Accepted', 'Rejected'];

  final RxList<Map<String, dynamic>> applications =
      <Map<String, dynamic>>[
        {
          'jobTitle': 'Housekeeper',
          'employer': 'Al Rayyan Family',
          'salary': 'QAR 2,500',
          'location': 'Doha, Qatar',
          'status': 'Pending',
          'appliedDate': '2023-08-01',
          'employerImage': 'assets/images/user1.png',
        },
        {
          'jobTitle': 'Nanny',
          'employer': 'Abdullah Family',
          'salary': 'QAR 3,000',
          'location': 'West Bay, Doha',
          'status': 'Accepted',
          'appliedDate': '2023-07-25',
          'employerImage': 'assets/images/user2.png',
        },
        {
          'jobTitle': 'Cook',
          'employer': 'Mohammed Restaurant',
          'salary': 'QAR 4,000',
          'location': 'Al Sadd, Doha',
          'status': 'Rejected',
          'appliedDate': '2023-07-20',
          'employerImage': 'assets/images/user3.png',
        },
        {
          'jobTitle': 'Driver',
          'employer': 'Al Thani Family',
          'salary': 'QAR 3,500',
          'location': 'The Pearl, Doha',
          'status': 'Pending',
          'appliedDate': '2023-07-30',
          'employerImage': 'assets/images/user4.png',
        },
      ].obs;

  List<Map<String, dynamic>> get filteredApplications {
    if (currentFilter.value == 'All') return applications;
    return applications
        .where((app) => app['status'] == currentFilter.value)
        .toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Accepted':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void changeFilter(String filter) {
    currentFilter.value = filter;
  }

  void removeApplication(Map<String, dynamic> application) {
    applications.remove(application);
  }
}
