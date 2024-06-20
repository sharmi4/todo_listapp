// lib/screens/edit_todo_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_app/controller/todo_list_controller.dart';

import 'package:todolist_app/model/todo_list_model.dart';

class EditTodoScreen extends StatelessWidget {
  final TodoTaskModel todoTaskModel;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  EditTodoScreen({required this.todoTaskModel}) {
    _titleController.text = todoTaskModel.title;
    _descriptionController.text = todoTaskModel.description;
  }

  @override
  Widget build(BuildContext context) {
    final todoTaskController = Get.find<TodolistController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit To-Do'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  // Update todo
                  todoTaskModel.title = _titleController.text;
                  todoTaskModel.description = _descriptionController.text;
                  todoTaskController.updateTask(todoTaskModel);
                
                 ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
              
                      backgroundColor: Colors.green[100],
                      content: Text('Todo-List updated successfully',
                      style: TextStyle(
                        color: Colors.black
                      ),),
                      duration: Duration(seconds: 2),
                    ),
                  );
                   
                  Get.back(); 
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
