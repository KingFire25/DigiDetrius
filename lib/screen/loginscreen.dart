// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:digit/authservice.dart';
import 'package:digit/screen/homepage.dart';
import 'package:digit/screen/maploc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signupscreen.dart';
import 'package:flutter/material.dart';
class loginPage extends StatefulWidget 
{
  @override
  State<loginPage> createState() => _HomePageState();
}

class _HomePageState extends State<loginPage> {
  User? res;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final BorderSide bord = BorderSide(color: Colors.white,width: 1);

  TextEditingController email = TextEditingController(),
      pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(
                padding: EdgeInsets.all(10),
                child: Image(image: AssetImage('assets/images/image2.jpg'),
                width: 190,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                  'Digi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  Text(
                  'Detrius',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(44, 167, 123, 0.8),
                    fontFamily: 'Inter',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(12),
                width: 310,
                height: 165,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromRGBO(44, 167, 123, 0.3),
                ),
                child:  Form(
                key: _formKey,
                child: Column(
                  children: [
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(25),
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.email_outlined),
                          focusColor: Colors.greenAccent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                          labelText: "Email",
                          hintText: "Email",
                          floatingLabelBehavior: FloatingLabelBehavior.never
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(25),
                      child: TextFormField(
                        obscureText: true,
                        controller: pass,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          fillColor: Colors.white,
                          focusColor: Colors.red,
                          prefixIconColor: Colors.red,
                          filled: true,
                         border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                          labelText: "Password",
                          hintText: "Password",
                          floatingLabelBehavior: FloatingLabelBehavior.never
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ),
                SizedBox(height: 12,),
              loading?CircularProgressIndicator():ElevatedButton(
                onPressed: ()async{
                  setState(() {
                    loading = true;
                  });
                  if (email.text == "" || pass.text == "")
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Enter all fields!!"),
                      backgroundColor: Colors.redAccent,
                    ));
                  else {
                    res = await AuthService()
                        .login(email.text, pass.text, context);
                    if (res != null)
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => homePage()),
                          (route) => false);
                  }
                  setState(() {
                    loading = false;
                    if(res!=null)
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Login successful!!"),
                          backgroundColor: Colors.green));
                  });
              }, 
                 style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(45, 15 ,45,15 )),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28))),
                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(44, 167, 123, 0.68),
                    )
              ),
              child: Text("Login",style:TextStyle(fontFamily: "Inter",fontSize: 16,letterSpacing: 1,),)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 15, fontFamily: "Inter"),
                ),
                TextButton(onPressed: () {
                  Navigator.popUntil(context,(context)=>false);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => signScreen()));
                  }, 
                child: Text("Sign Up",style: TextStyle(fontFamily:"Inter",color: Color.fromRGBO(44, 167, 123, 0.8),),),),],
              ),
            ],
        ),
      ),
    );
  }
}
