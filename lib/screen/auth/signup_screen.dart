import 'package:flutter/material.dart';
import 'package:helpers_hive/screen/auth/helper_form.dart';
import 'package:helpers_hive/screen/auth/seeker_form.dart';
import 'package:helpers_hive/utils/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(child: Image.asset('assets/images/logo.png', width: 100, height: 100)),
              const SizedBox(height: 10),
              const Text("Create your account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              Text('Welcome! Please create your profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              TabBar(
                controller: _tabController,
                labelColor: primaryBg,
                overlayColor: WidgetStatePropertyAll(primaryBg.withValues(alpha: 0.5)),
                indicatorColor: primaryBg,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: const [Tab(text: "Help Seeker"), Tab(text: "Helper")],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [HelpSeekerForm(tabController: _tabController), HelperForm(tabController: _tabController)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
