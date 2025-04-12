import 'package:flutter/material.dart';
import 'package:notez/view/pages/settings_page.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

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
                    'Pedro Machado',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'guest.sus@gmail.com',
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
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.delete_forever,color: Colors.red,),
          title: Text("Delete Account",style: TextStyle(color: Colors.red),),
          onTap: () {},
        ),
      ],
    );
  }
}
