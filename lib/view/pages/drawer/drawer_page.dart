import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notez/data/dummy_data.dart';
import 'package:notez/data/notifiers.dart';
import 'package:notez/view/pages/profile_page.dart';
//import 'package:notez/view/pages/settings_page.dart';
import 'package:notez/view/services/auth_service.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final prefsBox = Hive.box('prefsBox');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 220,
              color: DummyData.mainColor[colorTheme.value].withAlpha(
                100,
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  CircleAvatar(
                    radius: 45,
                    backgroundImage:
                        user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : AssetImage('assets/images/aaaa.png'),
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
          onTap: () {
            print(user);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
        PopupMenuButton<String>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          constraints: BoxConstraints.loose(Size(70, 300)),
          offset: const Offset(70, 0),
          itemBuilder:
              (context) => [
                const PopupMenuItem(
                  value: '1',
                  child: Icon(
                    Icons.invert_colors,
                    color: Colors.teal,
                    size: 32,
                  ),
                ),
                const PopupMenuItem(
                  value: '2',
                  child: Icon(
                    Icons.invert_colors,
                    color: Colors.green,
                    size: 32,
                  ),
                ),
                const PopupMenuItem(
                  value: '3',
                  child: Icon(
                    Icons.invert_colors,
                    color: Colors.pinkAccent,
                    size: 32,
                  ),
                ),
                const PopupMenuItem(
                  value: '4',
                  child: Icon(
                    Icons.invert_colors,
                    color: Colors.deepPurple,
                    size: 32,
                  ),
                ),
              ],
          onSelected: (value) {
            colorTheme.value = int.parse(value) - 1;
            prefsBox.put(0, colorTheme.value);
            Phoenix.rebirth(context);
          },
          child: ListTile(
            leading: Icon(Icons.color_lens),
            title: Text("Theme Color"),
            trailing: Icon(
              Icons.invert_colors,
              color: DummyData.mainColor[colorTheme.value],
            ),
          ),
        ),
        /*
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
        ),*/
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Log Out"),
          onTap: () {
            AuthService().signout(false);
          },
        ),
        ListTile(
          leading: Icon(Icons.delete_forever, color: Colors.red),
          title: Text(
            "Delete Account",
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  title: Text('Delete Account?'),
                  content: Text('there is no coming back, bro'),
                  actions: [
                    FilledButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        AuthService().signout(true);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          26,
                          26,
                          26,
                        ),
                        foregroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(
                          0xFFD0BFFF,
                        ), // soft lavender
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      child: Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
