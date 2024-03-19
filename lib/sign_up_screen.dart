import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authen/home_screen.dart';
import 'package:firebase_authen/login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var confirmPassController = TextEditingController();
  bool passwordToggle = false;
  String password = '';
  String email = '';
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade100,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                ),
                Text(
                  'Sign up',
                  style: TextStyle(
                      fontSize: 55,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Card(
                    elevation: 22,
                    color: Colors.deepOrange.shade100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: TextFormField(
                        controller: emailController,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Email Id',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.deepOrange,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email';
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Card(
                    elevation: 22,
                    color: Colors.deepOrange.shade100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: passwordToggle,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Password',
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.deepOrange,
                          ),
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                passwordToggle = !passwordToggle;
                              });
                            },
                            child: Icon(passwordToggle
                                ? Icons.visibility_off_sharp
                                : Icons.visibility_sharp),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          }
                          if (value.length < 7) {
                            return 'Password should contain more than 6 characters';
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Card(
                    elevation: 22,
                    color: Colors.deepOrange.shade100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: TextFormField(
                        controller: confirmPassController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.deepOrange,
                          ),
                        ),
                        validator: (value) {
                          if (value != passwordController.text) {
                            return 'Confirm Password does not Match with Password';
                          }
                          if (value!.isEmpty || value == null) {
                            return 'Confirm Password Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      print('Validated and signed up');
                      try {
                        final UserCredential usercredential =
                            await auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        await usercredential.user!.sendEmailVerification();
                        print('Verification email sent');
                        await usercredential.user!.reload();
                        while (!usercredential.user!.emailVerified) {
                          CircularProgressIndicator();
                          print('Email not verified yet, waiting...');
                          await Future.delayed(
                              Duration(seconds: 5)); // Check every 5 seconds
                          await usercredential.user!.reload();
                          if (usercredential.user!.emailVerified) {
                            break;
                          }
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));

                        print('Successfully Signed up');
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(20),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.deepOrange)),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an Account ?',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                        style: ButtonStyle(
                            elevation: MaterialStatePropertyAll(29)),
                        onPressed: () {
                          print('Sign In Button Clicked');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
