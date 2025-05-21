import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/utils/colors.dart';
import '../../utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.onboardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: primaryBg, body: Center(child: Image.asset('assets/images/logo.png')));
  }
}
