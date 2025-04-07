import 'package:flutter/material.dart';

class TasksContainerWidget extends StatefulWidget {
  const TasksContainerWidget({super.key});

  @override
  State<TasksContainerWidget> createState() =>
      _TasksContainerWidgetState();
}

class _TasksContainerWidgetState extends State<TasksContainerWidget> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 10,
        child: InkWell(
          highlightColor: const Color.fromARGB(20, 0, 125, 100),
          splashColor: const Color.fromARGB(60, 0, 125, 100),
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            //print('aaa');
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task', //Titulo
                      style: TextStyle(
                        //color: Colors.teal,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Transform.scale(
                  scale: 1.5,
                  child: Checkbox(
                    activeColor: const Color.fromARGB(
                      200,
                      255,
                      255,
                      255,
                    ),
                    checkColor: Colors.black,
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
