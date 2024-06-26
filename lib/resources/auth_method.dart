
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_clone/models/user.dart' as model;
import 'package:insta_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//hello
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // Check if the username is unique
        var usernameSnapshot = await _firestore
            .collection('users')
            .where('username', isEqualTo: username)
            .get();

        if (usernameSnapshot.docs.isNotEmpty) {
          // Username already exists
          res = "Username already exists";
          return res;
        }

        // Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print("uid${cred.user!.uid}");

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilepics", file, false);
        print("email${cred.user!.email}");
        //add user to database
        model.User user = model.User(
            username: username,
            email: email,
            uid: cred.user!.uid,
            bio: bio,
            photoUrl: photoUrl,
            followers: [],
            following: []);
       

        // Add user to database
        await _firestore.collection('users').doc(cred.user!.uid).set(user.tojason());
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //login user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "please enter all fields";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
