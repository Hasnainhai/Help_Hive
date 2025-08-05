import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers_hive/utils/widgets/next_button.dart';
import '../../chat/chat_detail_screen.dart';
import '../../models/help_seeker_profile_model.dart';

class HelpSeekerDetailsScreen extends StatelessWidget {
  final HelpSeekerProfile profile;
  final String userRole;

  const HelpSeekerDetailsScreen({
    super.key,
    required this.profile,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profile.name),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: NetworkImage(profile.imageUrl ?? ''),
                    child:
                        profile.imageUrl == null
                            ? const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey,
                            )
                            : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    profile.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDetailCard('Country', profile.country),
                  _buildDetailCard('Experience', profile.experience),
                  _buildDetailCard('Skills', profile.skills),
                  _buildDetailCard('Rating', '${profile.rating} ⭐'),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'About',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(profile.description),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: NextButton(
                label: 'Chat Now',
                onPressed: () {
                  Get.to(
                    ChatDetailScreen(
                      userName: profile.name,
                      userRole: userRole,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}
