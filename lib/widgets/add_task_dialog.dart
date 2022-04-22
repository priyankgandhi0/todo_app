import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:todo_app/getx/todo_list_controller.dart';

class AddTaskDialog extends StatelessWidget {
  final TextEditingController textFieldController;
  final Function(Color color) onChange;
  final Function(Color color) onSelect;
  final Color? pickerColor;

  const AddTaskDialog(
      {Key? key,
      required this.textFieldController,
      required this.onChange,
      required this.onSelect,
      this.pickerColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoListController todoListController = Get.find();
    return Wrap(
      children: [
        TextField(
          controller: textFieldController,
          decoration: const InputDecoration(hintText: "Enter task name"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Color"),
            InkWell(
              onTap: () async {
                return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Pick a color"),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: pickerColor!,
                          onColorChanged: (color) {
                            onChange(color);
                          },
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text("Okay"),
                          onPressed: () {
                            onSelect(pickerColor!);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: GetBuilder<TodoListController>(
                id: todoListController.updateColor,
                builder: (controller) {
                  return Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: todoListController.selectedColor,
                    ),
                  );
                },
              ),
            )
          ],
        ).paddingOnly(top: 10)
      ],
    );
  }
}
