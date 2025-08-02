import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:helpers_hive/chat/chat_detail_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> chatUsers = [
      {'name': 'Ali Khan', 'lastMessage': 'Hey, are you available?'},
      {'name': 'Fatima Zahra', 'lastMessage': 'Thanks for your help!'},
      {'name': 'Ahmed Raza', 'lastMessage': 'Let’s catch up later.'},
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Chats'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: chatUsers.length,
        itemBuilder: (context, index) {
          final user = chatUsers[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.deepPurple.shade200,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                user['name'] ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                user['lastMessage'] ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to chat details screen
                Get.to(ChatDetailScreen(userName: user['name']!));
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => ChatDetailScreen(userName: user['name']!),
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
