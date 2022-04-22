import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/widgets/add_task_dialog.dart';

class TodoListController extends GetxController {
  final TextEditingController _textFieldController = TextEditingController();
  List<TodoItem> todoList = [];
  final String updateList = "updateList";
  final String updateTime = "updateTime";
  final String updateColor = "updateColor";
  int selectedTask = -1;
  Timer? timer;
  List<String> imageAssets = ["assets/1.png", "assets/2.png", "assets/3.png"];
  Color selectedColor = const Color(0XFFFF0000);
  Color pickerColor = const Color(0XFFFF0000);

  void _addTask() {
    TodoItem todoItem = TodoItem(
        name: _textFieldController.text,
        time: Duration.zero,
        color: selectedColor,
        image: imageAssets[Random().nextInt(3)]);
    todoList.add(todoItem);
    update([updateList]);
  }

  String getMinutesWithSeconds(Duration duration) {
    return "${(Duration(seconds: duration.inSeconds))}"
        .split('.')[0]
        .padLeft(8, '0');
  }

  bool checkCurrentTimerRunning(int index) {
    if (selectedTask != -1) {
      stopTimer(selectedTask);
      if (selectedTask != index) {
        startTimer(index);
      } else {
        selectedTask = -1;
      }
      return true;
    } else {
      return false;
    }
  }

  void startTimer(int position) {
    selectedTask = position;
    TodoItem todoItem = todoList[position];
    int seconds = todoItem.time.inSeconds;
    timer = Timer(const Duration(seconds: 1), () {
      seconds++;
      todoItem.time = Duration(seconds: seconds);
      todoItem.timeToString = getMinutesWithSeconds(todoItem.time);
      todoItem.isRunning.value = true;
      startTimer(position);
      update([updateTime]);
    });
  }

  void stopTimer(int position) {
    timer?.cancel();
    todoList[position].isRunning.value = false;
  }

  Future<AlertDialog?> displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add a task"),
            content: AddTaskDialog(
              textFieldController: _textFieldController,
              onChange: (color) {
                pickerColor = color;
              },
              onSelect: (color) {
                selectedColor = pickerColor;
                Navigator.of(context).pop();
                update([updateColor]);
              },
              pickerColor: pickerColor,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Add"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTask();
                  _textFieldController.clear();
                },
              ),
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
