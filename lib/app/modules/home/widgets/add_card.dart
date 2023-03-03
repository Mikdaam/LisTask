import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:listask/app/core/utils/extensions.dart';
import 'package:listask/app/core/values/colors.dart';
import 'package:listask/app/data/models/task.dart';
import 'package:listask/app/modules/home/controller.dart';
import 'package:listask/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  AddCard({Key? key}) : super(key: key);
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    final squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              title: "Task Type",
              content: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                      child: TextFormField(
                        controller: controller.editController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Title'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter the task title";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                      child: Wrap(
                        spacing: 2.0.wp,
                        children: icons
                            .map((e) => Obx(() {
                                  final currentId = icons.indexOf(e);
                                  return ChoiceChip(
                                    label: e,
                                    selected:
                                        controller.selectedChipIndex.value ==
                                            currentId,
                                    onSelected: (bool selected) {
                                      controller.changeChipIndex(
                                          selected ? currentId : 0);
                                    },
                                    selectedColor: Colors.grey[200],
                                    pressElevation: 0,
                                    backgroundColor: Colors.white,
                                  );
                                }))
                            .toList(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          var select = icons[controller.selectedChipIndex.value];
                          Get.back();
                          var success = controller.addTask(
                            Task(
                                title: controller.editController.text,
                                icon: select.icon!.codePoint,
                                color: select.color!.toHex(),
                            ),
                          );
                          success
                              ? EasyLoading.showSuccess("Task create successfully")
                              : EasyLoading.showError("Task already exist");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          minimumSize: const Size(150, 40)),
                      child: const Text("Confirm"),
                    )
                  ],
                ),
              ));
          controller.editController.clear();
          controller.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
