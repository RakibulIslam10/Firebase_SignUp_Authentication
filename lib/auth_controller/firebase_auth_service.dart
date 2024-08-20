import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Something error");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Something error");
    }
    return null;
  }
}











//class AuthController extends GetxController {
//   Future<User?> signUp({required String email, required String password}) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//       return userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         Get.snackbar('Error', 'The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         Get.snackbar('Error', 'Theaccount already exists for that email.');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to register.');
//     }
//     return null;
//   }
//
//   Future<User?> signIn(String email, String password) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       return userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         Get.snackbar('Error', 'No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         Get.snackbar('Error', 'Wrong password provided for that user.');
//       }
//     }
//     return null;
//   }
// }
