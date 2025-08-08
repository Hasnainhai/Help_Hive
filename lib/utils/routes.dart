import 'package:get/get.dart';
import 'package:helpers_hive/screen/auth/signup_screen.dart';
import 'package:helpers_hive/screen/complete_profile/info_region_seeker_screen.dart';
import 'package:helpers_hive/screen/complete_profile/info_seeker_screen.dart';
import 'package:helpers_hive/screen/complete_profile/job_selection_helper.dart';
import 'package:helpers_hive/screen/complete_profile/personal_info_helper_screen.dart';
import 'package:helpers_hive/screen/complete_profile/personal_helper_screen.dart';
import 'package:helpers_hive/screen/home/home_screen.dart';
import 'package:helpers_hive/screen/onboarding/onboarding_screen.dart';

import '../screen/auth/signin_screen.dart';
import '../screen/bottom_navigation/bottom_navigation.dart';
import '../screen/splash/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';
  static const String onboardingScreen = '/onboardingScreen';
  static const String signup = '/signup';
  static const String signIn = '/signIn';
  static const String helperPrimaryInfo = '/helperPrimaryInfo';
  static const String helperGenderScreen = '/helperGenderScreen';
  static const String jobSelection = '/jobSelection';
  static const String homeScreen = '/home';
  static const String bottomNav = '/bottomNav';
  static const String seekerPrimaryInfo = '/seekerPrimaryInfo';
  static const String locationDetailScreen = '/locationDetailScreen';
  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: signup, page: () => SignupScreen()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: helperPrimaryInfo, page: () => PersonalInfoScreen()),
    GetPage(name: helperGenderScreen, page: () => PersonalScreen()),
    GetPage(name: jobSelection, page: () => JobSelection()),
    GetPage(name: homeScreen, page: () => HomeScreen(userRole: Get.arguments)),
    GetPage(
      name: bottomNav,
      page: () => BottomNavScreen(userRole: Get.arguments),
    ),
    GetPage(name: seekerPrimaryInfo, page: () => InfoSeekerScreen()),
    GetPage(name: locationDetailScreen, page: () => InfoRegionSeekerScreen()),
  ];
}
