import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_auth/model/user_model.dart';
import 'package:secure_auth/utils/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

// Firebase auth instance with user id and email
final FirebaseAuth _auth = FirebaseAuth.instance;

String? uid;
String? userEmail;

class AuthClient {
  //Register with email and password
  Future<User?> register(String name, String email, String password) async {
    await Firebase.initializeApp();
    User? user;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      user = _auth.currentUser;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;

        //TODO has to hash password before saving to firestore

        String hashedPassword = sha256.convert(utf8.encode(password)).toString();

        print(hashedPassword);

        lUser myUser =
            lUser(id: user.uid, name: name, email: email, password: hashedPassword);

        await DataStore.createUser(myUser);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('An account already exists for the email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  // Login method
  Future<User?> login(String email, String password) async {
    await Firebase.initializeApp();
    User? user;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('auth', true);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  // Sign out method
  Future<String> signOut() async {
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', false);

    uid = null;
    userEmail = null;

    return 'User signed out';
  }

  // TODO Change Password
  // TODO Reset Password
}
