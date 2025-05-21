import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:helpers_hive/job_post/job_post.dart';
import 'package:helpers_hive/screen/subscription/subscription.dart';
import 'package:helpers_hive/utils/colors.dart';

import '../../utils/widgets/next_button.dart';
import '../auth/signin_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userRole;
  const HomeScreen({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    final isHelper = userRole == 'helper';

    final List<Map<String, dynamic>> menuItems =
        isHelper
            ? [
              {'icon': Icons.assignment, 'title': 'My Applications'},
              {'icon': Icons.track_changes, 'title': 'Jobs Status'},
              {'icon': Icons.chat, 'title': 'Chat for Help'},
              {'icon': Icons.language, 'title': 'Language'},
              {'icon': Icons.settings, 'title': 'Settings'},
              {'icon': Icons.unsubscribe, 'title': 'Subscriptions'},
              {'icon': Icons.notifications, 'title': 'Notifications'},
              {'icon': Icons.help_center, 'title': 'Help Center'},
              {'icon': Icons.logout, 'title': 'Log-Out'},
            ]
            : [
              {'icon': Icons.post_add, 'title': 'Post a Job'},
              {'icon': Icons.assignment_turned_in, 'title': 'Applications Status'},
              {'icon': Icons.unsubscribe, 'title': 'Subscriptions'},
              {'icon': Icons.notifications, 'title': 'Notifications'},
              {'icon': Icons.chat, 'title': 'Chat for Help'},
              {'icon': Icons.settings, 'title': 'Settings'},
              {'icon': Icons.help_center, 'title': 'Help Center'},
              {'icon': Icons.logout, 'title': 'Log-Out'},
            ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Welcome! Suhel Athmad', style: TextStyle(fontSize: 18)), backgroundColor: Colors.white),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: primaryBg),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ...menuItems.map(
              (item) => ListTile(
                leading: Icon(item['icon']),
                title: Text(item['title']),
                onTap: () async {
                  Navigator.pop(context);

                  switch (item['title']) {
                    case 'Post a Job':
                      Get.to(() => JobPost());
                      break;
                    case 'Subscriptions':
                      Get.to(() => SubscriptionScreen(userRole: userRole));
                      break;
                    case 'Log-Out':
                      await FirebaseAuth.instance.signOut();
                      Get.offAll(() => SignInScreen()); // Replace with your sign-in screen widget
                      break;
                    // Add other navigation cases if needed
                  }
                },
              ),
            ),
          ],
        ),
      ),
      body:
          isHelper
              ? SingleChildScrollView(
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
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
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
                                    const Text('Filter by Country', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 10),
                                    ...['Saudia', 'Bahrain', 'Kuwait', 'Oman', 'Qatar', 'Iraq'].map((country) {
                                      return ListTile(
                                        title: Text(country),
                                        onTap: () {
                                          Get.back(); // Close bottom sheet
                                          // Apply your filter logic here
                                          print('Selected country: $country');
                                        },
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Image.asset('assets/images/filter.png', width: 40, height: 40),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text('Featured Jobs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder:
                            (context, index) => Container(
                              width: 200,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                // color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4)],
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Featured Job ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  const Text('QAR 3,000/mo', style: TextStyle(color: primaryBg)),
                                ],
                              ),
                            ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text('Jobs for You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 1,
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Job Title ${index + 1}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                const Text('Salary: QAR 2,000 - QAR 3,000', style: TextStyle(color: primaryBg)),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text('2d ago', style: TextStyle(color: Colors.black, fontSize: 12)),
                                    SizedBox(width: 8),
                                    Icon(Icons.bookmark_border, color: Colors.black),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
              : SingleChildScrollView(
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
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Featured Profiles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder:
                            (context, index) => GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (_) => AlertDialog(
                                        title: const Text('Subscription Required'),
                                        content: const Text('QAR 10 for viewing a helper\'s profile'),
                                        actions: [NextButton(label: 'Subscribe', onPressed: () {})],
                                      ),
                                );
                              },
                              child: Container(
                                width: 220,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  // color: Colors.white,
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4)],
                                ),
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('John Doe ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 8),
                                    const Text('Experienced housekeeper with 5 years in UAE.'),
                                    const Spacer(),
                                    const Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text('Philippines', style: TextStyle(color: primaryBg)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text('Profiles for You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => AlertDialog(
                                    title: const Text('Subscription Required'),
                                    content: const Text('QAR 10 for viewing a helper\'s profile'),
                                    actions: [NextButton(label: 'Subscribe', onPressed: () {})],
                                  ),
                            );
                          },
                          child: Card(
                            elevation: 1,
                            margin: const EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            // color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jane Smith ${index + 1}',
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text('Nanny with 3 years of experience working with toddlers and infants.'),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [Text('India', style: TextStyle(color: primaryBg))],
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
              ),
    );
  }
}
