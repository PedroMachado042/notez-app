import 'package:flutter/material.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
ValueNotifier<int> notesLenght = ValueNotifier(0);
ValueNotifier<int> tasksLenght = ValueNotifier(0);
ValueNotifier<bool> isLogged = ValueNotifier(false);
ValueNotifier<bool> hasSound = ValueNotifier(false);
ValueNotifier<int> uiTrigger = ValueNotifier<int>(1);