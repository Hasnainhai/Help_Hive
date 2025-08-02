import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "title": "New Job Request",
        "subtitle": "You have received a job request from Sarah",
        "time": "2 mins ago",
        "type": "seeker",
      },
      {
        "title": "Application Accepted",
        "subtitle": "Your application for Babysitting has been accepted",
        "time": "10 mins ago",
        "type": "helper",
      },
      {
        "title": "Reminder",
        "subtitle": "Don’t forget your appointment tomorrow at 10:00 AM",
        "time": "1 hour ago",
        "type": "general",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return NotificationCard(
            title: item["title"]!,
            subtitle: item["subtitle"]!,
            time: item["time"]!,
            type: item["type"]!,
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String type;

  const NotificationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.type,
  });

  Color _getBackgroundColor() {
    switch (type) {
      case 'helper':
        return Colors.green.shade50;
      case 'seeker':
        return Colors.blue.shade50;
      default:
        return Colors.grey.shade100;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case 'helper':
        return Icons.check_circle_outline;
      case 'seeker':
        return Icons.person_add_alt_1;
      default:
        return Icons.notifications_none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getBackgroundColor(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(_getIcon(), size: 32, color: Colors.deepPurple),
        title: Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(color: Colors.grey.shade600),
        ),
        trailing: Text(
          time,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}
