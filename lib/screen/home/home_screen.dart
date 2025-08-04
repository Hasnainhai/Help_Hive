import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/job_post/job_post.dart';
import 'package:helpers_hive/screen/application/applications_screen.dart';
import 'package:helpers_hive/screen/menuscreens/notifications_screen.dart';
import 'package:helpers_hive/screen/subscription/subscription.dart';
import 'package:helpers_hive/utils/colors.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';
import 'package:helpers_hive/screen/auth/signin_screen.dart';
import 'package:helpers_hive/screen/menuscreens/settings_screen.dart';
import 'package:helpers_hive/screen/menuscreens/support_chat/support_chat_screen.dart';
import '../menuscreens/helperApplications/helper_applications_screen.dart';
import 'job_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userRole;
  const HomeScreen({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    final isHelper = userRole == 'helper';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Welcome! Suhel Athmad',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.white,
      ),
      drawer: _buildDrawer(context, isHelper),
      body:
          isHelper ? _buildHelperHome(context) : _buildHelpSeekerHome(context),
    );
  }

  Widget _buildDrawer(BuildContext context, bool isHelper) {
    final menuItems =
        isHelper
            ? [
              {'icon': Icons.assignment, 'title': 'My Applications'},
              {'icon': Icons.chat, 'title': 'Chat for Help'},
              {'icon': Icons.settings, 'title': 'Settings'},
              {'icon': Icons.unsubscribe, 'title': 'Subscriptions'},
              {'icon': Icons.notifications, 'title': 'Notifications'},
              {'icon': Icons.logout, 'title': 'Log-Out'},
            ]
            : [
              {'icon': Icons.post_add, 'title': 'Post a Job'},
              {
                'icon': Icons.assignment_turned_in,
                'title': 'Applications Status',
              },
              {'icon': Icons.unsubscribe, 'title': 'Subscriptions'},
              {'icon': Icons.notifications, 'title': 'Notifications'},
              {'icon': Icons.chat, 'title': 'Chat for Help'},
              {'icon': Icons.settings, 'title': 'Settings'},
              {'icon': Icons.logout, 'title': 'Log-Out'},
            ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: primaryBg),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ...menuItems.map(
            (item) => ListTile(
              leading: Icon(item['icon'] as IconData?),
              title: Text(item['title'] as String),
              onTap: () => _handleDrawerTap(context, item['title'] as String),
            ),
          ),
        ],
      ),
    );
  }

  void _handleDrawerTap(BuildContext context, String title) {
    Navigator.pop(context);
    switch (title) {
      case 'Post a Job':
        Get.to(() => JobPost());
        break;
      case 'Subscriptions':
        Get.to(() => SubscriptionScreen(userRole: userRole));
        break;
      case 'Applications Status':
        Get.to(() => ApplicationsScreen(userRole: userRole));
        break;
      case 'Notifications':
        Get.to(() => NotificationsScreen());
        break;
      case 'Chat for Help':
        Get.to(() => SupportChatScreen());
        break;
      case 'Settings':
        Get.to(() => SettingsScreen());
        break;
      case 'My Applications':
        Get.to(() => HelperApplicationsScreen());
        break;

      case 'Log-Out':
        FirebaseAuth.instance.signOut();
        Get.offAll(() => SignInScreen());
        break;
    }
  }

  Widget _buildHelperHome(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  cursorColor: primaryBg,
                  decoration: InputDecoration(
                    hintText: 'Search jobs',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: _showFilterBottomSheet,
                child: Image.asset(
                  'assets/images/filter.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Featured Jobs',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => _buildFeaturedJobCard(index),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Jobs for You',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) => _buildJobCard(context, index),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedJobCard(int index) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primaryBg, Color(0xFF6A89CC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Housekeeper ${index + 1}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Doha, Qatar',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const Spacer(),
          const Text(
            'QAR 3,000/mo',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => Get.to(() => JobDetailsScreen(jobIndex: index)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Housekeeper ${index + 1}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Icon(Icons.bookmark_border, color: Colors.grey.shade600),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildIconText(Icons.location_on_outlined, 'Doha, Qatar'),
                  const SizedBox(width: 16),
                  _buildIconText(Icons.work_outline, 'Full-time'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildIconText(Icons.attach_money, 'QAR 2,000 - QAR 3,000'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${index + 2}d ago',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: primaryBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: primaryBg, size: 20),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: Colors.grey.shade700)),
      ],
    );
  }

  Widget _buildHelpSeekerHome(BuildContext context) {
    // HelpSeeker UI remains the same as original
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            cursorColor: primaryBg,
            decoration: InputDecoration(
              hintText: 'Search profiles',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Featured Profiles',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder:
                  (context, index) => GestureDetector(
                    onTap: () => _showSubscriptionDialog(context),
                    child: Container(
                      width: 220,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade200, blurRadius: 4),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe ${index + 1}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Experienced housekeeper with 5 years in UAE.',
                          ),
                          const Spacer(),
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Philippines',
                              style: TextStyle(color: primaryBg),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Profiles for You',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _showSubscriptionDialog(context),
                child: Card(
                  elevation: 1,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jane Smith ${index + 1}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Nanny with 3 years of experience working with toddlers and infants.',
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text('India', style: TextStyle(color: primaryBg)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter by Country',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...['Saudia', 'Bahrain', 'Kuwait', 'Oman', 'Qatar', 'Iraq'].map((
              country,
            ) {
              return ListTile(
                title: Text(country),
                onTap: () {
                  Get.back();
                  print('Selected country: $country');
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Subscription Required'),
            content: const Text('QAR 10 for viewing a helper\'s profile'),
            actions: [NextButton(label: 'Subscribe', onPressed: () {})],
          ),
    );
  }
}
