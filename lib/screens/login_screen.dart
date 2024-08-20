import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginandsingup/screens/home_screen.dart';

import '../auth_controller/firebase_auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                "Please enter your Email and password ",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 70),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  Get.to(const LoginScreen());
                  return null;
                },
                controller: _emailController,
                decoration: const InputDecoration(hintText: "Email"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter your Password";
                  }
                  return null;
                },
                controller: _passwordController,
                decoration: const InputDecoration(hintText: "Password"),
              ),
              const SizedBox(height: 32),
              SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {}
                        _logIn();
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(fontSize: 18),
                      ))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Do not have an account",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Sing Up",
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _logIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      Get.snackbar(
        "Success",
        "Login successfully!",
        icon: const Icon(Icons.check, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      Get.offAll(const HomeScreen());
    }
    return null;
  }
}
