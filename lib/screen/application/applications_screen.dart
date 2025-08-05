import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/chat/chat_detail_screen.dart';
import '../../controller/help_seeker/applications_controller.dart';
import 'widgets/application_card.dart';

class ApplicationsScreen extends StatelessWidget {
  final String userRole;

  const ApplicationsScreen({super.key, required this.userRole});

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
          return _buildEmptyState();
        }
        return _buildApplicationList();
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_applications.png', height: 150),
          const SizedBox(height: 20),
          Text('No Applications Yet', style: Get.textTheme.titleLarge),
          const SizedBox(height: 10),
          const Text(
            'Your applications will appear here once you apply to helpers',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Get.theme.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Find Helpers'),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationList() {
    final controller = Get.find<ApplicationsController>();

    return RefreshIndicator(
      onRefresh: () async => controller.fetchApplications(),
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: controller.applications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final application = controller.applications[index];
          return ApplicationCard(
            application: application,
            userRole: userRole,
            onCancel: () => _showCancelDialog(context),
            onMessage:
                () => Get.to(
                  () => ChatDetailScreen(
                    userName: application['name'],
                    userRole: userRole,
                  ),
                ),
          );
        },
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text("Cancel Application"),
        content: const Text(
          "Are you sure you want to cancel this application?",
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("No")),
          ElevatedButton(
            onPressed: () {
              // Call controller method to cancel application
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text("Yes, Cancel"),
          ),
        ],
      ),
    );
  }
}
