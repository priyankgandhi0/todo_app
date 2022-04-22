import 'dart:ui';

import 'package:get/get.dart';

class TodoItem {
  TodoItem(
      {required this.name,
      required this.time,
      required this.color,
      required this.image,
      this.timeToString});

  final String name;
  Duration time;
  final Color color;
  final String image;
  String? timeToString = "";
  RxBool isRunning = false.obs;
}
