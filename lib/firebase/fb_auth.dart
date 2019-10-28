import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FbAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String email, String password, String username, String phone,Function onSuccess) {
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((response){
      createUser(response.user.uid, username, email, phone, onSuccess);
    }).catchError((error){
      print(error);
    });
  }

  void createUser(String id, String username, String email, String phone,Function onSuccess) {
    var user = {"username": username, "email": email, "phone": phone};
    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(id).set(user).then((response) {
      print("Sign up Success");
      onSuccess();}).catchError((error) {
      print(error);
    });
  }
  void signIn(String email,String password,Function onSuccess){
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((response){
      print("Sign in Success");
      onSuccess();
    }).catchError((error){
      print(error);
    });
  }
}
