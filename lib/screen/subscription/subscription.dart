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
  int _selectedOption = 0;
  int? _selectedCategoryIndex; // For helper job category selection
  int? _selectedProfileIndex; // For helper profile selection

  // Helper categories (dummy data - replace with actual categories)
  final List<String> _helperCategories = [
    'Housekeeper',
    'Nanny',
    'Cook',
    'Driver',
    'Elderly Care',
    'Gardener',
  ];

  // Helper profiles (dummy data - replace with actual profiles)
  final List<String> _helperProfiles = [
    'Primary Profile',
    'Secondary Profile',
    'Specialized Profile',
  ];

  @override
  Widget build(BuildContext context) {
    final bool isHelper = widget.userRole == 'helper';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Plans'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isHelper
                    ? 'Boost Your Visibility'
                    : 'Get Full Access to Candidates',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isHelper
                    ? 'Stand out to employers with premium features'
                    : 'Unlock complete candidate profiles after successful agreements',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),

              // Subscription options based on user role
              if (isHelper) ...[
                // Helper - Feature Profile
                _buildPlanCard(
                  title: 'Feature Profile',
                  price: '\$10 per profile per month',
                  description: 'Make your profile stand out in search results',
                  isSelected: _selectedOption == 0,
                  onSelect: () => setState(() => _selectedOption = 0),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Profile to Feature:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: List.generate(
                          _helperProfiles.length,
                          (index) => ChoiceChip(
                            label: Text(_helperProfiles[index]),
                            selected: _selectedProfileIndex == index,
                            onSelected:
                                (selected) => setState(() {
                                  _selectedProfileIndex =
                                      selected ? index : null;
                                }),
                            selectedColor: primaryBg.withOpacity(0.2),
                            labelStyle: TextStyle(
                              color:
                                  _selectedProfileIndex == index
                                      ? primaryBg
                                      : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Helper - Feature Job
                _buildPlanCard(
                  title: 'Feature Job',
                  price: '\$10 per category per month',
                  description:
                      'Highlight your job applications in specific categories',
                  isSelected: _selectedOption == 1,
                  onSelect: () => setState(() => _selectedOption = 1),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Job Category:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: List.generate(
                          _helperCategories.length,
                          (index) => ChoiceChip(
                            label: Text(_helperCategories[index]),
                            selected: _selectedCategoryIndex == index,
                            onSelected:
                                (selected) => setState(() {
                                  _selectedCategoryIndex =
                                      selected ? index : null;
                                }),
                            selectedColor: primaryBg.withOpacity(0.2),
                            labelStyle: TextStyle(
                              color:
                                  _selectedCategoryIndex == index
                                      ? primaryBg
                                      : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Help Seeker Plans
                _buildPlanCard(
                  title: 'Monthly Access',
                  price: '\$200 per month',
                  description: 'Billed every month',
                  features: const [
                    'Full candidate profile access',
                    'Unlimited candidate searches',
                    'Priority support',
                  ],
                  isSelected: _selectedOption == 0,
                  onSelect: () => setState(() => _selectedOption = 0),
                ),

                const SizedBox(height: 16),

                _buildPlanCard(
                  title: 'Quarterly Access',
                  price: '\$600 every 3 months',
                  description: 'Billed quarterly (Save \$50 per month)',
                  features: const [
                    'All monthly features',
                    'Featured listing priority',
                    'Early access to new candidates',
                  ],
                  isSelected: _selectedOption == 1,
                  onSelect: () => setState(() => _selectedOption = 1),
                ),

                const SizedBox(height: 16),

                _buildPlanCard(
                  title: 'Yearly Access',
                  price: '\$1,200 per year',
                  description: 'Billed annually (Save \$100 per month)',
                  features: const [
                    'All quarterly features',
                    'Dedicated account manager',
                    'Exclusive candidate matching',
                  ],
                  isSelected: _selectedOption == 2,
                  onSelect: () => setState(() => _selectedOption = 2),
                ),
              ],

              const SizedBox(height: 32),

              // Subscribe button
              NextButton(
                label: 'Subscribe Now',
                onPressed: () {
                  if (isHelper) {
                    if ((_selectedOption == 0 &&
                            _selectedProfileIndex == null) ||
                        (_selectedOption == 1 &&
                            _selectedCategoryIndex == null)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a profile or category'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    final selectedType =
                        _selectedOption == 0
                            ? 'Profile: ${_helperProfiles[_selectedProfileIndex!]}'
                            : 'Category: ${_helperCategories[_selectedCategoryIndex!]}';

                    print("Subscribed to: $selectedType");
                  } else {
                    final plans = ['Monthly', 'Quarterly', 'Yearly'];
                    print("Subscribed to: ${plans[_selectedOption]} plan");
                  }

                  // Payment processing would go here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Subscription successful!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Cancel anytime • No hidden fees',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String description,
    List<String>? features,
    Widget? content,
    required bool isSelected,
    required VoidCallback onSelect,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? primaryBg : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      elevation: 0,
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? primaryBg : Colors.black,
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check_circle, color: primaryBg, size: 24),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),

              if (features != null)
                ...features
                    .map(
                      (feature) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Text(feature)),
                          ],
                        ),
                      ),
                    )
                    .toList(),

              if (content != null) ...[const SizedBox(height: 16), content],
            ],
          ),
        ),
      ),
    );
  }
}
