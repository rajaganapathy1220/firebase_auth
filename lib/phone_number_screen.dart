import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authen/enter_otp_screen.dart';
import 'package:flutter/material.dart';

class PhoneNUmberScreen extends StatefulWidget {
  const PhoneNUmberScreen({super.key});

  static String verify = '';

  @override
  State<PhoneNUmberScreen> createState() => _PhoneNUmberScreenState();
}

class _PhoneNUmberScreenState extends State<PhoneNUmberScreen> {
  var phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Phone Verification',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 355,
                child: TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    hintText: 'Enter Phone Number',
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 255,
                child: MaterialButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+91${phoneNumberController.text}',
                      verificationCompleted: (phoneAuthCredential) {
                        print('verified');
                      },
                      verificationFailed: (error) {
                        print('verify Failed');
                      },
                      codeSent: (verificationId, forceResendingToken) {
                        PhoneNUmberScreen.verify = verificationId;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpScreen()));
                      },
                      codeAutoRetrievalTimeout: (verificationId) {

                      },
                    );
                  },
                  child: Text(
                    'Send OTP',
                    style: TextStyle(color: Colors.white60),
                  ),
                  color: Colors.blueAccent.shade400,
                  elevation: 22,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(25)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
