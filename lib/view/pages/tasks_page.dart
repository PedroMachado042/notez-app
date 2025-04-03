import 'package:flutter/material.dart';
import 'package:notez/view/widgets/tasks_container_widget.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 20,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                TasksContainerWidget(),
              ],
            ),
          ),
        );
  }
}