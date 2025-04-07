import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/notifiers.dart';

class TaskCreateWidget extends StatefulWidget {
  const TaskCreateWidget({super.key});

  @override
  State<TaskCreateWidget> createState() => _TaskCreateWidgetState();
}

class _TaskCreateWidgetState extends State<TaskCreateWidget> {
  final tasksBox = Hive.box('tasksBox');
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerInput = TextEditingController();

    void writeData() {
      tasksBox.put(tasksBox.length, [controllerInput.text, false]);
    }

    return AlertDialog(
      alignment: Alignment(0, .65),
      //shape: BeveledRectangleBorder(),
      content: Row(
        children: [
          Expanded(child: TextField(controller: controllerInput)),
          Icon(Icons.square_outlined),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.alarm)),
            ElevatedButton(
              onPressed: () {
                if (controllerInput.text == '') {
                  print('tem nada');
                } else {
                  Navigator.pop(context);
                  writeData();
                  tasksLenght.value = tasksBox.length;
                  print(tasksBox.toMap());
                }
              },
              child: Text('Create'),
            ),
          ],
        ),
      ],
    );
  }
}
