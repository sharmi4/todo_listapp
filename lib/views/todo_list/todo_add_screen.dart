// lib/screens/add_todo_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_app/const/app_fonts.dart';
import 'package:todolist_app/model/todo_list_model.dart';

import '../../controller/todo_list_controller.dart';


class TodoAddScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  var todoController = Get.find<TodolistController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text('Add To-Do',
        style:TextStyle(
          color: Colors.white
        )),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 13,right: 13),
          child: Column(
            
            children: [
              ksizedBox40,
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  )),
                  ksizedBox20,
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                        style: TextStyle(color: Colors.white),

                      controller: _titleController,
                      decoration: InputDecoration(
                        
                        labelText: 'Enter your title',
                        hintStyle: TextStyle(
                        color: Colors.white
                        ),
                        
                        border: OutlineInputBorder(
                          
                          borderRadius: BorderRadius.circular(10)
                        )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              ksizedBox40,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white
                  ),),
                  ksizedBox20,
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                         style: TextStyle(color: Colors.white),
                      maxLines: 10,
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: ' Enter your description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                      )),
                      
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              ksizedBox40,
              ksizedBox20,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(85, 40)
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    TodoTaskModel newTodo = TodoTaskModel(
                      id: DateTime.now().millisecondsSinceEpoch,
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );
                    todoController.addTodo(newTodo);
                    Get.back();
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
