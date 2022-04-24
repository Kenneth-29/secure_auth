import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class lUser {
  final String id;
  final String name;
  final String email;
  final String password;

  lUser({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  lUser.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.data()!["id"],
        name = doc.data()!["name"],
        email = doc.data()!["email"],
        password = doc.data()!["password"];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
