import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:listask/app/core/utils/extensions.dart';
import 'package:listask/app/data/models/task.dart';
import 'package:listask/app/modules/home/controller.dart';
import 'package:listask/app/modules/home/widgets/add_card.dart';
import 'package:listask/app/modules/home/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                "My List",
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  ...controller.tasks
                      .map(
                        (task) => LongPressDraggable(
                          data: task,
                          feedback: Opacity(
                            opacity: 0.65,
                            child: TaskCard(
                              task: task,
                            ),
                          ),
                          child: TaskCard(task: task),
                          onDragStarted: () => controller.changeDeleting(true),
                          onDraggableCanceled: (_, __) =>
                              controller.changeDeleting(false),
                          onDragEnd: (_) => controller.changeDeleting(false),
                        ),
                      )
                      .toList(),
                  AddCard()
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: DragTarget(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              onPressed: () {},
              backgroundColor:
                  controller.deleting.value ? Colors.red : Colors.blue,
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess("Successfully delete");
        },
      ),
    );
  }
}
