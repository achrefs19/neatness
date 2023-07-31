import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/Components/custom_image_picker.dart';
import 'package:flutter_projects/Components/drop_down_box.dart';
import 'package:flutter_projects/Components/flat_button.dart';
import 'package:flutter_projects/Components/location_picker.dart';
import 'package:flutter_projects/Components/my_alert_dialog.dart';
import 'package:flutter_projects/Components/rounded_button.dart';
import 'package:flutter_projects/Components/rounded_text_field.dart';
import 'package:flutter_projects/Components/user_image_picker.dart';
import 'package:flutter_projects/constants.dart';
import 'package:flutter_projects/models/eventEntity.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  EventEntity _event = new EventEntity.empty();

  var userCredentials;
  var _dateEvent;
  var _locationEvent;
  File? _selectedImage;
  String _selectedPriority = "";


    final _form = GlobalKey<FormState>();
    void _submit() async {
      final isValid = _form.currentState!.validate();
      //exit if user in sign in and he does'nt select image
      //exit if coordonations is invalid
      if (!isValid) return;
      //save if coordonations is valid
      _form.currentState!.save();
      try {

        //get storageRef
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('event_images')
            .child('sdsqdsqd.jpg');
        //put file in storage
        await storageRef.putFile(_selectedImage!);

        final imageUrl = await storageRef.getDownloadURL();

    final user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection('event').add({
      'organizer': user.uid,
      'topic': _event.topic,
      'subject': _event.subject,
      'date': _event.date.toString(),
      'location': {
        'latitude' : _locationEvent.latitude,
        'longitude' : _locationEvent.longitude
      },
      'priority': _selectedPriority,
      'image': imageUrl
    }).then((value) {
      _event.date = value.toString();
    });} on FirebaseAuthException catch (error) {
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

  void _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025))
        .then((value) {
      _event.date = value.toString();
      _dateEvent = value.toString();
      setState(() {});
    });
  }

  void _showLactionPicker(BuildContext context) async {
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => LocationPicker()),
    );

    _locationEvent = result;
    print(_locationEvent);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
            color: Colors.lightGreenAccent, child: const Text('Neatness')),
        actions: [
          IconButton(onPressed: ()=>FirebaseAuth.instance.signOut(), icon: Icon(Icons.exit_to_app,color: primaryColor,))
        ],
      ),
      body: Form(
        key: _form,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RoundedTextField(
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return 'Please enter a topic';
                  }
                  return null;
                },
                onSaved: (value) => {
                    _event.topic = value
                },
                prefixIcon: Icons.title,
                txtLabel: "Topic",
                radius: 5,
              ),
              SizedBox(
                height: 20,
              ),
              RoundedTextField(
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return 'Please enter a Subject';
                  }
                  return null;
                },
                onSaved: (value) => {
                  _event.subject = value
                },
                prefixIcon: Icons.title,
                txtLabel: "Subject",
                radius: 5,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Event Date',
                style: TextStyle(fontSize: 20, color: primaryColor),
              ),
              FlatButton(
                  onPressed: () => _showDatePicker(context),
                  txt: _dateEvent.toString() == "null" ? "select date":_dateEvent.toString(),
                  backGroundColor: Colors.white,
                  textColor: primaryColor,
                  borderColor: primaryColor,
                  radius: 5,
                  icon: Icons.date_range),
              SizedBox(
                height: 20,
              ),
              Text(
                'Event Location',
                style: TextStyle(fontSize: 20, color: primaryColor),
              ),
              FlatButton(
                  onPressed: () => _showLactionPicker(context),
                  txt: _locationEvent.toString() == "null" ? "select location":_locationEvent.toString() ,
                  backGroundColor: Colors.white,
                  textColor: primaryColor,
                  borderColor: primaryColor,
                  radius: 5,
                  icon: Icons.map_outlined),
              SizedBox(
                height: 20,
              ),
              Text(
                'Event Image',
                style: TextStyle(fontSize: 20, color: primaryColor),
              ),
              CustomImagePicker(
                onPickImage: (pickedImage) => _selectedImage = pickedImage,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Event Priority',
                style: TextStyle(fontSize: 20, color: primaryColor),
              ),
              BuildDropdown(
                itemsList: ['Normal','Crucial'],
                defaultValue: 'Normal',
                dropdownHint: 'Select Priority',
                onChanged: (value) {
                  _selectedPriority = value;
                },
              ),
              MaterialButton(
                onPressed: () => _submit(),
                child: const Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
                color: primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
