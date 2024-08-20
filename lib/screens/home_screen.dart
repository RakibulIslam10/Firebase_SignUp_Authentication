import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:loginandsingup/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Screen"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const Center(
            child: Text(
              "Wellcome ",
              style: TextStyle(fontSize: 32, color: Colors.amberAccent),
            ),
            
          ),
          
          ElevatedButton(onPressed: (){

          FirebaseAuth.instance.signOut();
          Get.offAll(const LoginScreen());
          }, child: const Text("Sign Out"))
        ],
      ),
    );
  }
}
