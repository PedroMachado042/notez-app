import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/notifiers.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key, required this.id});
  final int id;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final notesBox = Hive.box('notesBox');
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerTxt = TextEditingController();

  // write data
  void writeData() {
    notesBox.put(widget.id, [controllerTitle.text, controllerTxt.text]);
  }

  //read data
  void readData() {
    if (notesBox.get(widget.id)[0] != null) {
      controllerTitle.text = notesBox.get(widget.id)[0];
    } else {
      controllerTitle.text = "";
    }
    if (notesBox.get(widget.id)[1] != null) {
      controllerTxt.text = notesBox.get(widget.id)[1];
    } else {
      controllerTxt.text = "";
    }
  }

  //delet data
  void deleteData() {
    notesBox.clear();
  }

  @override
  void initState() {
    super.initState;
    if (!notesBox.containsKey(
      widget.id,
    )) //acessing inexistent key error
    {
      writeData();
    }
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder:
                (context) => [
                  PopupMenuItem(child: Text('Add Tag')),
                  PopupMenuItem(
                    child: Text('Delete'),
                    onTap: () {
                      Navigator.pop(context);
                      shiftValuesBack(widget.id);
                      notesLenght.value -= 1;
                    },
                  ),
                ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                //Titulo
                onChanged: (value) => writeData(),
                controller: controllerTitle,
                style: TextStyle(fontSize: 30),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white30),
                  hintText: 'Título',
                  border: InputBorder.none,
                ),
              ),
              Divider(height: 30),
              TextField(
                //Corpo do texto
                onChanged: (value) => writeData(),
                controller: controllerTxt,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(height: 2.2, fontSize: 16),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white30),
                  hintText: 'Escreva suas notas aqui',
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // EU COPIEI DO GTP, PRECISO APRENDER DEPOIS
  void shiftValuesBack(int missingKey) {
    int lastKey = notesBox.keys.cast<int>().reduce(
      (a, b) => a > b ? a : b,
    );

    for (int i = missingKey; i < lastKey; i++) {
      if (notesBox.containsKey(i + 1)) {
        var nextValue = notesBox.get(i + 1);
        notesBox.put(i, nextValue);
      }
    }
    notesBox.delete(
      lastKey,
    ); // Remove the last entry to avoid duplicates
  }
}
