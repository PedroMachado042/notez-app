import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/notifiers.dart';
import 'package:audioplayers/audioplayers.dart';

class TasksContainerWidget extends StatefulWidget {
  const TasksContainerWidget({super.key, required this.id});
  final int id;

  @override
  State<TasksContainerWidget> createState() =>
      _TasksContainerWidgetState();
}

class _TasksContainerWidgetState extends State<TasksContainerWidget> {
  final tasksBox = Hive.box('tasksBox');
  final AudioPlayer audioPlayer = AudioPlayer();
  DateTime dateTime = DateTime.now();

  void playSound() async {
    await audioPlayer.play(AssetSource('audios/boom.mp3'));
    audioPlayer.setVolume(.5);
  }

  @override
  void initState() {
    super.initState();
    audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Card(
            elevation: 10,
            child: InkWell(
              highlightColor: const Color.fromARGB(20, 0, 125, 100),
              splashColor: const Color.fromARGB(60, 0, 125, 100),
              borderRadius: BorderRadius.circular(10),
              onLongPress: () {
                shiftValuesBack(widget.id);
                tasksLenght.value -= 1;
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: // essa deu orgulho
                      tasksBox.get(widget.id)[2] != 0 ? 20 : 10,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 275,
                          child: Text(
                            tasksBox
                                .get(widget.id)[0]
                                .toString(), //Titulo
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              //color: Colors.teal,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        if (tasksBox.get(widget.id)[2] != 0)
                          Row(
                            children: [
                              Icon(
                                Icons.alarm,
                                color: Colors.teal,
                                size: 17,
                              ),
                              Text(
                                tasksBox.get(widget.id)[2].day !=
                                        dateTime.day
                                    ? ' ${tasksBox.get(widget.id)[2].day.toString().padLeft(2, '0')}/${tasksBox.get(widget.id)[2].month.toString().padLeft(2, '0')}  ${tasksBox.get(widget.id)[2].hour}:${tasksBox.get(widget.id)[2].minute.toString().padLeft(2, '0')}'
                                    : ' ${tasksBox.get(widget.id)[2].hour}:${tasksBox.get(widget.id)[2].minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white38,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    Spacer(),
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        activeColor: Colors.teal,
                        checkColor: Colors.black,
                        value: tasksBox.get(widget.id)[1],
                        onChanged: (value) {
                          setState(() {
                            print(tasksBox.toMap());
                            value == true ? playSound() : 0;
                            tasksBox.put(widget.id, [
                              tasksBox.get(widget.id)[0],
                              value,
                              tasksBox.get(widget.id)[2],
                            ]);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ), //Black thing that overlays task when done
          if (tasksBox.get(widget.id)[1])
            Positioned.fill(
              child: IgnorePointer(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.5),
                      borderRadius: BorderRadius.circular(10),
                    ), // Adjust opacity as needed
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // EU COPIEI DO GTP, PRECISO APRENDER DEPOIS
  void shiftValuesBack(int missingKey) {
    int lastKey = tasksBox.keys.cast<int>().reduce(
      (a, b) => a > b ? a : b,
    );

    for (int i = missingKey; i < lastKey; i++) {
      if (tasksBox.containsKey(i + 1)) {
        var nextValue = tasksBox.get(i + 1);
        tasksBox.put(i, nextValue);
      }
    }
    tasksBox.delete(
      lastKey,
    ); // Remove the last entry to avoid duplicates
  }
}
