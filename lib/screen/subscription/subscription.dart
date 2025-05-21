import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/next_button.dart';

class SubscriptionScreen extends StatefulWidget {
  final String userRole;

  const SubscriptionScreen({super.key, required this.userRole});

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late SubscriptionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SubscriptionController();

    // Define subscription plans based on userRole
    if (widget.userRole == 'helpSeeker') {
      _controller.feeOptions = [
        {
          'title': 'Less than 1 Month',
          'amount': '\$180 (Flat Fee)',
          'features': ['Profile picture accessible', 'Complete profile accessible'],
        },
        {
          'title': 'More than 1 Month up to 3 Months',
          'amount': '\$150/month (Paid Upfront)',
          'features': ['Profile picture accessible', 'Complete profile accessible', 'Featured listing during subscription'],
          'note': '2 months: \$300, 3 months: \$450',
        },
        {
          'title': 'More than 3 Months',
          'amount': '\$120/month (Paid Upfront)',
          'features': ['Profile picture accessible', 'Complete profile accessible', 'Featured listing during subscription'],
          'note': '4 months: \$480, 6 months: \$720, More than 6 months: \$1,000',
        },
      ];
    } else {
      _controller.feeOptions = [
        {
          'title': 'Promote CV',
          'amount': ' USD 5 (Flat Fee)',
          'description': 'Promote your CV and increase visibility',
          'includesUnlimitedViews': true,
        },
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subscription')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Select a Subscription Option', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),

              // List of subscription options
              ListView.builder(
                shrinkWrap: true,
                itemCount: _controller.feeOptions.length,
                itemBuilder: (context, index) {
                  final option = _controller.feeOptions[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: RadioListTile<int>(
                      value: index,
                      groupValue: _controller.selectedOption, // Bind to selectedOption from the controller
                      activeColor: primaryBg,
                      onChanged: (value) {
                        setState(() {
                          _controller.selectedOption = value!;
                        }); // Update the selected option
                      },
                      title: Text(
                        '${option['title']} - ${option['amount']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle:
                          widget.userRole == 'helpSeeker'
                              ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    (option['features'] as List<String>).map((feature) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.check, size: 16, color: Colors.green),
                                            const SizedBox(width: 6),
                                            Text(feature),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                              )
                              : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(option['description'] ?? ''),
                                  if (option['includesUnlimitedViews'])
                                    const Padding(
                                      padding: EdgeInsets.only(top: 6.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.check_circle, size: 16, color: Colors.green),
                                          SizedBox(width: 6),
                                          Text(
                                            'Unlimited profile views',
                                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Subscribe button
              NextButton(
                label: 'Subscribe',
                onPressed: () {
                  if (_controller.selectedOption == 1) {
                    // Show duration dialog with StatefulBuilder
                    _showDurationDialog(context);
                  } else {
                    final selected = _controller.feeOptions[_controller.selectedOption];
                    print("Subscribed to: ${selected['title']} - ${selected['amount']}");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show a dialog for selecting the duration of subscription
  void _showDurationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Select Subscription Duration'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<int>(
                    value: 1,
                    groupValue: _controller.selectedDuration,
                    activeColor: primaryBg,
                    onChanged: (value) {
                      setState(() {
                        _controller.selectedDuration = value!;
                      });
                    },
                    title: const Text('2 Month'),
                  ),
                  RadioListTile<int>(
                    value: 3,
                    groupValue: _controller.selectedDuration,
                    activeColor: primaryBg,
                    onChanged: (value) {
                      setState(() {
                        _controller.selectedDuration = value!;
                      });
                    },
                    title: const Text('3 Months'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel', style: TextStyle(color: primaryBg)),
                ),
                TextButton(
                  onPressed: () {
                    final duration = _controller.selectedDuration;
                    print("Selected duration: $duration months");
                    Navigator.pop(context);
                  },
                  child: const Text('Confirm', style: TextStyle(color: primaryBg)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class SubscriptionController {
  List<Map<String, dynamic>> feeOptions = [];
  int selectedOption = 0; // Default selected option
  int selectedDuration = 1; // Default selected duration in months
}
