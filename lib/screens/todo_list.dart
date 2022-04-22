import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/getx/todo_list_controller.dart';
import 'package:todo_app/models/todo_item.dart';

class TodoList extends StatelessWidget {
  TodoList({Key? key}) : super(key: key);

  final TextEditingController _textFieldController = TextEditingController();
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
                return _buildTodoItem(
                    index, _todoListController.todoList[index]);
              },
              itemCount: _todoListController.todoList.length,
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: "Add task",
          child: const Icon(Icons.add)),
    );
  }

  void _addTodoItem(String title) {
    _todoListController.addTask(title);
    _textFieldController.clear();
  }

  Widget _buildTodoItem(int index, TodoItem todoItem) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todoItem.name,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
            maxLines: 6,
          ).paddingAll(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<TodoListController>(
                builder: (controller) {
                  return Text(
                    _todoListController.todoList[index].timeToString == null
                        ? _todoListController
                            .getMinutesWithSeconds(todoItem.time)
                        : _todoListController.todoList[index].timeToString!,
                    style: const TextStyle(fontSize: 16),
                  );
                },
                id: _todoListController.updateTime,
              ),
              ElevatedButton(
                onPressed: () {
                  if (!_todoListController.checkCurrentTimerRunning(index)) {
                    _todoListController.startTimer(index);
                  }
                },
                child: Obx(() {
                  return todoItem.isRunning.value
                      ? const Text("Stop")
                      : const Text("Start");
                }),
              ),
            ],
          ).paddingAll(5)
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber.shade100, width: 4),
        borderRadius: BorderRadius.circular(8),
      ),
    ).paddingOnly(top: 10, left: 5, right: 5);
  }

  Future<AlertDialog?> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add a task"),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "Enter task name"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
