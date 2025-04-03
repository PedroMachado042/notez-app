import 'package:flutter/material.dart';
import 'package:notez/view/pages/note_page.dart';

class NotesContainerWidget extends StatelessWidget {
  const NotesContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 10,
        child: InkWell(
          highlightColor: const Color.fromARGB(20, 0, 125, 100),
          splashColor: const Color.fromARGB(60, 0, 125, 100),
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotePage()),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anotações', //Titulo
                  style: TextStyle(color: Colors.teal, fontSize: 20),
                ),
                Text(
                  'Fazer isso aqui', //descrição ou linha mais recente
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  '16:20', //horario
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
