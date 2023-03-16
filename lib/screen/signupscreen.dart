// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digit/authservice.dart';
import 'package:digit/screen/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'loginscreen.dart';
import 'package:flutter/material.dart';

class signScreen extends StatefulWidget{
  @override
  State<signScreen> createState() => _signScreenState();
}

class _signScreenState extends State<signScreen> {
  bool loading = false;
  User? res;
  final _fmKey = GlobalKey<FormState>();
  FirebaseFirestore store = FirebaseFirestore.instance;   
  TextEditingController pass = TextEditingController(),email = TextEditingController(),
  loc = TextEditingController(), name = TextEditingController();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(elevation: 0,
      toolbarHeight: 0,
      backgroundColor: Colors.green[500],),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: Image.asset("assets/images/image1.png",
              ),
            ),
            Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(height: 50),
                      Text(
                        'Digi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(44, 167, 123, 0.8),
                          fontFamily: 'Inter',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Detrius',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 15),
            Text("Sign Up",
              style: TextStyle(fontFamily: "Inter",fontSize: 30,
              shadows:  const <Shadow>[
                        Shadow(
                          offset: Offset(0.0, 2.0),
                          blurRadius: 8,
                          color: Color.fromARGB(255, 106, 106, 106),
                        ),
                      ],
                    ),
              ),
            SizedBox(height: 20,),
            Container(
                    padding: EdgeInsets.all(12),
                    width: 310,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color.fromRGBO(44, 167, 123, 0.3),
                    ),
                    child: Form(
                      key: _fmKey,
                      child: Column(
                        children: [
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(25),
                            child: TextFormField(
                              controller: name,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(Icons.person),
                                  focusColor: Colors.greenAccent,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(30)),
                                  labelText: "Name",
                                  hintText: "Name",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(25),
                            child: TextFormField(
                              controller: loc,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.location_on),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(30)),
                                  labelText: "Location",
                                  hintText: "Location",
                                  floatingLabelBehavior: FloatingLabelBehavior.never),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(25),
                            child: TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(30)),
                                  labelText: "Email",
                                  hintText: "Email",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(25),
                            child: TextFormField(
                              controller: pass,
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.lock),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(30)),
                                  labelText: "Password",
                                  hintText: "Password",
                                  floatingLabelBehavior: FloatingLabelBehavior.never),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(height: 20,),
            loading?CircularProgressIndicator(color: Colors.green[200],): ElevatedButton(
                      onPressed: ()async{
                        setState(() {
                              loading = true;
                            });
                            if (email.text == "" || pass.text == "" || name.text =="" || loc.text == "")
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("All fields are required !!"),
                                backgroundColor: Colors.deepOrange,
                              ));
                            else {
                              res = await AuthService()
                                  .register(email.text, pass.text, context);
                              if (res != null){
                                CollectionReference users = store.collection('users');
                                await users.add({
                                  'name': name.text,
                                  'location': loc.text,
                                });
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => homePage()),
                                    (route) => false);
                              }
                            }
                            setState(() {
                              loading = false;
                              if (email.text != "" && pass.text != "")
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Account created successfully!!"),
                                        backgroundColor: Color.fromARGB(
                                            255, 16, 208, 70)));
                            });
                      },
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(5),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(45, 15, 45, 15)),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28))),
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(44, 167, 123, 0.68),
                          )),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      )),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account?",style: TextStyle(fontSize: 15,fontFamily: "Inter" ),),
                  TextButton(
                    onPressed: () {
                      Navigator.popUntil(context, (context) => false);
                      Navigator.push(context,MaterialPageRoute(builder: (context) => loginPage()));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 15,fontFamily: "Inter",
                        color: Color.fromRGBO(44, 167, 123, 0.8),
                      ),
                    ),
                  ),
                ],
              ),
            
          ]
      ),
      )
      )
    );
  }
}