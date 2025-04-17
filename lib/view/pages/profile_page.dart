import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:notez/data/dummy_data.dart';
import 'package:notez/data/notifiers.dart';
import 'package:notez/view/services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController usernameController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    DateTime? creationDate = user!.metadata.creationTime;

    return Scaffold(
      appBar: AppBar(title: Text('Profile Page')),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              SizedBox(height: 10),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : AssetImage('assets/images/aaaa.png'),
                  ),/*
                  Positioned(
                    bottom: -5,
                    right: -10,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(40, 40),
                        shape: CircleBorder(),
                      ),
                      onPressed: () {},
                      child: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),*/
                ],
              ),
              SizedBox(
                width: 300,
                child: Text(
                  'Username:',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white30),
                  hintText: user!.displayName!,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: Text(
                  'E-mail:',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                width: 300,
                child: Text(
                  user!.email!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white30,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(160, 50),
                  backgroundColor:
                      DummyData.buttonColor[colorTheme.value],
                ),
                onPressed: () {
                  if (usernameController.text != '') {
                    AuthService().updateUsername(
                      usernameController.text,
                    );
                  }
                  Navigator.pop(context);
                  Phoenix.rebirth(context);
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 180),
              Text(
                'Account created at: ${creationDate!.day}-${creationDate.month}-${creationDate.year} ${creationDate.hour}:${creationDate.minute}',
                style: TextStyle(color: Colors.white30, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
