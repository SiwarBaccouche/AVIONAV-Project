//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth;
  AuthenticationHelper(this._auth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _auth.idTokenChanges();
  get user => _auth.currentUser;

//SIGN UP METHOD
  Future<String> signUp({String email, String password}) async {
    try {
      final userId = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userId.toString();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHODJ
  Future<String> signIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      //  await _auth.signInAnonymously();

      return "connected";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future<void> signOut() async {
    await _auth.signOut();

    debugPrint('signout');
  }
}



/*

import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.onAuthStateChanged.map(
            (FirebaseUser user) => user?.uid,
      );

  // GET UID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  // Email & Password Sign Up
  Future<String> createUserWithEmailAndPassword(String email, String password,
      String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Update the username
    await updateUserName(name, currentUser);
    return currentUser.uid;
  }

  Future updateUserName(String name, FirebaseUser currentUser) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }

  // Email & Password Sign In
  Future<String> signInWithEmailAndPassword(String email,
      String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password))
        .uid;
  }

  // Sign Out
  signOut() {
    return _firebaseAuth.signOut();
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Create Anonymous User


  Future convertUserWithEmail(String email, String password, String name) async {
    final currentUser = await _firebaseAuth.currentUser();

    final credential = EmailAuthProvider.getCredential(email: email, password: password);
    await currentUser.linkWithCredential(credential);
    await updateUserName(name, currentUser);
  }

  

  

}

class NameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }
}*/