import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/Components/icon_button.dart';
import 'package:flutter_projects/Components/my_alert_dialog.dart';
import 'package:flutter_projects/Components/rounded_button.dart';
import 'package:flutter_projects/Components/rounded_text_field.dart';
import 'package:flutter_projects/Components/user_image_picker.dart';
import 'package:flutter_projects/constants.dart';
import 'package:flutter_projects/models/userEntity.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});
  static String id = '/inscription';

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _form = GlobalKey<FormState>();
  void _submit() async {
    final isValid = _form.currentState!.validate();
    //exit if user in sign in and he does'nt select image
    if (!_isLogin && _selectedImage == null) return;
    //exit if coordonations is invalid
    if (!isValid) return;
    //save if coordonations is valid
    _form.currentState!.save();
    try {

      if (_isLogin) {
        userCredentials = await _firebase.signInWithEmailAndPassword(
            email: user.email, password: user.password);
        print("+{$userCredentials}");
      } else {
        userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: user.email, password: user.password);
      }

      //get storageRef
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${userCredentials.user!.uid}.jpg');
      //put file in storage
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(userCredentials.user!.uid).set({
        'firstname': user.firstName,
        'lastname' : user.lastName,
        'email' : user.email,
        'image_url' : imageUrl,
      });

    } on FirebaseAuthException catch (error) {
      //if (error.code == 'email-already-in-use') {}
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext) {
            return MyAlertDialog(
                title: 'Authentification failed', content: error.message ?? "");
          });
    }
  }

  var _isLogin = true;
  File? _selectedImage;
  UserEntity user = new UserEntity();
  var userCredentials;
  final _firebase = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 30,right: 30),
        child: Form(
          key: _form,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_isLogin) Hero(tag:'profile pic',child: Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('assets/neatness_logo.png')),)
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(_isLogin? 'Welcome back !':'Register Now !',style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(
                  height: 20,
                ),
                if (!_isLogin)
                  UserImagePicker(
                    onPickImage: (pickedImage) => _selectedImage = pickedImage,
                  ),
                if (!_isLogin)
                  RoundedTextField(
                    prefixIcon: Icons.account_box,
                    txtLabel: "firstName",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a valide name';
                      }
                      return null;
                    },
                    onSaved: (value) => user.firstName = value,
                  ),
                SizedBox(
                  height: 10,
                ),
                if (!_isLogin)
                  RoundedTextField(
                    prefixIcon: Icons.account_box,
                    txtLabel: "lastName",
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return 'Please enter a valide name';
                      }
                      return null;
                    },
                    onSaved: (value) => user.lastName = value,
                  ),
                SizedBox(
                  height: 10,
                ),
                RoundedTextField(
                  prefixIcon: Icons.email,
                  txtLabel: "Email",
                  hintText: "type in your email",
                  validator: (value) {
                    if (value == null ||
                        value.toString().isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter a valide name';
                    }
                    return null;
                  },
                  onSaved: (value) => user.email = value,
                ),
                SizedBox(
                  height: 10,
                ),
                /*RoundedTextField(
                  prefixIcon: Icons.villa,
                  txtLabel: "governorate",
                  hintText: "type in your governorate",
                  validator: (value) {
                    if (value == null || value.toString().isEmpty) {
                      return 'Please enter a valide address';
                    }
                    return null;
                  },
                  onSaved: (value) => user.governorate = value,
                ),
                SizedBox(
                  height: 10,
                ),
                RoundedTextField(
                  prefixIcon: Icons.villa,
                  txtLabel: "city",
                  validator: (value) {
                    if (value == null || value.toString().isEmpty) {
                      return 'Please enter a valide address';
                    }
                    return null;
                  },
                  onSaved: (value) => user.city = value,
                ),
                SizedBox(
                  height: 10,
                ),*/
                RoundedTextField(
                  prefixIcon: Icons.lock,
                  txtLabel: "Password",
                  isPassword: true,
                  validator: (value) {
                    if (value.trim().length < 6) {
                      return 'Password must be at least 6 characters long.';
                    }
                    return null;
                  },
                  onSaved: (value) => user.password = value,
                ),
                SizedBox(
                  height: 10,
                ),
                if (!_isLogin)
                  RoundedTextField(
                    prefixIcon: Icons.lock,
                    txtLabel: "Confirm Password",
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return 'Please enter a valide name';
                      }
                      return null;
                    },
                    onSaved: (value) => user.confirmPassword = value,
                  ),
                /*Row(
                  children: [
                    Checkbox(
                      onChanged: (v)=>{},
                      value: false,
                      shape: CircleBorder(),
                      fillColor: MaterialStateProperty.resolveWith((states) => secondaryColor,),
                    ),
                    Text('Remember me',style: TextStyle(
                      color: secondaryColor
                    ),)
                  ],
                ),*/
                SizedBox(
                  height: 30,
                ),
                RoundedButton(
                  onPressed: () => _submit(),
                  txt: _isLogin ? "Login" : 'Signup',
                  backGroundColor: Colors.white,
                  textColor: Colors.black38,
                  borderColor: Colors.black38,
                  radius: 30,
                ),
                TextButton(
                    onPressed: () => setState(() {
                      _isLogin = _isLogin ? false : true;
                    }),
                    child: Text(_isLogin
                        ? 'Create an accound'
                        : 'I already have an account',style: TextStyle(
                      color: secondaryColor
                    ),))
              ]),
        ),
      ),);
  }
}

/*
RoundedButton(
txt: "s'inscrire",
onPressed: () => inscription(
User(
firstName: _firstNameController.text,
lastName: _lastNameController.text,
email: _emailController.text,
governorate: _governorateController.text,
city: _cityController.text,
password: _passwordController.text,
confirmPassword: _confirmPasswordController.text),
context),
backGroundColor: Colors.white,
textColor: Colors.black38,
borderColor: Colors.black38,
),
RoundedButton(
onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UsersListScreen())))
],*/
