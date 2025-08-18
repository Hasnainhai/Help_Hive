import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ChatDetailScreen extends StatefulWidget {
  final String userName;
  final String userRole;

  const ChatDetailScreen({
    super.key,
    required this.userName,
    required this.userRole,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final List<String> messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isHiringInProgress = false;
  bool _isHired = false;
  // bool _isRequestPending = false;

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add(text);
        _controller.clear();
      });
    }
  }

  void _startHiringProcess() {
    setState(() {
      _isHiringInProgress = true;
    });

    // Simulate hiring process
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isHiringInProgress = false;
        _isHired = true;
      });

      // Add a system message
      messages.add("You've hired ${widget.userName}!");
    });
  }

  void _showHiringDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Confirm Hiring"),
            content: Text("Are you sure you want to hire ${widget.userName}?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _startHiringProcess();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Confirm Hire"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if current user is a help seeker
    final bool isHelpSeeker = widget.userRole == 'helpSeeker';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_isHired)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.verified, color: Colors.green),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(messages[index]),
                  ),
                );
              },
            ),
          ),

          // Hiring Status Banner
          if (_isHiringInProgress)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.amber.shade100,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Processing hiring request...",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

          if (_isHired && isHelpSeeker)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.green.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "Hired! ${widget.userName} is now your helper",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

          const Divider(height: 1),

          // Hiring Button - ONLY VISIBLE TO HELP SEEKERS
          if (isHelpSeeker && !_isHired)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.deepPurple.shade50,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _showHiringDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      icon: const Icon(Icons.work_outline),
                      label: const Text(
                        "Hire Now",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Helper Side - Pending Request
          if (widget.userRole == 'helper')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.orange.shade50,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _showAcceptDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBg,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      icon: const Icon(Icons.hourglass_empty),
                      label: const Text(
                        "Pending Request",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Message Input
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: primaryBg),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAcceptDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Accept Hiring Request"),
            content: const Text("Do you want to accept this hiring request?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Reject"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    // _isRequestPending = false;
                    _isHired = true;
                  });
                  messages.add("You have accepted the hiring request.");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Accept"),
              ),
            ],
          ),
    );
  }
}
