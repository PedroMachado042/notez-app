import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/notifiers.dart';
import 'package:notez/view/pages/note_page.dart';
import 'package:notez/view/pages/notes_page.dart';
import 'package:notez/view/pages/tasks_page.dart';
import 'package:notez/view/widgets/navbar_widget.dart';

List<Widget> pages = [NotesPage(), TasksPage()];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  final _myBox = Hive.box('mybox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(160, 0, 150, 135),
          shape: CircleBorder(),
          child: Icon(Icons.add, size: 35),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotePage(id: _myBox.length),
              ),
            ).then((value) {
              //refresh text value in containers when come back
              print(_myBox.toMap());
              notesLenght.value = _myBox.length;
              print(notesLenght.value);
              setState(() {});
            });
          },
        ),
      ),
      drawer: Drawer(child: DrawerHeader(child: Text('Texto'))),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notez', style: TextStyle(fontSize: 25)),
        actions: [
          IconButton(
            onPressed: () {
              _myBox.clear();
              notesLenght.value = 0;
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
