import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authen/home_screen.dart';
import 'package:firebase_authen/phone_number_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = '';

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (index) => TextEditingController());
    _focusNodes = List.generate(6, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pinput(
                obscureText: true,
                keyboardType: TextInputType.number,
                length: 6,
                onChanged: (value) {
                  code = value;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: PhoneNUmberScreen.verify,
                            smsCode: code);
                    await auth.signInWithCredential(credential);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  } catch (e) {
                    print('Invalid otp');
                    ScaffoldMessenger.of(context).showSnackBar(
                        new SnackBar(content: Text('Invalid Otp')));
                  }
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  // Resend OTP logic
                },
                child: Text('Resend OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
