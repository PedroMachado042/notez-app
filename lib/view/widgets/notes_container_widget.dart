import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/dummy_data.dart';
import 'package:notez/data/notifiers.dart';
import 'package:notez/view/pages/note_page.dart';

class NotesContainerWidget extends StatefulWidget {
  const NotesContainerWidget({super.key, required this.id});
  final int id;

  @override
  State<NotesContainerWidget> createState() =>
      _NotesContainerWidgetState();
}

class _NotesContainerWidgetState extends State<NotesContainerWidget> {
  final notesBox = Hive.box('notesBox');
  String? noteTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 10,
        child: InkWell(
          highlightColor: const Color.fromARGB(20, 0, 125, 100),
          splashColor: DummyData.inkwellColor[colorTheme.value],
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        NotePage(id: widget.id, canDelete: true),
              ),
            ).then((value) {
              //refresh text value in containers when come back
              setState(() {});
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notesBox.get(widget.id)[0].toString(), //Titulo
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: DummyData.mainColor[colorTheme.value],  fontSize: 20),
                ),
                Text(
                  notesBox
                      .get(widget.id)[1]
                      .toString(), //descrição ou linha mais recente
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  isLogged.value ? '16:20' : '16:20', //horario
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
