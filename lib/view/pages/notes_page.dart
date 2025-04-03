import 'package:flutter/material.dart';
import 'package:notez/view/widgets/notes_container_widget.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            NotesContainerWidget(),
            NotesContainerWidget(),
            NotesContainerWidget(),
            NotesContainerWidget(),
            NotesContainerWidget(),
            NotesContainerWidget(),
            NotesContainerWidget(),
          ],
        ),
      ),
    );
  }
}
