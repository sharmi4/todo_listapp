import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_app/controller/todo_list_controller.dart';

import 'views/splash/splash_screen.dart';
import 'views/todo_list/todo_list_screen.dart';

void main() {
  runApp(MyApp());
  Get.put(TodolistController());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter To-Do List',
       home: SplashScreen(),
    );
  }
}

