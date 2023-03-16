import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> register(String email,String password,BuildContext context)async{
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.redAccent,));
    }
  }
  Future<User?> login(String email,String password,BuildContext context) async{
    try{
    UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.redAccent,));
  }
  }
  Future signOut() async{
    await auth.signOut();
  }
}

