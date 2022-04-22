import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/getx/todo_list_controller.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/widgets/task_row.dart';

class TodoList extends StatelessWidget {
  TodoList({Key? key}) : super(key: key);

  final TodoListController _todoListController = Get.put(TodoListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TODO List")),
      body: GetBuilder<TodoListController>(
          id: _todoListController.updateList,
          builder: (controller) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return TaskRow(
                    todoItem: _todoListController.todoList[index],
                    onStartStop: () {
                      if (!_todoListController
                          .checkCurrentTimerRunning(index)) {
                        _todoListController.startTimer(index);
                      }
                    });
              },
              itemCount: _todoListController.todoList.length,
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _todoListController.displayDialog(context),
          tooltip: "Add task",
          child: const Icon(Icons.add)),
    );
  }
}
