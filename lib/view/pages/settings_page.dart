import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/dummy_data.dart';
import 'package:notez/data/notifiers.dart';
import 'package:notez/view/services/firestore.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final notesBox = Hive.box('notesBox');
  final tasksBox = Hive.box('tasksBox');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 30,
            children: [
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                      50,
                      0,
                      150,
                      135,
                    ),
                  ),
                  onPressed: () {
                    loadDummy();
                    FirestoreService().addAllNotes();
                    FirestoreService().addAllTasks();
                  },
                  child: Text(
                    'Load test notes',
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                      40,
                      244,
                      67,
                      54,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actionsAlignment:
                              MainAxisAlignment.spaceBetween,
                          title: Text('Delete All Notes?'),
                          content: Text(
                            'there is no coming back, bro',
                          ),
                          actions: [
                            FilledButton(
                              onPressed: () {
                                Navigator.pop(context);
                                notesBox.clear();
                                notesLenght.value = 0;
                                tasksBox.clear();
                                tasksLenght.value = 0;
                                FirestoreService().deleteCollection();
                              },style: TextButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 26, 26, 26),
    foregroundColor: Colors.redAccent,
    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  ),
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            FilledButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },style: TextButton.styleFrom(
    backgroundColor: const Color(0xFFD0BFFF), // soft lavender
    foregroundColor: Colors.black87,
    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  ),
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Delete All Notes',
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
