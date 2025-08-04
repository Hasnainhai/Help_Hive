import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/menu/notifications_controller.dart';
import 'widgets/notifications_widget.dart';

class NotificationsScreen extends StatelessWidget {
  final String userRole;

  const NotificationsScreen({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    final NotificationsController controller = Get.put(
      NotificationsController(userRole),
      tag: userRole, // Unique tag for each role
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(() {
        final notifications = controller.notifications;

        return notifications.isEmpty
            ? Center(
              child: Text(
                'No notifications',
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
              ),
            )
            : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                return NotificationCard(
                  title: item["title"]!,
                  subtitle: item["subtitle"]!,
                  time: item["time"]!,
                  type: item["type"]!,
                  userRole: userRole,
                  controller: controller,
                );
              },
            );
      }),
    );
  }
}
