import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
// import 'package:fypapp/widgets/constant.dart';
import 'package:get/get.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:intl/intl.dart';

class JazzCashPaymentScreen extends StatefulWidget {
  const JazzCashPaymentScreen({super.key});

  @override
  State<JazzCashPaymentScreen> createState() => _JazzCashPaymentScreenState();
}

class _JazzCashPaymentScreenState extends State<JazzCashPaymentScreen> {
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final Constant constant = Constant();
  bool _isLoading = false;

  // Max and Min Payment Validation
  final double maxPaymentAmount = 1000.00; // Max payment amount
  final double minPaymentAmount = 50.00;  // Min payment amount

  void payment() async {
    if (_contactController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your JazzCash number!")),
      );
      return;
    }

    // Validate payment amount
    double paymentAmount = double.tryParse(_paymentController.text) ?? 0.0;

    if (paymentAmount < minPaymentAmount) {
      // Show a message if the payment is too low
      Get.snackbar("Invalid Payment", "Payment must be Service PKR $minPaymentAmount.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (paymentAmount > maxPaymentAmount) {
      // Show a message if the payment exceeds the max limit
      Get.snackbar("Invalid Payment", "Payment exceeds the maximum allowed amount of PKR $maxPaymentAmount.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Show confirmation dialog before proceeding with payment
    bool proceed = await _showConfirmationDialog(paymentAmount);
    if (!proceed) return;

    setState(() {
      _isLoading = true;
    });

    try {
      String dateandtime = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      String expiredate = DateFormat("yyyyMMddHHmmss").format(DateTime.now().add(const Duration(days: 1)));
      String transactionReference = "T${DateFormat("yyyyMMddHHmmss").format(DateTime.now())}";
      String ppAmount = paymentAmount.toStringAsFixed(2); // Use validated payment amount
      String ppBillreference = "billRef";
      String ppDescription = "Service online";
      String ppLanguage = "EN";
      String ppMerchantid = "your_merchant_id";
      String ppPassword = "your_password";
      String ppReturnurl = "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
      String ppTxncurrency = "PKR";
      String ppTxndatetime = dateandtime.replaceAll('-', '').replaceAll(' ', '').replaceAll(':', '');
      String ppTxnexpirydatetime = expiredate;
      String ppTxnrefno = transactionReference;
      String ppTxntype = "MWALLET";
      String ppVer = "1.1";
      String ppmpf_1 = _contactController.text; // User-entered contact number
      String integritySalt = "your_integrity_salt";

      // Create Secure Hash
      String data =
          "$integritySalt&$ppAmount&$ppBillreference&$ppDescription&$ppLanguage&$ppMerchantid&$ppPassword&$ppReturnurl&$ppTxncurrency&$ppTxndatetime&$ppTxnexpirydatetime&$ppTxnrefno&$ppTxntype&$ppVer&$ppmpf_1";

      var key = utf8.encode(integritySalt);
      var bytes = utf8.encode(data);
      var hmacSha256 = Hmac(sha256, key); // Create HMAC object
      Digest sha256Result = hmacSha256.convert(bytes);

      // Simulating the transaction process
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Show confirmation dialog with success icon
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Payment Successful", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.green, size: 50),
              const SizedBox(height: 20),
              Text("Sender Name: ${_contactController.text}", style: const TextStyle(fontSize: 16)),
              const Text("Receiver Name: Beautilly", style: TextStyle(fontSize: 16)),
              const Text("Receiver Number: 03251806654", style: TextStyle(fontSize: 16)),
              Text("Amount: PKR $ppAmount", style: const TextStyle(fontSize: 16)),
              Text("Payment Date: $dateandtime", style: const TextStyle(fontSize: 16)),
              Text("Transaction ID: $transactionReference", style: const TextStyle(fontSize: 16)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred during payment.")),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> _showConfirmationDialog(double paymentAmount) async {
    bool proceed = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Payment", style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text("Are you sure you want to send the payment of PKR $paymentAmount?"),
        actions: [
          TextButton(
            onPressed: () {
              proceed = false;
              Navigator.pop(context);
            },
            child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              proceed = true;
              Navigator.pop(context);
            },
            child: const Text("Confirm", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    return proceed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constant.whiteC),
        backgroundColor: constant.primaryColor,
        title: Text("JazzCash Payment", style: TextStyle(color: constant.whiteC)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "Beautilly",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: constant.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Contact: +93 251806654",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Enter JazzCash Number",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contactController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "JazzCash Number",
                hintStyle: const TextStyle(color: Colors.grey),
                hintText: "e.g. 03251806654",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter Payment Amount",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _paymentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount (PKR)",
                hintStyle: const TextStyle(color: Colors.grey),
                hintText: "e.g. 1000",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Text(
            //   "Payment Details",
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 10),
            // Text("Max Amount: PKR $maxPaymentAmount"),
            // Text("Min Amount: PKR $minPaymentAmount"),
            const SizedBox(height: 120),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                  child: ElevatedButton(
                      onPressed: payment,
                      style: ElevatedButton.styleFrom(
                        // c  : constant.primaryColor,
                        backgroundColor: constant.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                      ),
                      child: Text(
                        "     Pay Now     ",
                        style: TextStyle(fontSize: 18,color: constant.whiteC
                        ),
                      ),
                    ),
                ),
          ],
        ),
      ),
    );
  }
}
