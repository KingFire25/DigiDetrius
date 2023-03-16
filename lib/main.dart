// ignore_for_file: prefer_const_constructors

import 'package:digit/authservice.dart';
import 'package:digit/screen/homepage.dart';
import 'package:digit/screen/loginscreen.dart';
import 'package:digit/screen/signupscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DigiDetrius',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: AuthService().auth.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return homePage();
            }
          return loginPage();
        },)
      
    );
  }
}
