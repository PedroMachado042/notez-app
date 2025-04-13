import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

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

  Future<void> getNotes(int id) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance
            .collection(
              user!.email!,
            ) // Replace with your collection name
            .doc('notes$id') // Replace with your document ID
            .get();
    print(notesBox.toMap());
    return notesBox.put(id, [snapshot['title'], snapshot['text']]);
  }
}
