import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/notifiers.dart';
import 'package:notez/view/services/firestore.dart';

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
  final FirestoreService firestoreService = FirestoreService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  // write data
  void writeData() {
    notesBox.put(widget.id, [
      controllerTitle.text,
      controllerTxt.text,
    ]);
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
      floatingActionButton: FloatingActionButton(
        heroTag: false,
        child: Icon(Icons.check),
        onPressed: () {
          firestoreService.addNote(widget.id);
          //firestoreService.getNotes(widget.id);
          controllerTitle.text = notesBox.get(widget.id)[0];
          controllerTxt.text = notesBox.get(widget.id)[1];
          setState(() {});
        },
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
                  hintText: 'Title',
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
                  hintText: 'Write your notes in here...',
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
