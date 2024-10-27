import 'package:next_wisher/utils/basic_screen_imports.dart';

class WishRequest extends StatefulWidget {
  const WishRequest({super.key});

  @override
  WishRequestState createState() => WishRequestState();
}

class WishRequestState extends State<WishRequest> {
  final TextEditingController _amountController = TextEditingController();
  bool isActivated = true;

  @override
  void initState() {
    super.initState();
    _amountController.text = '50'; // default amount
  }

  void _toggleActivation(bool value) {
    setState(() {
      isActivated = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wish Request'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Please setup an amount to charge for Wish Request',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter Amount',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      // Handle Update/Save logic here
                      debugPrint("Amount saved: ${_amountController.text}");
                    },
                    title: 'Update/Save'
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Activate',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                InkWell(
                  onTap: () => _toggleActivation(true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isActivated ? Colors.green : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Yes',
                          style: TextStyle(
                            color: isActivated ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isActivated)
                          const Icon(Icons.check, color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => _toggleActivation(false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: !isActivated ? Colors.green : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'No',
                      style: TextStyle(
                        color: !isActivated ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: PrimaryButton(
                onPressed: () {
                  // Handle Preview Profile action
                  debugPrint("Preview Profile clicked");
                },
                title: 'Preview Profile',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
