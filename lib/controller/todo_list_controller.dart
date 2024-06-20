import 'package:get/get.dart';
import 'package:todolist_app/model/todo_list_model.dart';
import 'package:todolist_app/sqflite_database/sqflite_database.dart';

class TodolistController extends GetxController {
  var taskList = <TodoTaskModel>[].obs;
  
  DataBaseHelper dbHelper = DataBaseHelper();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadTasks();
  }
  void addTodo(TodoTaskModel todo) {
    taskList.add(todo);
  }

  void loadTasks() async {
    List<TodoTaskModel> todolistmodel = await dbHelper.queryAllTasks();
    taskList.assignAll(todolistmodel);
  }

  void addTask(String title,String description) async {
    await dbHelper.insertTask(TodoTaskModel(title: title,description:description));
    loadTasks();
  }

  void updateTask(TodoTaskModel todoTaskModel) async {
    await dbHelper.updateTask(todoTaskModel);
    loadTasks();
  }

  void deleteTask(int id) async {
  await dbHelper.deleteTask(id);
  loadTasks();
}

}
