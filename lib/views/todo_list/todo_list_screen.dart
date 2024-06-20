import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:todolist_app/const/app_fonts.dart';

import '../../controller/todo_list_controller.dart';
import 'edit_todo_screen.dart';
import 'todo_add_screen.dart';

class TodoListScreen extends StatefulWidget {
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  int activeIndex = 0;
  
  var textEditingController = TextEditingController();
  var descriptionController = TextEditingController();

  bool ischeck = false;
 

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TodolistController>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text('ToDo - List',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))
                ],
              ),
              ksizedBox30,
              CarouselSlider(
                options: CarouselOptions(
                  initialPage: 0,
                  height: 105,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                ),
                items: [
                  Container(
                    height: 70,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.red.shade300,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 0),
                      child: Stack(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '2 Mins',
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'Tareas Pueds hance are 2 mins',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            )
                          ],
                        ),
                        Positioned(
                            top: 10,
                            right: 0,
                            child: Icon(
                              Icons.schedule_outlined,
                              size: 70,
                              color: Colors.white10,
                            ))
                      ]),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.red.shade300,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 0),
                      child: Stack(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pendientes',
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'Tareas realizar durante el dia',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            )
                          ],
                        ),
                        Positioned(
                            top: 10,
                            right: 0,
                            child: Icon(
                              Icons.calendar_month_outlined,
                              size: 70,
                              color: Colors.white10,
                            ))
                      ]),
                    ),
                  )
                ],
              ),
              ksizedBox30,
              Obx(() => 
              taskController.taskList.isNotEmpty?
              ListView.builder(
                    shrinkWrap: true,
                    itemCount: taskController.taskList.length,
                    itemBuilder: (context, index) {
                      //  final task = taskController.taskList[index];
                      return Slidable(
                          key: ValueKey(taskController.taskList[index].id),
                          startActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  Get.to(EditTodoScreen(
                                    todoTaskModel:
                                        taskController.taskList[index],
                                  ));
                                },
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  taskController.deleteTask(int.parse(
                                      taskController.taskList[index].id
                                          .toString()));
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white24,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [

                                          Obx(()=>
                                           Transform.scale(
                                          scale: 1.5,
                                         child: 
                                             Checkbox(
                             shape: CircleBorder(),
                                              value: taskController
                                                  .taskList[index]
                                                  .isCompleted,
                                              onChanged: (bool? value) {
                                                taskController.taskList[index]
                                                    .isCompleted = value!;
                                                // taskController.updateTask(
                                                //     taskController
                                                //         .taskList[index]);
                                              },
                                            ),
                                           )
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                taskController
                                                    .taskList[index].title,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.5),
                                              ),
                                              Text(
                                                taskController.taskList[index]
                                                    .description,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ksizedBox20,
                            ],
                          ));
                    },
                  ):Text('No datas')),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: TextField(
              //           controller: textEditingController,
              //           decoration: InputDecoration(
              //             labelText: 'Task',
              //           ),
              //         ),
              //       ),
              //       IconButton(
              //         icon: Icon(Icons.add),
              //         onPressed: () {
              //           if (textEditingController.text.isNotEmpty) {
              //             taskController.addTask(textEditingController.text,descriptionController.text);
              //             textEditingController.clear();
              //           }
              //         },
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Get.to(TodoAddScreen());
        },
        child: Container(
          height: 40,
          width: 40,
          decoration:
              BoxDecoration(color: Colors.red.shade300, shape: BoxShape.circle),
          child: InkWell(
            onTap: () {
              Get.to(TodoAddScreen());
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
// Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: textEditingController,
//                     decoration: InputDecoration(
//                       labelText: 'Task',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     if (textEditingController.text.isNotEmpty) {
//                       taskController.addTask(textEditingController.text);
//                       textEditingController.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               return ListView.builder(
//                 itemCount: taskController.taskList.length,
//                 itemBuilder: (context, index) {
//                   final task = taskController.taskList[index];
//                   return ListTile(
//                     title: Text(task.title),
//                     trailing: Checkbox(
//                       value: task.isCompleted,
//                       onChanged: (bool? value) {
//                         task.isCompleted = value!;
//                         taskController.updateTask(task);
//                       },
//                     ),
//                     onLongPress: () {
//                       taskController.deleteTask(task.id!);
//                     },
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),