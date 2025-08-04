import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/controller/helper/helper_applications_controller.dart';
import 'package:helpers_hive/screen/menuscreens/helperApplications/helper_applications_details.dart';
import '../../../utils/colors.dart';

class HelperApplicationsScreen extends StatelessWidget {
  HelperApplicationsScreen({super.key});
  final HelperApplicationsController controller = Get.put(
    HelperApplicationsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Applications'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(
                () => Row(
                  children:
                      controller.filterOptions.map((option) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(option),
                            selected: controller.currentFilter.value == option,
                            onSelected: (selected) {
                              controller.changeFilter(
                                selected ? option : 'All',
                              );
                            },
                            backgroundColor: Colors.grey[200],
                            selectedColor: primaryBg.withOpacity(0.2),
                            labelStyle: TextStyle(
                              color:
                                  controller.currentFilter.value == option
                                      ? primaryBg
                                      : Colors.black,
                              fontWeight:
                                  controller.currentFilter.value == option
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Obx(
              () => Row(
                children: [
                  Text(
                    '${controller.filteredApplications.length} applications',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Filter: ${controller.currentFilter.value}',
                    style: TextStyle(
                      color: primaryBg,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () =>
                  controller.filteredApplications.isEmpty
                      ? const Center(
                        child: Text(
                          'No applications found',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: controller.filteredApplications.length,
                        itemBuilder: (context, index) {
                          final application =
                              controller.filteredApplications[index];
                          return _buildApplicationCard(application);
                        },
                      ),
            ),
          ),
        ],
      ),
    );
  }

  // withdraw application widget
  void _withdrawApplication(Map<String, dynamic> application) {
    Get.dialog(
      AlertDialog(
        title: const Text('Withdraw Application'),
        content: Text(
          'Are you sure you want to withdraw your application for '
          '${application['jobTitle']} at ${application['employer']}?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              controller.removeApplication(application);
              Get.back();
              Get.snackbar(
                'Application Withdrawn',
                'Application for ${application['jobTitle']} withdrawn',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              'Withdraw',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // application card widgetw
  Widget _buildApplicationCard(Map<String, dynamic> application) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: AssetImage(application['employerImage']),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        application['jobTitle'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        application['employer'],
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: controller
                        .getStatusColor(application['status'])
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: controller.getStatusColor(application['status']),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    application['status'],
                    style: TextStyle(
                      color: controller.getStatusColor(application['status']),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailItem(Icons.attach_money, application['salary']),
                _buildDetailItem(Icons.location_on, application['location']),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailItem(
              Icons.calendar_today,
              'Applied: ${application['appliedDate']}',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (application['status'] == 'Pending')
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _withdrawApplication(application),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Withdraw Application'),
                    ),
                  ),
                if (application['status'] == 'Accepted')
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          () => Get.to(
                            () => HelperApplicationdetail(
                              application: application,
                            ),
                          ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBg,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'View Details',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // detail item widget
  Widget _buildDetailItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
