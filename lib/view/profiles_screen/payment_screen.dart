import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../backend/services/api_endpoint.dart';
import '../../controller/profile/payment_controller.dart';
import '../../routes/routes.dart';
import '../../utils/strings.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  final controller = Get.put(PaymentController());
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Obx(() => controller.isSubmitLoading
          ? const CustomLoadingAPI()
          : _bodyWidget()),
    );
  }

  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Payment method options
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPaymentMethod(
                  icon: Icons.account_balance_wallet,
                  label: 'PayPal',
                  isSelected: controller.selectedMethod.value == 'PayPal',
                  onTap: () {
                    setState(() {
                      controller.selectedMethod.value = 'PayPal';
                    });
                  },
                ),
                _buildPaymentMethod(
                  icon: Icons.phone_android,
                  label: 'Mobile',
                  isSelected: controller.selectedMethod.value == 'Mobile',
                  onTap: () {
                    setState(() {
                      controller.selectedMethod.value = 'Mobile';
                    });
                  },
                ),
                _buildPaymentMethod(
                  icon: Icons.account_balance,
                  label: 'Bank',
                  isSelected: controller.selectedMethod.value == 'Bank',
                  onTap: () {
                    setState(() {
                      controller.selectedMethod.value = 'Bank';
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          const Center(
            child: Text(
              "Fees may apply",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 10),
          // Info message
          controller.selectedMethod.value == 'PayPal'
              ? _paypalWidget()
              : const SizedBox.shrink(),
          controller.selectedMethod.value == 'Mobile'
              ? _mobileWidget()
              : const SizedBox.shrink(),
          controller.selectedMethod.value == 'Bank'
              ? _bankWidget()
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  _paypalWidget() {
    return Expanded(
      flex: 5,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'The minimum to withdraw is €25 and the maximum to withdraw per day is €2500',
              style: TextStyle(color: Colors.black, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          // Input fields
          PrimaryTextInputWidget(
            controller: controller.payoutAmountController,
            keyboardType: TextInputType.number,
            labelText: Strings.enterAmount,
            hint: "0.0",
          ),
          const SizedBox(height: 16),
          PrimaryTextInputWidget(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            labelText: Strings.enterEmail,
            hint: "Paypal Email",
          ),
          const SizedBox(height: 16),
          PrimaryTextInputWidget(
            controller: controller.confirmEmailController,
            keyboardType: TextInputType.emailAddress,
            labelText: Strings.enterConfirmEmail,
            hint: "Paypal Email",
          ),
          const SizedBox(height: 26),
          // Confirm button
          ElevatedButton(
            onPressed: () {
              // Handle confirmation logic here
              print('Payout Amount: ${controller.payoutAmountController.text}');
              print('Email: ${controller.emailController.text}');
              print('Confirm Email: ${controller.confirmEmailController.text}');
              print('Payment Method: ${controller.selectedMethod}');
              controller.paymentProcess(
                  endpoint: ApiEndpoint.talentPayoutRequestURL,
                  inputBody: {
                    "amount": controller.payoutAmountController.text,
                    "stripe_email": controller.emailController.text,
                    "stripe_email_confirmation":
                        controller.confirmEmailController.text,
                    "bank_type": "paypal",
                  },
                  onConfirm: () {
                    _showSuccessDialog(
                        'Payout request has been successfully submitted.');
                  });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  _mobileWidget() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "The minimum to withdraw is €25 and the maximum to withdraw per day is €1000",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Select Network",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildNetworkButton('MTN'),
              const SizedBox(width: 10),
              _buildNetworkButton('Orange'),
            ],
          ),
          const SizedBox(height: 20),
          PrimaryTextInputWidget(
            controller: controller.emailController,
            // decoration: InputDecoration(
            //   labelText: 'Phone Number',
            //   prefixIcon: const Icon(Icons.phone),
            //   prefixText: '+225 - ',
            //   border: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            // ),
            keyboardType: TextInputType.phone,
            labelText: Strings.phoneNumber,
            hint: "xx xxxx xxx",
            prefixIcon: const Text(""),
          ),
          const SizedBox(height: 10),
          PrimaryTextInputWidget(
            controller: controller.confirmEmailController,
            keyboardType: TextInputType.phone,
            labelText: Strings.phoneNumber,
            hint: "xx xxxx xxx",
          ),
          const SizedBox(height: 10),
          PrimaryTextInputWidget(
            controller: controller.payoutAmountController,
            labelText: Strings.enterAmount,
            hint: "0.0 ",
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          const Text(
            "Please make sure you have enough room on your wallet to receive your payment.",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              final phoneNumber = controller.emailController.text.trim();
              final confirmPhoneNumber =
                  controller.confirmEmailController.text.trim();
              final payoutAmount =
                  controller.payoutAmountController.text.trim();

              if (phoneNumber.isEmpty ||
                  confirmPhoneNumber.isEmpty ||
                  payoutAmount.isEmpty) {
                _showErrorDialog('All fields are required.');
                return;
              }

              if (phoneNumber != confirmPhoneNumber) {
                _showErrorDialog('Phone numbers do not match.');
                return;
              }

              // Add more validation if necessary...

              controller.paymentProcess(
                  endpoint: ApiEndpoint.mobilePayoutRequestURL,
                  inputBody: {
                    "amount": controller.payoutAmountController.text,
                    "stripe_email": controller.emailController,
                    "stripe_email_confirmation":
                        controller.confirmEmailController,
                    "bank_type": "mobile",
                    "settings": { /// todo
                      "country": "senegal",
                      "prefix": "221",
                      "sim": "Free"
                    },
                  },
                  onConfirm: () {
                    _showSuccessDialog(
                        'Payout request has been successfully submitted.');
                  });
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }






  // Helper method to build a payment method widget
  _buildPaymentMethod({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(color: Theme.of(context).primaryColor, width: 2)
                  : Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
              size: 40,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkButton(String network) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            controller.selectedNetwork.value = network;
          });
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: controller.selectedNetwork.value == network
                  ? Colors.blue
                  : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8),
            color: controller.selectedNetwork.value == network
                ? Colors.blue.shade100
                : Colors.white,
          ),
          child: Center(
            child: Text(
              network,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: controller.selectedNetwork.value == network
                    ? Colors.blue
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAllNamed(Routes.btmScreen);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }



  /// bank
  _bankWidget() {
    return Expanded(
        child: ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTabButton("Canada", 0),
            _buildTabButton("Europe & UK", 1),
            _buildTabButton("Outside Europe", 2),
          ],
        ),
        const SizedBox(height: 20),
        _buildTabContent(),
      ],
    ));
  }

  Widget _buildTabButton(String title, int index) {
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: selectedTab == index ? FontWeight.bold : FontWeight.normal,
              color: selectedTab == index ? Colors.blue : Colors.grey,
            ),
          ),
          if (selectedTab == index)
            Container(
              height: 2,
              width: 50,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildCanadaTab();
      case 1:
        return _buildEuropeTab();
      case 2:
        return _buildOutsideEuropeTab();
      default:
        return Container();
    }
  }

  Widget _buildCanadaTab() {
    return Column(
      children: [
        _buildTextField("Enter Payout Amount", controller.payoutAmountController),
        _buildTextField("Full Name of Account Holder", controller.accountHolderController),
        _buildTextField("Interac Registered Email", controller.emailController),
        _buildTextField("Confirm Interac Registered Email", controller.confirmEmailController),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  controller.paymentProcess(
                      endpoint: ApiEndpoint.bankPayoutCanadaURL,
                      inputBody: {
                        "amount": controller.payoutAmountController.text,
                        "email": controller.emailController.text,
                        "email_confirmation":
                        controller.confirmEmailController.text,
                        "full_name": controller.accountHolderController.text,
                      },
                      onConfirm: () {
                        _showSuccessDialog(
                            'Payout request has been successfully submitted.');
                      });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEuropeTab() {
    return Column(
      children: [
        _buildTextField("Enter Payout Amount", controller.payoutAmountController),
        _buildTextField("Full Name of Account Holder", controller.accountHolderController),
        _buildTextField("IBAN", controller.emailController),
        _buildTextField("Confirm IBAN", controller.confirmEmailController),

        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  controller.paymentProcess(
                      endpoint: ApiEndpoint.bankPayoutEuropeURL,
                      inputBody: {
                        "amount": controller.payoutAmountController.text,
                        "iban": controller.emailController.text,
                        "iban_confirmation":
                        controller.confirmEmailController.text,
                        "full_name": controller.accountHolderController.text,
                      },
                      onConfirm: () {
                        _showSuccessDialog(
                            'Payout request has been successfully submitted.');
                      });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOutsideEuropeTab() {
    return Column(
      children: [
        const Text(
          "View the list to see if your country is listed",
          style: TextStyle(color: Colors.grey),
        ),
        _buildTextField("Enter Payout Amount", controller.payoutAmountController),
        _buildTextField("Full Name of Account Holder", controller.accountHolderController),
        _buildTextField("SWIFT/BIC Code", controller.swiftController),
        _buildTextField("Account Number", controller.emailController),
        _buildTextField("Confirm Account Number", controller.confirmEmailController),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  controller.paymentProcess(
                      endpoint: ApiEndpoint.bankPayoutOutsideURL,
                      inputBody: {
                        "amount": controller.payoutAmountController.text,
                        "account_number": controller.emailController.text,
                        "account_number_confirmation":
                        controller.confirmEmailController.text,
                        "swift": controller.swiftController.text,
                        "full_name": controller.accountHolderController.text,
                      },
                      onConfirm: () {
                        _showSuccessDialog(
                            'Payout request has been successfully submitted.');
                      });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: PrimaryTextInputWidget(
        labelText: label,
        controller: controller,
        hint: "",
      ),
    );
  }

}
