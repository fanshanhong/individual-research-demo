import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

///
/// 图片选择页面
/// 包括从相册选择和拍照
///
class PickPage extends StatefulWidget {
  @override
  _PickPageState createState() => _PickPageState();
}

class _PickPageState extends State<PickPage> {
  File _image;

  // 相机拍照
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  // 从相册选择
  Future getImageFormGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Column(
        children: <Widget>[
          GestureDetector(
            child: RaisedButton(
              child: Text('从相册选择一张图片'),
              onPressed: getImageFormGallery,
            ),
          ),
          Center(
            child: _image == null ? Text('No image selected.') : Image.file(_image),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // 拍照图片
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
