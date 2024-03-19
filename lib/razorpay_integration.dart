import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayIntegration extends StatefulWidget {
  const RazorPayIntegration({super.key});

  @override
  State<RazorPayIntegration> createState() => _RazorPayIntegrationState();
}

class _RazorPayIntegrationState extends State<RazorPayIntegration> {
  var amountController = TextEditingController();
  late Razorpay razorpay;

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSucess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlePaymentExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Integration'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 28, right: 28),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 0.5,
                        spreadRadius: 0.5,
                        color: Colors.grey,
                        offset: Offset(0, 5))
                  ],
                  borderRadius: BorderRadius.circular(55),
                  color: Colors.deepOrange.shade50),
              child: TextFormField(
                controller: amountController,
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 28),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter amount to be paid';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                style: ButtonStyle(elevation: MaterialStatePropertyAll(12)),
                onPressed: () {
                  if (amountController.text.toString().isNotEmpty) {
                    setState(() {
                      int amount = int.parse(amountController.text.toString());
                      openCheckOut(amount);
                    });
                  }
                },
                child: Text('Pay'))
          ],
        ),
      ),
    );
  }

  openCheckOut(amount) {
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_PIutURymC0rFP3',
      'amount': amount,
      'name': 'StartUp',
      'prefill': {
        'contact': '9360261781',
        'email': 'rajaganapathy.d.t@gmail.com'
      },
      'external': {
        'wallets': ['Gpay',
        'PhonePe'
        ]
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  handlePaymentSucess() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Successfull')));
  }

  handlePaymentError() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Failed')));
  }

  handlePaymentExternalWallet() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('External Wallet')));
  }
}
