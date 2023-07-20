import 'package:flutter/material.dart';
import 'package:flutter_projects/Components/rounded_button.dart';
import 'package:flutter_projects/Components/rounded_text_field.dart';
import 'package:flutter_projects/models/userEntity.dart';
import 'package:flutter_projects/services/user_services.dart';

/*class UsersListScreen extends StatelessWidget {
  //var users = List<User>.generate(200, (index) => null);

  @override
  Widget build(BuildContext context) {
    getAllUsers();
    return Scaffold(
      appBar: AppBar(
        title: Title(
            color: Colors.lightGreenAccent, child: const Text('Neatness')),
      ),
      body: Container(
        child:
          FutureBuilder<List<User>>(
              future: getAllUsers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Icon(Icons.error),
                    ),
                  );
                }
                else return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text('email'),
                          subtitle: Text('${snapshot.data[index].email}'));
                    });
              })

      ),
    );
  }
}
*/