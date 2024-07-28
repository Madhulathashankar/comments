import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseReference = FirebaseFirestore.instance;

  User? get user => _auth.currentUser;

  Future<void> signUp(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firebaseReference.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'email': email,
      });

      notifyListeners();
    } catch (e) {
      print("Exception $e");
      throw e;
    }
  }

  Future<void> signIn(String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw "The password is incorrect. Please try again.";
      } else if (e.code == 'user-not-found') {
        throw "No user found with this email. Please check your email.";
      } else {
        throw "An error occurred: ${e.message}";
      }
    } catch (e) {
      print("Exception $e");
      throw "An unexpected error occurred. Please try again.";
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
