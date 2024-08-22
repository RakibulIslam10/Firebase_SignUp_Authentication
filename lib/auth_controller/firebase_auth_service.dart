import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Password Week", "The password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Email already in use",
            "The account already exists for that email");
      } else {
        Get.snackbar("Error", "Failed to create account. Please try again.");
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred.");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Password Week", "The password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Email already in use",
            "The account already exists for that email");
      } else {
        Get.snackbar(
            "Account not found", "please check current email and password");
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred.");
    }
    return null;
  }
}
