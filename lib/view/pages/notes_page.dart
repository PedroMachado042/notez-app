import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/notifiers.dart';
import 'package:notez/view/widgets/notes_container_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final notesBox = Hive.box('notesBox');
  @override
  void initState() {
    super.initState;
    notesLenght.value = notesBox.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ValueListenableBuilder<int>(
          valueListenable: notesLenght,
          builder: (context, value, child) {
            return Column(
              children: List.generate(
                value,
                (index) => NotesContainerWidget(id: index),
              ),
            );
          },
        ),
      ),
    );
  }
}
