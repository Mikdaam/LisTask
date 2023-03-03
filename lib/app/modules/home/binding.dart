import 'package:get/get.dart';
import 'package:listask/app/data/providers/task/provider.dart';
import 'package:listask/app/data/services/storage/repository.dart';
import 'package:listask/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
