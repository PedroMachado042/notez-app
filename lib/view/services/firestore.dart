import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:notez/data/notifiers.dart';

class FirestoreService {
  final User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final notesBox = Hive.box('notesBox');
  final tasksBox = Hive.box('tasksBox');

  Future<void> addNote(int id) {
    return firestore.collection(user!.email!).doc('notes$id').set({
      'title': notesBox.get(id)[0],
      'text': notesBox.get(id)[1],
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> addAllNotes() async {
    final collection = FirebaseFirestore.instance.collection(
      user!.email!,
    );

    final snapshot =
        await FirebaseFirestore.instance
            .collection(user!.email!)
            .get();
    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
    for (int i = 0; i < notesBox.length; i++) {
      final note = notesBox.get(i);
      await collection.doc('notes$i').set({
        'title': note[0],
        'text': note[1],
        'timestamp': Timestamp.now(),
      });
    }
    notesLenght.value = notesBox.length;
    uiTrigger.value++;
  }

  //----------------------------------------------------------------------------

  Future<void> getNotes(int id) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance
            .collection(
              user!.email!,
            ) // Replace with your collection name
            .doc('notes$id') // Replace with your document ID
            .get();
    return notesBox.put(id, [snapshot['title'], snapshot['text']]);
  }

  Future<void> getAllNotes() async {
    int i = 0;
    notesBox.clear();
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance
            .collection(user!.email!)
            .get();
    for (DocumentSnapshot doc in snapshot.docs) {
      if (doc.id.startsWith('notes')) {
        notesBox.put(i, [doc['title'], doc['text']]);
        i += 1;
      }
    }
    notesLenght.value = i;
    uiTrigger.value++;
  }

  //----------------------------------------------------------------------------
  Future<void> addTask(int id) {
    return firestore.collection(user!.email!).doc('tasks$id').set({
      'title': tasksBox.get(id)[0],
      'isChecked': tasksBox.get(id)[1],
      'time': tasksBox.get(id)[2],
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> addAllTasks() async {
    final collection = FirebaseFirestore.instance.collection(
      user!.email!,
    );

    final snapshot =
        await FirebaseFirestore.instance
            .collection(user!.email!)
            .get();
    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
    for (int i = 0; i < tasksBox.length; i++) {
      final task = tasksBox.get(i);
      await collection.doc('tasks$i').set({
        'title': task[0],
        'isChecked': task[1],
        'time': task[2],
        'timestamp': Timestamp.now(),
      });
    }
    tasksLenght.value = tasksBox.length;
    uiTrigger.value++;
  }

  Future<void> getAllTasks() async {
    int i = 0;
    tasksBox.clear();
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance
            .collection(user!.email!)
            .get();
    for (DocumentSnapshot doc in snapshot.docs) {
      if (doc.id.startsWith('tasks')) {
        tasksBox.put(i, [
          doc['title'],
          doc['isChecked'],
          doc['time'] is int ? doc['time'] : doc['time'].toDate(),
        ]);
        i += 1;
      }
    }
    tasksLenght.value = i;
    uiTrigger.value++;
  }

  Future<void> deleteCollection() async {
    final collection = FirebaseFirestore.instance.collection(
      user!.email!,
    );

    final snapshot = await collection.get();
    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
  //----------------------------------------------------------------------------
}
