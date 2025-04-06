import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/view/widget_tree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize hive;
  await Hive.initFlutter();

  // open the box
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: WidgetTree(),
    );
  }
}
