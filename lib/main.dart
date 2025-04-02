import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notez/view/widgets/container_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: Container(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(160, 0, 150, 135),
            shape: CircleBorder(),
            child: Icon(Icons.add, size: 35),
            onPressed: () {},
          ),
        ),
        drawer: Drawer(
          child: DrawerHeader(child: Text('Texto')),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Notez', style: TextStyle(fontSize: 25)),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
          ],
          backgroundColor: CupertinoColors.placeholderText,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 20,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                ContainerWidget(),
                ContainerWidget(),
                ContainerWidget(),
                ContainerWidget(),
                ContainerWidget(),
                ContainerWidget(),
                ContainerWidget(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.view_agenda_outlined),
              label: 'Notes',
            ),
            NavigationDestination(
              icon: Icon(Icons.check_box_outlined),
              label: 'Tasks',
            ),
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
