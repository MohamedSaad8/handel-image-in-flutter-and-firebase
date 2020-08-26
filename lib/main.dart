import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File _image ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 80,
                  backgroundImage: _image == null ? null : FileImage(_image),
                ),
                IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  ),
                  onPressed: geImage,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {},
                  child: Text("Upload Image"),
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text("load Image"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void geImage() async{

    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image ;
    });

  }
}
