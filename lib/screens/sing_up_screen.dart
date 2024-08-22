import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginandsingup/auth_controller/firebase_auth_service.dart';
import 'package:loginandsingup/screens/home_screen.dart';
import 'package:loginandsingup/screens/login_screen.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 60),
                const Text(
                  " Enter your info  to complete your profile",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 70),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter password";
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
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _signUp();
                            }
                          },
                          child: const Text(
                            "Sing Up",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                ),
                const SizedBox(height: 20),
                buildTextButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;

  void _signUp() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    setState(() {
      isLoading = true;
    });
    User? user = await _auth.signUpWithEmailAndPassword(email, password);
    setState(() {
      isLoading = false;
    });

    if (user != null) {
      Get.snackbar(
        "Success",
        "Sign up successfully!",
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

  Row buildTextButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account",
          style: TextStyle(fontSize: 18),
        ),
        TextButton(
            onPressed: () {
              Get.to(const LoginScreen());
            },
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ))
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
