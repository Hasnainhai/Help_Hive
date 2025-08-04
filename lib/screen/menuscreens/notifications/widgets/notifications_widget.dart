import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controller/menu/notifications_controller.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String type;
  final String userRole;
  final NotificationsController controller;

  const NotificationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.type,
    required this.userRole,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isHelper = userRole == "helper";

    return Card(
      color:
          isHelper
              ? controller.getHelperBackgroundColor(type)
              : controller.getSeekerBackgroundColor(type),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:
                isHelper
                    ? controller.getHelperIconColor(type).withOpacity(0.2)
                    : Colors.deepPurple.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isHelper
                ? controller.getHelperIcon(type)
                : controller.getSeekerIcon(type),
            size: 24,
            color:
                isHelper
                    ? controller.getHelperIconColor(type)
                    : Colors.deepPurple,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: Colors.grey.shade700,
              fontSize: 13,
            ),
          ),
        ),
        trailing: Text(
          time,
          style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey.shade600),
        ),
      ),
    );
  }
}
