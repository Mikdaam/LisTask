import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listask/app/core/utils/extensions.dart';
import 'package:listask/app/data/models/task.dart';
import 'package:listask/app/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final Task task;
  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    final squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 7,
            offset: const Offset(0, 7),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: Change this dynamically after implementing CRUD
          StepProgressIndicator(
            totalSteps: 100,
            currentStep: 80,
            size: 5,
            padding: 0,
            selectedGradientColor: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.5), color],
            ),
            unselectedGradientColor: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white54, Colors.white54],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0.wp),
            child: Icon(
              IconData(task.icon, fontFamily: "MaterialIcons"),
              color: color,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(6.0.wp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0.sp), overflow: TextOverflow.ellipsis,),
                SizedBox(height: 2.0.wp,),
                Text("${task.todos?.length ?? 0} Tasks", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
