import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HerafyModel {
  String? uid;
  String? DOB;
  String? email;
  String? name;
  String? password;
  String? phone_number;

  HerafyModel(
      {this.uid,
      this.DOB,
      this.email,
      this.name,
      this.password,
      this.phone_number});

  factory HerafyModel.fromMap(map) {
    return HerafyModel(
        uid: map['uid'],
        DOB: map['DOB'],
        email: map['email'],
        name: map['name'],
        password: map['password'],
        phone_number: map['phone_number']);
  }

  Map<String, dynamic> toMAp() {
    return {
      'uid': uid,
      'DOB': DOB,
      'email': email,
      'name': name,
      'password': password,
      'phone_number': phone_number,
    };
  }
}

// class Authbase {
//   Customer _userFromFirebase(FirebaseUser user) {
//     return Customer(uid: user.uid);
//   }

//   Future<void> registerWithEmailAndPassword(
//       String DOB, String email, String name, String password) async {
//     final authresult = await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password);
//   }
// }
