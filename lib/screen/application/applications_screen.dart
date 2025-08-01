import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/help_seeker/applications_controller.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ApplicationsController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My Applications'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.applications.isEmpty) {
          return const Center(child: Text('No applications found.'));
        }

        return ListView.builder(
          itemCount: controller.applications.length,
          itemBuilder: (context, index) {
            final application = controller.applications[index];
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(application['imageUrl']),
                  ),
                  title: Text(application['name']),
                  subtitle: Text(application['role']),
                  trailing: _buildStatusChip(application['status']),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Accepted':
        color = Colors.green;
        break;
      case 'Rejected':
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }
    return Chip(
      label: Text(status, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }
}
