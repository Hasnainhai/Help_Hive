/// views/bottom_nav_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/bookmark/bookmark_screen.dart';
import 'package:helpers_hive/chat/chat_screen.dart';
import 'package:helpers_hive/profile/profile_screen.dart';
import 'package:helpers_hive/screen/application/applications_screen.dart';
import 'package:helpers_hive/screen/home/home_screen.dart';
import '../../controller/bottomNavBar/BottomNavController.dart';
import '../../utils/colors.dart';

class BottomNavScreen extends StatelessWidget {
  final String userRole;
  BottomNavScreen({super.key, required this.userRole});

  final BottomNavController navController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    final isHelpSeeker = userRole == 'helpSeeker';
    print(
      '..............................Loaded BottomNavScreen for role: $userRole',
    );

    final List<Widget> seekerPages = [
      HomeScreen(userRole: userRole),
      ApplicationsScreen(userRole: userRole),
      ChatScreen(userRole: userRole),
      ProfileScreen(userRole: userRole),
    ];

    final List<Widget> providerPages = [
      HomeScreen(userRole: userRole),
      BookmarkScreen(),
      ChatScreen(userRole: userRole),
      ProfileScreen(userRole: userRole),
    ];

    final pages = isHelpSeeker ? seekerPages : providerPages;

    final navItems =
        isHelpSeeker
            ? const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_applications),
                label: 'Applications',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ]
            : const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: 'SavedJob',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ];

    return Obx(
      () => Scaffold(
        body: pages[navController.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navController.currentIndex.value,
          onTap: navController.changeIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: primaryBg,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: navItems,
        ),
      ),
    );
  }
}

// // packages
// import 'package:flutter/material.dart';
// import 'package:helpers_hive/bookmark/bookmark_screen.dart';
// import 'package:helpers_hive/chat/chat_screen.dart';
// import 'package:helpers_hive/profile/profile_screen.dart';
// import 'package:helpers_hive/screen/application/applications_screen.dart';
// import 'package:helpers_hive/screen/home/home_screen.dart';
// import '../../utils/colors.dart';

// class BottomNavScreen extends StatefulWidget {
//   final String userRole;
//   const BottomNavScreen({super.key, required this.userRole});

//   @override
//   _BottomNavScreenState createState() => _BottomNavScreenState();
// }

// class _BottomNavScreenState extends State<BottomNavScreen> {
//   int currentIndex = 0;
//   late List<Widget> pages;
//   late List<BottomNavigationBarItem> navItems;

//   @override
//   void initState() {
//     super.initState();
//     final role = widget.userRole;
//     if (role == 'helpSeeker') {
//       pages = [
//         HomeScreen(userRole: widget.userRole),
//         ApplicationsScreen(),
//         ChatScreen(),
//         ProfileScreen(userRole: widget.userRole),
//       ];
//       navItems = const [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.settings_applications),
//           label: 'Applications',
//         ),
//         BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//       ];
//     } else {
//       pages = [
//         HomeScreen(userRole: widget.userRole),
//         BookmarkScreen(),
//         ChatScreen(),
//         ProfileScreen(userRole: widget.userRole),
//       ];
//       navItems = const [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//         BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'SavedJob'),
//         BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//       ];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[currentIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: Offset(0, -2),
//             ),
//           ],
//         ),
//         child: BottomNavigationBar(
//           currentIndex: currentIndex,
//           onTap: (index) {
//             setState(() {
//               currentIndex = index;
//             });
//           },

//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.white,
//           selectedItemColor: primaryBg,
//           unselectedItemColor: Colors.grey,
//           selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
//           unselectedLabelStyle: const TextStyle(),
//           items: navItems,
//         ),
//       ),
//     );
//   }
// }
