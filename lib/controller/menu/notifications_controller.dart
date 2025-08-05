import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final String userRole;
  NotificationsController(this.userRole);

  // Observable list
  final RxList<Map<String, String>> notifications = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    if (userRole == "helper") {
      notifications.value = [
        {
          "title": "Application Accepted!",
          "subtitle":
              "Al Rayyan Family accepted your application for Housekeeper",
          "time": "2 mins ago",
          "type": "accepted",
        },
        {
          "title": "Interview Scheduled",
          "subtitle": "Interview with Abdullah Family tomorrow at 10:00 AM",
          "time": "1 hour ago",
          "type": "interview",
        },
        {
          "title": "New Message",
          "subtitle": "Mohammed Restaurant sent you a message",
          "time": "3 hours ago",
          "type": "message",
        },
        {
          "title": "Payment Received",
          "subtitle": "QAR 2,500 for Housekeeper job has been deposited",
          "time": "1 day ago",
          "type": "payment",
        },
      ];
    } else {
      notifications.value = [
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
          "subtitle": "Don't forget your appointment tomorrow at 10:00 AM",
          "time": "1 hour ago",
          "type": "general",
        },
      ];
    }
  }

  // Same style methods as before...
  Color getHelperBackgroundColor(String type) {
    switch (type) {
      case 'accepted':
        return Colors.green.shade50;
      case 'interview':
        return Colors.purple.shade50;
      case 'message':
        return Colors.blue.shade50;
      case 'payment':
        return Colors.teal.shade50;
      default:
        return Colors.grey.shade100;
    }
  }

  IconData getHelperIcon(String type) {
    switch (type) {
      case 'accepted':
        return Icons.check_circle;
      case 'interview':
        return Icons.calendar_today;
      case 'message':
        return Icons.message;
      case 'payment':
        return Icons.payment;
      default:
        return Icons.notifications;
    }
  }

  Color getHelperIconColor(String type) {
    switch (type) {
      case 'accepted':
        return Colors.green;
      case 'interview':
        return Colors.purple;
      case 'message':
        return Colors.blue;
      case 'payment':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  Color getSeekerBackgroundColor(String type) {
    switch (type) {
      case 'helper':
        return Colors.green.shade50;
      case 'seeker':
        return Colors.blue.shade50;
      default:
        return Colors.grey.shade100;
    }
  }

  IconData getSeekerIcon(String type) {
    switch (type) {
      case 'helper':
        return Icons.check_circle_outline;
      case 'seeker':
        return Icons.person_add_alt_1;
      default:
        return Icons.notifications_none;
    }
  }
}
