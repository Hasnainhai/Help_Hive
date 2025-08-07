import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/subscription/payment_controller.dart';
import '../../controller/subscription/subscription_controller.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/next_button.dart';

class SubscriptionScreen extends StatelessWidget {
  final String userRole;

  const SubscriptionScreen({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());
    final bool isHelper = userRole == 'helper';
    final PaymentController paymentController = Get.put(PaymentController());

    // Function to get selected amount
    double getSelectedAmount() {
      if (isHelper) {
        // Both helper options are $10
        return 10.0;
      } else {
        switch (controller.selectedOption.value) {
          case 0: // Monthly
            return 200.0;
          case 1: // Quarterly
            return 600.0;
          case 2: // Yearly
            return 1200.0;
          default:
            return 0.0;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Plans'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
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
              Obx(() {
                if (isHelper) {
                  return Column(
                    children: [
                      // Helper - Feature Profile
                      _buildHelperPlanCard(
                        controller: controller,
                        title: 'Feature Profile',
                        price: '\$10 per profile per month',
                        description:
                            'Make your profile stand out in search results',
                        optionIndex: 0,
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
                                controller.helperProfiles.length,
                                (index) => ChoiceChip(
                                  label: Text(controller.helperProfiles[index]),
                                  selected:
                                      controller.selectedProfileIndex?.value ==
                                      index,
                                  onSelected:
                                      (selected) => controller.selectProfile(
                                        selected ? index : null,
                                      ),
                                  selectedColor: primaryBg.withOpacity(0.2),
                                  labelStyle: TextStyle(
                                    color:
                                        controller
                                                    .selectedProfileIndex
                                                    ?.value ==
                                                index
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
                      _buildHelperPlanCard(
                        controller: controller,
                        title: 'Feature Job',
                        price: '\$10 per category per month',
                        description:
                            'Highlight your job applications in specific categories',
                        optionIndex: 1,
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
                                controller.helperCategories.length,
                                (index) => ChoiceChip(
                                  label: Text(
                                    controller.helperCategories[index],
                                  ),
                                  selected:
                                      controller.selectedCategoryIndex?.value ==
                                      index,
                                  onSelected:
                                      (selected) => controller.selectCategory(
                                        selected ? index : null,
                                      ),
                                  selectedColor: primaryBg.withOpacity(0.2),
                                  labelStyle: TextStyle(
                                    color:
                                        controller
                                                    .selectedCategoryIndex
                                                    ?.value ==
                                                index
                                            ? primaryBg
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      // Help Seeker Plans
                      _buildSeekerPlanCard(
                        controller: controller,
                        title: 'Monthly Access',
                        price: '\$200 per month',
                        description: 'Billed every month',
                        features: const [
                          'Full candidate profile access',
                          'Unlimited candidate searches',
                          'Priority support',
                        ],
                        optionIndex: 0,
                      ),

                      const SizedBox(height: 16),

                      _buildSeekerPlanCard(
                        controller: controller,
                        title: 'Quarterly Access',
                        price: '\$600 every 3 months',
                        description: 'Billed quarterly (Save \$50 per month)',
                        features: const [
                          'All monthly features',
                          'Featured listing priority',
                          'Early access to new candidates',
                        ],
                        optionIndex: 1,
                      ),

                      const SizedBox(height: 16),

                      _buildSeekerPlanCard(
                        controller: controller,
                        title: 'Yearly Access',
                        price: '\$1,200 per year',
                        description: 'Billed annually (Save \$100 per month)',
                        features: const [
                          'All quarterly features',
                          'Dedicated account manager',
                          'Exclusive candidate matching',
                        ],
                        optionIndex: 2,
                      ),
                    ],
                  );
                }
              }),

              const SizedBox(height: 32),

              // Subscribe button
              Obx(() {
                // Check if a valid selection is made
                bool isValidSelection = controller.selectedOption.value != -1;

                // For helper, also check if profile/category is selected
                if (isHelper) {
                  if (controller.selectedOption.value == 0) {
                    isValidSelection =
                        controller.selectedProfileIndex!.value != null;
                  } else if (controller.selectedOption.value == 1) {
                    isValidSelection =
                        controller.selectedCategoryIndex!.value != null;
                  }
                }
                return NextButton(
                  label: 'Subscribe Now',
                  onPressed:
                      isValidSelection
                          ? () {
                            final amount = getSelectedAmount();
                            paymentController.makePayment(
                              context: context,
                              email: 'testing@gmail.com',
                              amountInNaira: amount.toInt(),
                            );
                          }
                          : null,
                );
              }),

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

  Widget _buildHelperPlanCard({
    required SubscriptionController controller,
    required String title,
    required String price,
    required String description,
    required int optionIndex,
    required Widget content,
  }) {
    final isSelected = controller.selectedOption.value == optionIndex;

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
        onTap: () => controller.selectOption(optionIndex),
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
              const SizedBox(height: 16),
              content,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeekerPlanCard({
    required SubscriptionController controller,
    required String title,
    required String price,
    required String description,
    required List<String> features,
    required int optionIndex,
  }) {
    final isSelected = controller.selectedOption.value == optionIndex;

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
        onTap: () => controller.selectOption(optionIndex),
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
            ],
          ),
        ),
      ),
    );
  }
}
