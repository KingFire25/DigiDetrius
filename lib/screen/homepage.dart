// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:digit/authservice.dart';
import 'package:digit/screen/loginscreen.dart';
import 'package:digit/screen/maploc.dart';
import 'package:digit/screen/mlImplement.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget{
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
int karma=1000;

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/image1.png"),
            TextButton.icon(
                    onPressed: () async {
                      await AuthService().signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => loginPage()),
                          (context) => false);
                    },
                    label: const Text(
                      "Log Out",
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                  ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Colors.green,
                  Colors.cyan.shade600
                ]),
                color: Colors.blueGrey[200],
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              
              height: 200,
              width: MediaQuery.of(context).size.width*0.7,
              // decoration: ,
              child: Column(
                children: [
                  Image.asset("assets/images/icon.png",width: 70,color: Colors.white,),
                  Text("Karma Points ",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 30,
                            color: Colors.white
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(karma.toString(),style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 30,
                        color: Color.fromARGB(210, 255, 255, 255)
                      ),
                      ),
                      Image.asset("assets/images/flame.png",width: 20,height: 20,),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Stack(
                children: <Widget>[
                  Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width*0.9,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color.fromRGBO(44, 167, 123, 0.3),
                          ),
                          child: Column(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  showDialog(context: context, builder: (context)=>AlertDialog(
                                    title: Text("Do you need help in separating waste?"),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>mlImplement() ));
                                      }, child: Text("Yes")),
                                      TextButton(onPressed: (){}, child: Text("No"))
                                    ],
                                  ));
                                },
                                label: const Text(
                                  "Domestic",
                                  style: TextStyle(fontFamily: "Inter",fontSize: 32,color: Colors.black),
                                ),
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    Colors.greenAccent[100]),
                                  alignment: Alignment.center,
                                    minimumSize:
                                        MaterialStateProperty.all(Size(310, 80)),
                                    elevation: MaterialStateProperty.all(3),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            side: BorderSide(width: 1)))),
                                icon: const Icon(
                                  Icons.home,
                                  color: Colors.black,
                                  size: 50,
                                  shadows: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 54, 73, 78),
                                    offset: Offset(3, 5),
                                    blurRadius: 22),
                              ],
                                ),
                              ),
                              SizedBox(height: 16,),
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    karma+=5;
                                  });
                                },
                                label: const Text(
                                  "Dustbin",
                                  style: TextStyle(fontFamily: "Inter",fontSize: 30,color: Colors.black),
                                ),
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    Colors.greenAccent[100]),
                                  alignment: Alignment.center,
                                    minimumSize:
                                        MaterialStateProperty.all(Size(310, 80)),
                                    elevation: MaterialStateProperty.all(3),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            side: BorderSide(width: 1)))),
                                icon: const Icon(
                                  Icons.delete_rounded,
                                  color: Colors.black,
                                  shadows: [
                                BoxShadow( color: Color.fromARGB(255, 54, 73, 78),offset: Offset(4, 5),blurRadius: 20),
                              ],
                                  size: 48,
                                ),
                              ),
                              SizedBox(height: 16,),
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    karma += 10;
                                  });
                                },
                                label: const Text(
                                  "Dump",
                                  style: TextStyle(fontFamily: "Inter",fontSize: 32,color: Colors.black),
                                ),
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(Colors.greenAccent[100]),
                                  alignment: Alignment.center,
                                    minimumSize:
                                        MaterialStateProperty.all(Size(310, 80)),
                                    elevation: MaterialStateProperty.all(3),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            side: BorderSide(width: 1)))),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                  shadows: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 54, 73, 78),
                                    offset: Offset(4, 5),
                                    blurRadius: 14),
                              ],
                                  size: 50,
                                ),
                              ),
                              SizedBox(height: 16,),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.push(context, 
                                  MaterialPageRoute(builder: (context) => mapLocation())
                                  );
                                },
                                label: const Text(
                                  "Track",
                                  style: TextStyle(fontFamily: "Inter",fontSize: 32,color: Colors.black),
                                ),
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    Colors.greenAccent[100]),
                                  alignment: Alignment.center,
                                    minimumSize:
                                        MaterialStateProperty.all(Size(310, 80)),
                                    elevation: MaterialStateProperty.all(3),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            side: BorderSide(width: 1)))),
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: 50,
                                  shadows: [
                                    BoxShadow(color: Color.fromARGB(255, 54, 73, 78),
                                    offset: Offset(3, 5),
                                    blurRadius: 14),
                                  ],
                                ),
                              ),
                          ],
                          ),
                  ),
                ]
                    )
          ]
      ),
      )
        ),
    );
  }
}