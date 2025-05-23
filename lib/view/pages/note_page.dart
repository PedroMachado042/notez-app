import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/dummy_data.dart';
import 'package:notez/data/notifiers.dart';
import 'package:notez/view/services/firestore.dart';

class NotePage extends StatefulWidget {
  const NotePage({
    super.key,
    required this.id,
    required this.canDelete,
  });
  final int id;
  final bool canDelete;

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
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (isLogged.value && controllerTitle.text != '') {
          FirestoreService().addNote(widget.id);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions:
              widget.canDelete
                  ? [
                    PopupMenuButton(
                      itemBuilder:
                          (context) => [
                            //PopupMenuItem(child: Text('Add Tag')),
                            PopupMenuItem(
                              child: Text('Delete'),
                              onTap: () {
                                print(user);
                                Navigator.pop(context);
                                shiftValuesBack(widget.id);
                                if (isLogged.value) {
                                  shiftNotesBackInFirestore(
                                    widget.id,
                                  );
                                }
                                notesLenght.value -= 1;
                              },
                            ),
                          ],
                    ),
                  ]
                  : [],
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 5,
          ),
          child: SizedBox(
            height: 60,
            width: 60,
            child: FloatingActionButton(
              onPressed: () async {
                if (isLogged.value && controllerTitle.text != '') {
                  await FirestoreService().addNote(widget.id);
                }
                Navigator.pop(context);
              },
              heroTag: null,
              backgroundColor:
                  DummyData.buttonColor[colorTheme.value],
              child: Icon(Icons.check, size: 32),
            ),
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

  // MAIS UM DO GPT, APRENDER DEPOIS
  Future<void> shiftNotesBackInFirestore(int missingKey) async {
    final collection = FirebaseFirestore.instance.collection(
      user!.email!,
    );

    // Descobrir o maior índice atual (última nota)
    int lastKey = 0;
    final snapshot = await collection.get();
    for (var doc in snapshot.docs) {
      final id = doc.id;
      if (id.startsWith('notes')) {
        final index = int.tryParse(id.replaceFirst('notes', ''));
        if (index != null && index > lastKey) {
          lastKey = index;
        }
      }
    }

    // Shift: mover notas seguintes para trás
    for (int i = missingKey; i < lastKey; i++) {
      final currentDoc = collection.doc('notes$i');
      final nextDoc = collection.doc('notes${i + 1}');

      final nextSnapshot = await nextDoc.get();
      if (nextSnapshot.exists) {
        await currentDoc.set(
          nextSnapshot.data()!,
        ); // copia os dados para o anterior
      }
    }

    // Deleta o último documento duplicado
    await collection.doc('notes$lastKey').delete();
  }
}
