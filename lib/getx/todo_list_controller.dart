import 'dart:async';

import 'package:get/get.dart';
import 'package:todo_app/models/todo_item.dart';

class TodoListController extends GetxController {
  List<TodoItem> todoList = [];
  final String updateList = "updateList";
  final String updateTime = "updateTime";
  int selectedTask = -1;
  Timer? timer;
  List<String> imageAssets = ["assets/1.png", "assets/2.png", "assets/3.png"];

  void addTask(String title) {
    TodoItem todoItem = TodoItem(name: title, time: Duration.zero);
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
      stopTimer(index);
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
}
