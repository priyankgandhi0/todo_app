import 'package:get/get.dart';

class TodoItem {
  TodoItem({required this.name, required this.time, this.timeToString});

  final String name;
  Duration time;
  String? timeToString = "";
  RxBool isRunning = false.obs;

  factory TodoItem.fromJson(Map<String, dynamic> json) => TodoItem(
        name: json["name"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "time": time,
      };
}
