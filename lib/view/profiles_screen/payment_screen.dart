import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/language/language_controller.dart';
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

  final formKey = GlobalKey<FormState>();

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
      body: Obx(() => controller.isSubmitLoading || controller.isInfoLoading
          ? const CustomLoadingAPI()
          : _bodyWidget()),
    );
  }

  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
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
                        controller.payoutAmountController.clear();
                        controller.confirmEmailController.clear();
                        controller.emailController.clear();
                        controller.accountHolderController.clear();
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

            Center(
              child: Text(
                languageSettingController.getTranslation("Fees may apply"),
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
            child: Text(
              languageSettingController.getTranslation(
                  'The minimum to withdraw is €25 and the maximum to withdraw per day is €2500'),
              style: TextStyle(color: Colors.black, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          // Input fields
          PrimaryTextInputWidget(
            controller: controller.payoutAmountController,
            keyboardType: TextInputType.number,
            labelText: "Enter Payout Amount",
            error: "The amount field is required.",
            hint: "0.0",
          ),
          const SizedBox(height: 16),
          PrimaryTextInputWidget(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            error: "The paypal email field is required",
            labelText: "Paypal Email",
            hint: "",
          ),
          const SizedBox(height: 16),
          PrimaryTextInputWidget(
            controller: controller.confirmEmailController,
            keyboardType: TextInputType.emailAddress,
            labelText: "Confirm Paypal Email",
            hint: "",
          ),
          const SizedBox(height: 26),
          // Confirm button
          ElevatedButton(
            onPressed: () {
              // Handle confirmation logic here
              debugPrint(
                  'Payout Amount: ${controller.payoutAmountController.text}');
              debugPrint('Email: ${controller.emailController.text}');
              debugPrint(
                  'Confirm Email: ${controller.confirmEmailController.text}');
              debugPrint('Payment Method: ${controller.selectedMethod}');

              if (formKey.currentState!.validate()) {
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
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(languageSettingController.getTranslation('Confirm')),
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
            child: Text(
              languageSettingController.getTranslation("The minimum to withdraw is €25 and the maximum to withdraw per day is €1000"),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Wrap(
                children: List.generate(
                    controller.payoutInfoModel.data.mobilepayCountries.length,
                    (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        controller.selectedCountry.value = controller
                            .payoutInfoModel.data.mobilepayCountries[index];
                        controller.selectedSim.value =
                            controller.selectedCountry.value.sim.first;
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.selectedCountry.value ==
                                    controller.payoutInfoModel.data
                                        .mobilepayCountries[index]
                                ? Theme.of(context).primaryColor
                                : null),
                        child: CircleAvatar(
                          radius: Dimensions.radius * (3.2),
                          backgroundImage: AssetImage(
                              "assets/country/${controller.payoutInfoModel.data.mobilepayCountries[index].flag}.jpeg"),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            languageSettingController.getTranslation("Select Network"),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Obx(() => SizedBox(
                    height: Dimensions.buttonHeight * .8,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              controller.selectedSim.value =
                                  controller.selectedCountry.value.sim[index];
                            },
                            child: _buildNetworkButton(
                                controller.selectedCountry.value.sim[index].mno,
                                controller.selectedCountry.value.sim[index]),
                          );
                        },
                        separatorBuilder: (_, i) => horizontalSpace(5),
                        itemCount: controller.selectedCountry.value.sim.length),
                  )),
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
            error: "The phone number field is required",
            hint: "xx xxxx xxx",
            prefixIcon: const Text(""),
          ),
          const SizedBox(height: 10),
          PrimaryTextInputWidget(
            controller: controller.confirmEmailController,
            keyboardType: TextInputType.phone,
            error: "The confirm phone number field is required",
            labelText: Strings.phoneNumber,
            hint: "xx xxxx xxx",
          ),
          const SizedBox(height: 10),
          PrimaryTextInputWidget(
            controller: controller.payoutAmountController,
            labelText: Strings.enterAmount,
            error: "The amount field is required.",
            hint: "0.0 ",
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          Text(
            languageSettingController.getTranslation(
                "Please make sure you have enough room on your wallet to receive your payment."),
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

              if (formKey.currentState!.validate()) {
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
                      "settings": {
                        /// todo
                        "country": "senegal",
                        "prefix": "221",
                        "sim": "Free"
                      },
                    },
                    onConfirm: () {
                      _showSuccessDialog(
                          'Payout request has been successfully submitted.');
                    });
              }
            },
            child: Text(languageSettingController.getTranslation('Confirm')),
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
            height: 60,
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(color: Theme.of(context).primaryColor, width: 2)
                  : Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: label == "PayPal"
                ? Image.asset(
                    "assets/country/paypal.png",
                    height: 60,
                    width: 100,
                  )
                : Icon(
                    icon,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    size: 40,
                  ),
          ),
          // const SizedBox(height: 8),
          // Text(
          //   label,
          //   style: TextStyle(
          //     fontSize: 14,
          //     fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          //   ),
          // ),
        ],
      ),
    );
  }

  _buildNetworkButton(String network, isSelected) {
    return Obx(() => Container(
          height: Dimensions.buttonHeight * .8,
          width: Dimensions.widthSize * 10,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected == controller.selectedSim.value
                  ? Colors.blue
                  : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8),
            color: isSelected == controller.selectedSim.value
                ? Colors.blue.shade100
                : Colors.white,
          ),
          child: Center(
            child: Text(
              network,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected == controller.selectedSim.value
                    ? Colors.blue
                    : Colors.black,
              ),
            ),
          ),
        ));
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
            selectedTab == 2
                ? TextButton(
                    onPressed: _openList,
                    child: TitleHeading4Widget(text: Strings.list))
                : const SizedBox.shrink()
          ],
        ),
        const SizedBox(height: 20),
        _buildTabContent(),
      ],
    ));
  }

  _buildTabButton(String title, int index) {
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight:
                  selectedTab == index ? FontWeight.bold : FontWeight.normal,
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

  _buildTabContent() {
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

  _buildCanadaTab() {
    return Column(
      children: [
        _buildTextField(
            "Enter Payout Amount", "The amount field is required.",  controller.payoutAmountController),
        _buildTextField(
            "Full name of account holder", "The full name field is required.", controller.accountHolderController),
        _buildTextField("Interac registered email", "The email field is required.",  controller.emailController),
        _buildTextField("Confirm Interac Registered Email", "The email field is required.",
            controller.confirmEmailController),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
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
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(languageSettingController.getTranslation('Confirm')),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildEuropeTab() {
    return Column(
      children: [
        _buildTextField(
            "Enter Payout Amount", "The amount field is required.",  controller.payoutAmountController),
        _buildTextField(
            "Full name of account holder", "The full name field is required.",  controller.accountHolderController),
        _buildTextField("IBAN", "*", controller.emailController),
        _buildTextField("Confirm IBAN", "*",controller.confirmEmailController),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
    if (formKey.currentState!.validate()) {
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
    }
    
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(languageSettingController.getTranslation('Confirm')),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildOutsideEuropeTab() {
    return Column(
      children: [
        Text(
          languageSettingController.getTranslation("View the list to see if your country is listed"),
          style: TextStyle(color: Colors.grey),
        ),
        _buildTextField(
            "Enter Payout Amount", "The amount field is required.", controller.payoutAmountController),
        _buildTextField(
            "Full name of account holder", "The amount field is required.", controller.accountHolderController),
        _buildTextField("SWIFT/BIC Code","*", controller.swiftController),
        _buildTextField("Account Number", "*", controller.emailController),
        _buildTextField(
            "Confirm Account Number", "*", controller.confirmEmailController),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {

    if (formKey.currentState!.validate()) {
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
    }
   
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(languageSettingController.getTranslation('Confirm')),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildTextField(String label, String error, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: PrimaryTextInputWidget(
        labelText: label,
        controller: controller,
        hint: "",
        error: error,
      ),
    );
  }

  _openList() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Supported Country",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      controller.payoutInfoModel.data.bankCountriesList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(controller
                          .payoutInfoModel.data.bankCountriesList[index]),
                      // onTap: () {
                      //   Navigator.pop(context);
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text(
                      //           "Selected: ${controller.payoutInfoModel.data.bankCountriesList[index]}"),
                      //     ),
                      //   );
                      // },
                    );
                  },
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
