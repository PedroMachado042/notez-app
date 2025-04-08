import 'package:flutter/cupertino.dart';
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
  DateTime pickerTime = DateTime.now();
  DateTime dateTime = DateTime.now();
  bool hasReminder = false;
  TextEditingController controllerInput = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    

    void writeData() {
      tasksBox.put(tasksBox.length, [controllerInput.text, false, hasReminder ? dateTime : 0]);
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
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder:
                      (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10),
                          SizedBox(
                            height: 220,
                            child: CupertinoDatePicker(
                              itemExtent: 50,
                              initialDateTime: pickerTime,
                              onDateTimeChanged: (DateTime newTime) {
                                setState(() => pickerTime = newTime);
                              },
                              use24hFormat: true,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(160, 50),
                                  backgroundColor: Colors.white10,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(160, 50),
                                  backgroundColor:
                                      const Color.fromARGB(
                                        255,
                                        6,
                                        99,
                                        92,
                                      ),
                                ),
                                onPressed: () {
                                  dateTime = pickerTime;
                                  print(dateTime);
                                  Navigator.pop(context);
                                  setState(() {
                                    hasReminder = true;
                                  });
                                },
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 60),
                        ],
                      ),
                );
              },
              icon: Icon(
                Icons.alarm,
                color: hasReminder ? Colors.teal : Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text(
                hasReminder
                    ? '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}'
                    : '',
                style: TextStyle(fontSize: 18, color: Colors.teal),
              ),
            ),
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
              child: Text(
                'Create',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
