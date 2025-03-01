import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_list/screens/authentication/view/signin.dart';
import 'package:task_list/screens/dashboard/taskscreen.dart';

class AuthService {
  Future<bool> signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (user != null) {
        FirebaseFirestore.instance.collection("users").doc(user.user!.uid).set({
          "email": user.user!.email,
          "Id": user.user!.uid,
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => TaskScreen()),
        );
      }
      return true;
    } on FirebaseException catch (e) {
      String message = "";
      if (e.code == "weak-password") {
        message = "The password provided is too weak";
      } else if (e.code == "email-already-in-use") {
        message = "An account already exists with this email";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 5),
        ),
      );
      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "An unexpected error occurred",
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 5),
        ),
      );
      return false;
    }
  }

  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TaskScreen()),
        );
        if (userDoc.exists) {
          var userData = userDoc.data() as Map<String, dynamic>;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "User does not exist",
                style: TextStyle(color: Colors.red),
              ),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == "wrong-password") {
        message = "Wrong password";
      } else if (e.code == "user-not-found") {
        message = "No user found with this email";
      } else {
        message = "An unexpected error occurred: ${e.message}";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "An unexpected error occurred",
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> signout({
    required BuildContext context,
  }) async {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Sign_in()),
    );
  }
}
