import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/Components/info_card.dart';

class ProfileScreen extends StatefulWidget {
  final int number;
  ProfileScreen({this.number=0});

  static String id = '/profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Neatness'),
          centerTitle: true,
          actions: [IconButton(onPressed: ()=>FirebaseAuth.instance.signOut(), icon: Icon(Icons.exit_to_app,color: Colors.red,))],
        ),
        body: Column(
          children: [
            intro(),
            about(title: 'about',info: 'a book or other written or printed work, regarded in terms of its content rather than its physical form.'),
            ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, 'messages_page'),
                icon: Icon(Icons.message_outlined),
                label: Text('Contact Me')),
          ],
        )
    );
  }

  Container intro() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade500,
            Colors.grey.shade700,
            Colors.grey.shade900
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/profile_pic.jpg'),
                radius: 50,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Lucile Barrett',
                style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'New York, NY',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  badge(icon: Icons.star, type: 'Rating', value: 3.5),
                  badge(icon: Icons.work, type: 'Employments', value: 4),
                  badge(icon: Icons.work, type: 'Employments', value: 4)
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column badge({IconData icon = Icons.add, String type = '', double value = 0}) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          type,
          style: TextStyle(fontSize: 10, color: Colors.grey[500]),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '$value',
          style: TextStyle(color: Colors.white, fontSize: 20),
        )
      ],
    );
  }}