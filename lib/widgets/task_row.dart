import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/getx/todo_list_controller.dart';
import 'package:todo_app/models/todo_item.dart';

class TaskRow extends StatelessWidget {
  final TodoItem todoItem;
  final Function() onStartStop;

  const TaskRow({Key? key, required this.todoItem, required this.onStartStop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoListController todoListController = Get.find();
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
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  GetBuilder<TodoListController>(
                    builder: (controller) {
                      return Text(
                        todoItem.timeToString == null
                            ? todoListController
                                .getMinutesWithSeconds(todoItem.time)
                            : todoItem.timeToString!,
                        style: const TextStyle(fontSize: 16),
                      );
                    },
                    id: todoListController.updateTime,
                  ),
                  const SizedBox(width: 5),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: todoItem.color,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  onStartStop();
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
        image: DecorationImage(
          image: AssetImage(todoItem.image),
          fit: BoxFit.fill,
        ),
      ),
    ).paddingOnly(top: 10, left: 5, right: 5);
  }
}
