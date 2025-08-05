import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.userRole});
  final String userRole;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isNotificationEnabled = true;
  final bool _isPremiumUser = true;

  @override
  Widget build(BuildContext context) {
    final bool isHelper = widget.userRole == 'helper';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Premium Banner for Help Seekers
          if (!isHelper && _isPremiumUser) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.blue.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade300.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 36),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Premium Membership",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Full access to premium features",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () => _navigateToSubscription(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Account Settings Section
          _buildSectionHeader("Account Settings"),
          _buildSettingsCard(
            children: [
              _buildListTile(
                icon: Icons.person_outline,
                title: "Edit Profile",
                subtitle: "Update your personal information",
                onTap: () => _navigateToEditProfile(),
              ),
              const Divider(height: 1),
              if (isHelper) ...[
                _buildListTile(
                  icon: Icons.work_outline,
                  title: "Employment History",
                  subtitle: "View and manage your work history",
                  onTap: () => _navigateToEmploymentHistory(),
                ),
                const Divider(height: 1),
              ],
              _buildListTile(
                icon: Icons.subscriptions,
                title: "Subscription",
                subtitle: "Manage your subscription plan",
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        _isPremiumUser
                            ? Colors.green.shade50
                            : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _isPremiumUser ? "Active" : "Inactive",
                    style: TextStyle(
                      color: _isPremiumUser ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                onTap: () => _navigateToSubscription(),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // App Preferences Section
          _buildSectionHeader("App Preferences"),
          _buildSettingsCard(
            children: [
              SwitchListTile(
                value: _isNotificationEnabled,
                onChanged:
                    (value) => setState(() => _isNotificationEnabled = value),
                title: const Text("Notifications"),
                subtitle: const Text("Enable/disable app notifications"),
                secondary: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_none,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              const Divider(height: 1),
            ],
          ),

          const SizedBox(height: 24),

          // Premium Features Section
          if (!isHelper) ...[
            _buildSectionHeader("Premium Features"),
            _buildSettingsCard(
              children: [
                _buildFeatureTile(
                  icon: Icons.verified_user,
                  title: "Unlimited Candidate Access",
                  description:
                      "Access all candidate profiles without restrictions",
                ),
                const Divider(height: 1),
                _buildFeatureTile(
                  icon: Icons.priority_high,
                  title: "Priority Support",
                  description: "24/7 dedicated support team",
                ),
                const Divider(height: 1),
                _buildFeatureTile(
                  icon: Icons.visibility,
                  title: "Profile Highlighting",
                  description: "Your job posts stand out to candidates",
                ),
                const Divider(height: 1),
                _buildFeatureTile(
                  icon: Icons.insights,
                  title: "Advanced Analytics",
                  description: "Detailed insights on candidate responses",
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],

          // Support Section
          _buildSectionHeader("Support"),
          _buildSettingsCard(
            children: [
              _buildListTile(
                icon: Icons.help_outline,
                title: "Help Center",
                subtitle: "FAQs and guides",
                onTap: () => _openHelpCenter(),
              ),
              const Divider(height: 1),
              _buildListTile(
                icon: Icons.description_outlined,
                title: "Terms & Conditions",
                subtitle: "Legal agreements",
                onTap: () => _openTerms(),
              ),
              const Divider(height: 1),
              _buildListTile(
                icon: Icons.privacy_tip_outlined,
                title: "Privacy Policy",
                subtitle: "How we protect your data",
                onTap: () => _openPrivacyPolicy(),
              ),
              const Divider(height: 1),
              _buildListTile(
                icon: Icons.contact_support_outlined,
                title: "Contact Support",
                subtitle: "Get help from our team",
                onTap: () => _contactSupport(),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Account Actions
          _buildSectionHeader("Account Actions"),
          _buildSettingsCard(
            children: [
              _buildListTile(
                icon: Icons.security,
                title: "Change Password",
                subtitle: "Update your login password",
                onTap: () => _changePassword(),
              ),
              const Divider(height: 1),
              _buildListTile(
                icon: Icons.logout,
                title: "Logout",
                titleColor: Colors.red,
                onTap: () => _confirmLogout(),
              ),
            ],
          ),

          // App Version
          const SizedBox(height: 32),
          Center(
            child: Text(
              "App Version: 2.1.0",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Helper methods for building UI components
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      elevation: 0,
      child: Column(children: children),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Color titleColor = Colors.black,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.deepPurple),
      ),
      title: Text(
        title,
        style: TextStyle(color: titleColor, fontWeight: FontWeight.w500),
      ),
      subtitle:
          subtitle != null
              ? Text(subtitle, style: TextStyle(color: Colors.grey.shade600))
              : null,
      trailing:
          trailing ??
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget _buildFeatureTile({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(
        description,
        style: TextStyle(color: Colors.grey.shade600),
      ),
      trailing: const Icon(Icons.check_circle, color: Colors.green),
    );
  }

  // Navigation and action methods
  void _navigateToEditProfile() {
    print("Navigate to Edit Profile");
  }

  void _navigateToEmploymentHistory() {
    print("Navigate to Employment History");
  }

  void _navigateToPaymentMethods() {
    print("Navigate to Payment Methods");
  }

  void _navigateToSubscription() {
    print("Navigate to Subscription");
  }

  void _openHelpCenter() {
    print("Open Help Center");
  }

  void _openTerms() {
    print("Open Terms & Conditions");
  }

  void _openPrivacyPolicy() {
    print("Open Privacy Policy");
  }

  void _contactSupport() {
    print("Contact Support");
  }

  void _manageFamilyMembers() {
    print("Manage Family Members");
  }

  void _changePassword() {
    print("Change Password");
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "Are you sure you want to logout from your account?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  print("User logged out");
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
