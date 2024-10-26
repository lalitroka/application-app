import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _identityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Create separate GlobalKeys for the forms
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool _obsecure = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> _login() async {
    if (!_loginFormKey.currentState!.validate()) return;

    String identity = _identityController.text.trim();
    String password = _passwordController.text.trim();

    try {
      UserCredential? userCredential;

      bool isEmail = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
          .hasMatch(identity);

      if (isEmail) {
        log('Attempting login with email: $identity');
        userCredential = await _auth.signInWithEmailAndPassword(
            email: identity, password: password);
      } else {
        log('Attempting login with username: $identity');

        QuerySnapshot userQuery = await _firebaseFirestore
            .collection('users')
            .where('username', isEqualTo: identity.trim())
            .get();
      }

      log("User logged in: $userCredential");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );

      Navigator.pushNamed(context, '/dashboardpage');
    } catch (e) {
      String errorMessage = _getErrorMessage(e);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  String _getErrorMessage(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'Email or Username is incorrect.';
        case 'wrong-password':
          return 'Password is incorrect.';
        default:
          return 'Login failed: ${e.message}';
      }
    } else if (e.toString().contains('Username-not-found')) {
      return 'Username is incorrect.';
    } else {
      return 'Login failed: ${e.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('asset/loginbg.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            key: _loginFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 136),
                  child: Image(
                    image: AssetImage('asset/infodev.png'),
                    height: 52,
                    width: 160,
                    filterQuality: FilterQuality.none,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12, left: 20),
                  child: Text(
                    'Human Resource System',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.28,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 132, left: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.74,
                        ),
                      ),
                      Text(
                        'Please sign in to continue',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.4,
                            color: Colors.grey[700]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              height: 42,
                              child: TextFormField(
                                controller: _identityController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email or username';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.person_2_outlined,
                                    color: Color.fromARGB(255, 187, 162, 162),
                                  ),
                                  hintText: 'Email or Username',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              height: 42,
                              child: TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                obscureText: _obsecure,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obsecure = !_obsecure;
                                        });
                                      },
                                      icon: Icon(
                                        _obsecure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.grey,
                                      )),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.lock_open_outlined,
                                    color: Color.fromARGB(255, 187, 162, 162),
                                  ),
                                  hintText: 'Password ',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          const Text('Remember Me')
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text('Forgot Password?'),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: const EdgeInsets.only(left: 30, right: 36, top: 10),
                  width: double.infinity,
                  height: 40,
                  child: GestureDetector(
                    onTap: () {
                      log("Login button tapped");
                      _login();
                    },
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
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
