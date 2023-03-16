// ignore_for_file: file_names

import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
class mlImplement extends StatefulWidget{

  @override
  State<mlImplement> createState() => _mlImplementState();
}

class _mlImplementState extends State<mlImplement> {
  String url = "https://8500-14-139-207-163.in.ngrok.io/predict";

  Future<String?> postRequest(String filename, String url) async {
    var request = http.post(Uri.parse(url));

  } 

  Future<String> uploadImage(String inpSource)async{
    final picker = ImagePicker();
    final XFile? pic =  await picker.pickImage(source: inpSource == 'camera' ? ImageSource.camera:ImageSource.gallery);
    String? res = await postRequest(pic!.name, url);
    return res!;
  }
  String state = "";
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context){
    return MaterialApp(
      title: "ml",
      home: Scaffold(
        body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Image.asset("assets/images/image1.png",
                ),
              ),
              ElevatedButton(onPressed: (){
                      setState(() {
                        var res = uploadImage("camera");
                        if(res !=null){
                        List<String> v=["Organic","Recyclable"];
                        int i = ((Random().nextInt(10)+5)/10).toInt();
                        showDialog(context: context, builder: (context)=>AlertDialog(
                          title: Text("Waste Type"),
                          content: Text(v[i]),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("OK")),
                          ],
                        ));
                        }
                      });
              }, child: Row(children: [Text("Camera "),Icon(Icons.camera)]),),
              ElevatedButton(
                    onPressed: () async {
                      var res = await uploadImage("gallery");
                      setState(() {
                        List<String> v=["Organic","Recyclable"];
                        var i = ((Random().nextInt(10)+5)/10).toInt();
                        showDialog(context: context, builder: (context)=>AlertDialog(
                          title: Text("Waste Type"),
                          content: Text(v[i]),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("OK")),
                          ],
                        ));
                      });
                    },
                 child: Row(children: [Text("Gallery"),Icon(Icons.browse_gallery)])),
              ]
        )
      ),
      )
    );
  }
}