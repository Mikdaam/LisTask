import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:listask/app/data/models/task.dart';
import 'package:listask/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final tasks = <Task>[].obs;
  final formKey = GlobalKey<FormState>();
  final selectedChipIndex = 0.obs;
  final deleting = false.obs;
  final editController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  void changeChipIndex(int value) {
    selectedChipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  bool addTask(Task task) {
    if(tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }
}