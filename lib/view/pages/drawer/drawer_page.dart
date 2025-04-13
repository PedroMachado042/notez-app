import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notez/data/notifiers.dart';
import 'package:notez/view/pages/settings_page.dart';
import 'package:notez/view/services/auth_service.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 220,
              color: Colors.teal.withAlpha(100),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(
                      'assets/images/aaaa.png',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user!.displayName!,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    user!.email!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text("Edit Profile"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Log Out"),
          onTap: () {
            isLogged.value = false;
            AuthService().signout();
          },
        ),
        ListTile(
          leading: Icon(Icons.delete_forever, color: Colors.red),
          title: Text(
            "Delete Account",
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            AuthService().signout();
            AuthService().deleteAccount();
          },
        ),
      ],
    );
  }
}
