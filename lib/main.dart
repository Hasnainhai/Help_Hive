import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/screen/splash/splash_screen.dart';
import 'package:helpers_hive/utils/app_texts.dart';
import 'package:helpers_hive/utils/routes.dart';
import 'controller/bottomNavBar/BottomNavController.dart';
import 'controller/help_seeker/applications_controller.dart';
import 'controller/helper/helper_applications_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
  Get.put(ApplicationsController());
  Get.put(BottomNavController());
  Get.put(HelperApplicationsController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.pages,
      home: SplashScreen(),
    );
  }
}
