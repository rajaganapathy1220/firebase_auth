import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authen/home_screen.dart';
import 'package:firebase_authen/sign_up_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formField = GlobalKey<FormState>();

  bool passwordToggle = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String email = '';
  String password = '';
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formField,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 75,
                ),
                Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 55,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Card(
                    elevation: 22,
                    color: Colors.deepOrange.shade100,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 29.0, right: 29, bottom: 12),
                      child: TextFormField(
                        controller: _emailController,
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
                            return 'Enter Email Id';
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Card(
                    elevation: 22,
                    color: Colors.deepOrange.shade100,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 29.0, right: 29, bottom: 6),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: passwordToggle,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Password',
                          prefixIcon: Icon(
                            Icons.password_sharp,
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
                            return 'Enter Password';
                          }
                          if (value.length < 6) {
                            return 'Password should contain more than 6 characters';
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                      elevation: MaterialStatePropertyAll(22),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.deepOrange)),
                  onPressed: () async {
                    print('Sign In button Clicked');
                    if (_formField.currentState!.validate()) {
                      print('Success');
                      try {
                        await auth
                            .signInWithEmailAndPassword(
                                email: email, password: password)
                            .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen())));
                        print('Successfully Logged in');
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            content: Text(
                                'Invalid email or Password. Please try again')));
                      }
                    }
                  },
                  icon: Icon(
                    Icons.login_outlined,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.black54,
                        thickness: 2,
                        indent: 19,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Text(
                        'or',
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black54,
                        thickness: 2,
                        endIndent: 19,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  'Don\'t have an account ?',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStatePropertyAll(20),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.deepOrange),
                  ),
                  onPressed: () {
                    print('Create account button clicked');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
