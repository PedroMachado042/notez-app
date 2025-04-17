import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/dummy_data.dart';
import 'package:notez/data/notifiers.dart';
import 'package:notez/view/pages/drawer/drawer_guest_page.dart';
import 'package:notez/view/pages/drawer/drawer_page.dart';
import 'package:notez/view/pages/note_page.dart';
import 'package:notez/view/pages/notes_page.dart';
import 'package:notez/view/pages/tasks_page.dart';
import 'package:notez/view/services/firestore.dart';
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
  final tasksBox = Hive.box('tasksBox');
  final prefsBox = Hive.box('prefsBox');
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  @override
  void initState() {
    super.initState();
    if (user != null) {
      isLogged.value = true;
      FirestoreService().getAllNotes();
      FirestoreService().getAllTasks();
    }
    if (!isLogged.value &&
        notesBox.get(0) == null &&
        tasksBox.get(0) == null) {
      welcomeNote();
      print('Welcome Note');
    }
    if(prefsBox.get(0) != null)
    {
      colorTheme.value = prefsBox.get(0);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          backgroundColor: DummyData.buttonColor[colorTheme.value],
          //(160, 0, 150, 135)
          shape: CircleBorder(),
          child: Icon(Icons.add, size: 35),
          onPressed: () {
            if (selectedPageNotifier.value == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => NotePage(
                        id: notesBox.length,
                        canDelete: false,
                      ),
                ),
              ).then((value) {
                //refresh text value in containers when come back
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
                  return TaskCreateWidget(id: tasksBox.length);
                },
              );
            }
          },
        ),
      ),
      drawer: Drawer(
        child: ValueListenableBuilder(
          valueListenable: isLogged,
          builder: (context, isLogged, child) {
            return isLogged ? DrawerPage() : GuestPage();
          },
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notez', style: TextStyle(fontSize: 25)),
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: isLogged,
            builder: (context, isLogged, child) {
              if (isLogged) return Icon(Icons.person);
              return Icon(Icons.person_off);
            },
          ),
          SizedBox(width: 15),
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
