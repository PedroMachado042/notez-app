import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:notez/data/notifiers.dart';

class FirestoreService {
  final User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final notesBox = Hive.box('notesBox');

  Future<void> addNote(int id) {
    return firestore.collection(user!.email!).doc('notes$id').set({
      'title': notesBox.get(id)[0],
      'text': notesBox.get(id)[1],
      'timestamp': Timestamp.now(),
    });
  }
  Future<void> addAllNotes() async {
  final collection = FirebaseFirestore.instance.collection(user!.email!);

  final snapshot = await FirebaseFirestore.instance
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

//------------------------------------------------------------------------------

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
      notesBox.put(i, [doc['title'], doc['text']]);
      i += 1;
    }
    notesLenght.value = snapshot.docs.length;
    uiTrigger.value++;
  }

  Future<void> deleteCollection() async {
  final collection = FirebaseFirestore.instance.collection(user!.email!);

  final snapshot = await collection.get();
  for (DocumentSnapshot doc in snapshot.docs) {
    await doc.reference.delete();
  }
}
}