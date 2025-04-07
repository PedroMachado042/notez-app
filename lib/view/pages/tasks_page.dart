import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/data/notifiers.dart';
import 'package:notez/view/widgets/tasks_container_widget.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final tasksBox = Hive.box('tasksBox');
  @override
  void initState() {
    super.initState;
    tasksLenght.value = tasksBox.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ValueListenableBuilder<int>(
          valueListenable: tasksLenght,
          builder: (context, value, child) {
            return Column(
              children: List.generate(
                value,
                (index) => TasksContainerWidget(id: index),
              ),
            );
          },
        ),
      ),
    );
  }
}
