import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';

class PaymentController extends GetxController {
  // String paystackPublicKey = '';
  String paystackSecretKey = 'sk_test_88d2f72f79b5812cdc154b73c113ab5a3aca0ac6';

  void makePayment({
    required BuildContext context,
    required String email,
    required int amountInNaira,
  }) {
    final reference = PayWithPayStack().generateUuidV4();
    final amountInKobo = amountInNaira;

    PayWithPayStack().now(
      context: context,
      secretKey: paystackSecretKey,
      customerEmail: email,
      reference: reference,
      currency: 'KES',
      amount: amountInKobo.toDouble(),
      callbackUrl: 'https://google.com',
      transactionCompleted: (paymentData) {
        debugPrint("✅ Transaction Successful: $paymentData");
        Get.snackbar("Payment", "Transaction Completed Successfully");
      },
      transactionNotCompleted: (reason) {
        debugPrint("❌ Transaction Failed: $reason");
        Get.snackbar("Payment Failed", reason);
      },
    );
  }
}
