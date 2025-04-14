import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:notez/data/notifiers.dart';
import 'package:notez/view/services/firestore.dart';

class AuthService {
  final notesBox = Hive.box('notesBox');
  final tasksBox = Hive.box('tasksBox');


  Future<void> signup({
    required String username,
    required String email,
    required String password,
    required context,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
      await userCredential.user!.updateDisplayName(username);
      isLogged.value = true;
      Navigator.pop(context);
      await FirestoreService().getAllNotes();
      await FirestoreService().getAllTasks();
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else if (e.code == 'channel-error') {
        message = 'Please fill both fields';
      }
      print(e.code);
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black87,
      );
    } catch (e) {}
  }

  //--------------------------------------------------------------------------

  Future<void> signin({
    required String email,
    required String password,
    required context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLogged.value = true;
      Navigator.pop(context);
      await FirestoreService().getAllNotes();
      await FirestoreService().getAllTasks();
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found' || e.code == 'invalid-email') {
        message = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password!';
      } else if (e.code == 'channel-error') {
        message = 'Please fill both fields';
      }
      print(e.code);
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black87,
      );
    } catch (e) {}
  }

  //--------------------------------------------------------------------------

  Future<void> signout(bool delete) async {
    delete ? [await FirestoreService().deleteCollection(), await FirebaseAuth.instance.currentUser!.delete()]:await FirebaseAuth.instance.signOut();
    isLogged.value = false;
    tasksLenght.value = 0;
    tasksBox.clear();
    print('signout');
    notesLenght.value = 0;
    notesBox.clear();
    print('signout');
  }

  //--------------------------------------------------------------------------

  Future<void> noUsername() async {
    Fluttertoast.showToast(
      msg: 'Type a username',
      backgroundColor: Colors.black87,
    );
  }
}
