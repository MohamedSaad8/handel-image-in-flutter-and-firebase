import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_downloader/image_downloader.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File _image;

  String _url;

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
                Builder(
                  builder: (context) => RaisedButton(
                    onPressed: () {
                      uploadImage(context);
                    },
                    child: Text("Upload Image"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  onPressed: loadImage,
                  child: Text("load Image"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void geImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void uploadImage(context) async {
    try {
      FirebaseStorage firebaseStorage =
          FirebaseStorage(storageBucket: 'gs://handel-images.appspot.com');
      StorageReference storageReference =
          firebaseStorage.ref().child(p.basename(_image.path));
      StorageUploadTask storageUploadTask = storageReference.putFile(_image);
      StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
      String url = await snapshot.ref.getDownloadURL();
      Scaffold.of(context).showSnackBar((SnackBar(
        content: Text("success"),
      )));
      print(url);
      setState(() {
        _url = url;
      });
    } catch (ex) {
      Scaffold.of(context).showSnackBar((SnackBar(
        content: Text(ex.message),
      )));
    }
  }

  void loadImage() async {
   String imageID = await ImageDownloader.downloadImage(_url);
   var path = await ImageDownloader.findPath(imageID);
   File image = File(path);
   setState(() {
     _image = image ;
   });

  }
}
