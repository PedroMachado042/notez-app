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
  final _myBox = Hive.box('mybox');
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerTxt = TextEditingController();

  // write data
  void writeData() {
    _myBox.put(widget.id, [controllerTitle.text, controllerTxt.text]);
  }

  //read data
  void readData() {
    if (_myBox.get(widget.id)[0] != null) {
      controllerTitle.text = _myBox.get(widget.id)[0];
    } else {
      controllerTitle.text = "";
    }
    if (_myBox.get(widget.id)[1] != null) {
      controllerTxt.text = _myBox.get(widget.id)[1];
    } else {
      controllerTxt.text = "";
    }
  }

  //delet data
  void deleteData() {
    _myBox.clear();
  }

  @override
  void initState() {
    super.initState;
    if (!_myBox.containsKey(
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

  void shiftValuesBack(int missingKey) { // EU COPIEI DO GTP, PRECISO APRENDER DEPOIS
    int lastKey = _myBox.keys.cast<int>().reduce(
      (a, b) => a > b ? a : b,
    );

    for (int i = missingKey; i < lastKey; i++) {
      if (_myBox.containsKey(i + 1)) {
        var nextValue = _myBox.get(i + 1);
        _myBox.put(i, nextValue);
      }
    }
    _myBox.delete(
      lastKey,
    ); // Remove the last entry to avoid duplicates
  }
}
