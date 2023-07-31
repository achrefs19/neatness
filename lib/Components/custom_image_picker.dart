import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_projects/Components/flat_button.dart';
import 'package:flutter_projects/constants.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  const CustomImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {

  File? _pickedImageFile;
  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 50,maxWidth: 150,);
    if(pickedImage == null){
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () => _pickImage(),
        txt: _pickImage.toString() == "null" ? "add Image":"Select Image",
        backGroundColor: Colors.white,
        textColor: primaryColor,
        borderColor: primaryColor,
        radius: 5,
        icon: Icons.image);
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImageFile != null ? FileImage(_pickedImageFile!):null,
        ),
        TextButton.icon(onPressed: _pickImage,
            icon: const Icon(Icons.image,color: primaryColor,),label: Text('Add Image',style: TextStyle(color: primaryColor),))
      ],
    );
  }
}