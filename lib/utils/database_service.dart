import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secure_auth/model/user_model.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final CollectionReference _usersCollection = _db.collection("Users");

Future createUser(lUser user) async {
  try {
    await _usersCollection.doc(user.id).set(user.toJson());
  } catch (e) {
    return e.toString();
  }
}
