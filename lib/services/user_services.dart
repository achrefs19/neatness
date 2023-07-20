import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_projects/Components/my_alert_dialog.dart';
import 'package:flutter_projects/models/userEntity.dart';
import 'package:http/http.dart' as http;


/*Future<User> inscription(
    User user,BuildContext context
    ) async {

  var url = Uri.http('10.0.2.2:8080', 'adduser');
  var response = await http.post(url, headers:<String,String>{"Content-Type":"application/json"},
      body:jsonEncode(<String,String>{
        "nom":user.nom,
        "prenom":user.prenom,
        "email":user.email,
        "ville":user.ville,
        "gouvernorat":user.gouvernorat,
        "mdp":user.mdp,
        "cmdp":user.cmdp
      }));
  //notification pour le succés
  if(response.statusCode == 200){
    showDialog(context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(title: 'Notify', content: response.body);
        });}
  //notification pour l'échec
  if(response.statusCode == 500){
    showDialog(context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(title: 'Notify', content: response.body);
        });}
  return User();
}

Future <List<User>> getAllUsers()async{
  var url = Uri.http('10.0.2.2:8080', 'getallusers');
  var data = await http.get(url);
  var jsonData = jsonDecode(data.body);

  List <User> users = [];
  for(var e in jsonData){
    users.add(User.fromJson(e));
  }
  print(users);

  return users;
}*/