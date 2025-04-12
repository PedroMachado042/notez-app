import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/notifiers.dart';
import 'package:notez/view/pages/note_page.dart';
import 'package:notez/view/pages/notes_page.dart';
import 'package:notez/view/pages/settings_page.dart';
import 'package:notez/view/pages/tasks_page.dart';
import 'package:notez/view/widgets/navbar_widget.dart';
import 'package:notez/view/widgets/task_create_widget.dart';

List<Widget> pages = [NotesPage(), TasksPage()];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  final notesBox = Hive.box('notesBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(
            255,
            6,
            99,
            92,
          ), //(160, 0, 150, 135)
          shape: CircleBorder(),
          child: Icon(Icons.add, size: 35),
          onPressed: () {
            if (selectedPageNotifier.value == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotePage(id: notesBox.length),
                ),
              ).then((value) {
                //refresh text value in containers when come back
                print(notesBox.toMap());
                notesLenght.value = notesBox.length;
                if (notesBox.get(notesBox.length - 1)[0] == '') {
                  //null title safety
                  notesBox.delete(notesBox.length - 1);
                  notesLenght.value -= 1;
                }
              });
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return TaskCreateWidget();
                },
              );
            }
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          spacing: 5,
          children: [
            SizedBox(
              height: 90,
              width: double.infinity,
              child: DrawerHeader(child: Text('Profile')),
            ),
            SizedBox(height: 10),
            CircleAvatar(radius: 45),
            Text(
              'Guest',
              style: TextStyle(fontSize: 22, color: Colors.white54),
            ),
            // Text('guest.sus@gmail.com',style: TextStyle(fontSize: 12, color: Colors.white54),),
            SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black.withAlpha(80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black.withAlpha(80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            IconButton(onPressed: () {
              
            }, icon: Image.asset('assets/images/google_logo.png',height: 25,))
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notez', style: TextStyle(fontSize: 25)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
              //getData();
            },
            icon: Icon(Icons.settings),
          ),
        ],
        backgroundColor: CupertinoColors.placeholderText,
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),

      bottomNavigationBar: NavbarWidget(),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
    );
  }
}
