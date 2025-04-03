import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notez/data/notifiers.dart';
import 'package:notez/view/pages/notes_page.dart';
import 'package:notez/view/pages/tasks_page.dart';
import 'package:notez/view/widgets/navbar_widget.dart';

List<Widget> pages = [NotesPage(), TasksPage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

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
          onPressed: () {},
        ),
      ),
      drawer: Drawer(child: DrawerHeader(child: Text('Texto'))),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notez', style: TextStyle(fontSize: 25)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
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
