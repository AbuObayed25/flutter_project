import 'package:get/get.dart';
import 'package:practice_2/ui/controllers/new_task_list_controller.dart';
import 'package:practice_2/ui/controllers/sign_in_controller.dart';
import 'package:practice_2/ui/screen/new_task_screen.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(
      SignInController(),
    );
    Get.put(
      NewTaskListController(),
    );
  }
}
