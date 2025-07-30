import 'package:get/get.dart';

class ApplicationsController extends GetxController {
  var applications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchApplications();
  }

  void fetchApplications() {
    applications.value = [
      {
        'name': 'Sarah Khan',
        'role': 'Nanny',
        'status': 'Pending',
        'date': 'July 25, 2025',
        'imageUrl': 'https://via.placeholder.com/150',
      },
      {
        'name': 'Ayesha Malik',
        'role': 'Babysitter',
        'status': 'Accepted',
        'date': 'July 20, 2025',
        'imageUrl': 'https://via.placeholder.com/150',
      },
      {
        'name': 'Fatima Shah',
        'role': 'House Help',
        'status': 'Rejected',
        'date': 'July 15, 2025',
        'imageUrl': 'https://via.placeholder.com/150',
      },
      {
        'name': 'Mehwish Tariq',
        'role': 'Elderly Caregiver',
        'status': 'Pending',
        'date': 'July 28, 2025',
        'imageUrl': 'https://via.placeholder.com/150',
      },
      {
        'name': 'Hina Bukhari',
        'role': 'Cook',
        'status': 'Accepted',
        'date': 'July 18, 2025',
        'imageUrl': 'https://via.placeholder.com/150',
      },
      {
        'name': 'Zara Sheikh',
        'role': 'Pet Sitter',
        'status': 'Rejected',
        'date': 'July 10, 2025',
        'imageUrl': 'https://via.placeholder.com/150',
      },
      {
        'name': 'Asma Javed',
        'role': 'Maid',
        'status': 'Pending',
        'date': 'July 29, 2025',
        'imageUrl': 'https://via.placeholder.com/150',
      },
      {
        'name': 'Rabia Nazeer',
        'role': 'Night Nurse',
        'status': 'Accepted',
        'date': 'July 12, 2025',
        'imageUrl': 'https://via.placeholder.com/150',
      },
    ];
  }
}
