import 'package:custom_floating_action_button/custom_floating_action_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PCamera extends StatefulWidget {
  const PCamera({super.key});

  @override
  State<PCamera> createState() => _PCameraState();
}

class _PCameraState extends State<PCamera> {
  File? _image;
  final imagePicker = ImagePicker();

  Future StoreImage() async {
    final storeImage = await imagePicker.pickImage(source: ImageSource.gallery);
    _image = File(storeImage!.path);
    // print('holaaaaaaaaaaaaaaaaaaaaaaaaa');
    // print(storeImage.path);
  }

  Future getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    _image = File(image!.path);
  }

  changeImage() {
    setState(() {
      Image.file(fit: BoxFit.contain, _image!);
    });
  }

  final database = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    // final _saveimage = database.child('Images');
    return SafeArea(
      child: CustomFloatingActionButton(
        body: Scaffold(
          // appBar: AppBar(title: Text('ViewImage')),
          body: Column(
            children: [
              Center(
                  child: _image == null
                      ? const Text('No Image Selected')
                      : SizedBox(
                          height: 700,
                          child: Image.file(fit: BoxFit.contain, _image!))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        // _saveimage.set(_image);
                        // print(_image.runtimeType);
                      },
                      child: const Text('StoreImage')),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {});
                        StoreImage();
                      },
                      child: Text('Gallery'))
                ],
              )
            ],
          ),

          // floatingActionButton:
          // FloatingActionButton(
          //   onPressed: getImage,
          //   child: Icon(Icons.camera_alt),
          // )
        ),
        options: [
          GestureDetector(
            onTap: () {
              setState(() {
                StoreImage();
              });
            },
            child: const CircleAvatar(
              child: Icon(Icons.house),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _image;
                getImage();
              });
            },
            child: const CircleAvatar(
              child: Icon(Icons.camera_alt),
            ),
          ),
        ],
        type: CustomFloatingActionButtonType.circular,
        openFloatingActionButton: const Icon(Icons.add),
        closeFloatingActionButton: const Icon(Icons.close),
      ),
    );
  }
}
