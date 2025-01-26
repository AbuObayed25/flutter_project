import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_2/data/models/network_response.dart';
import 'package:practice_2/data/models/task_status_count_model.dart';
import 'package:practice_2/data/models/task_status_model.dart';
import 'package:practice_2/data/services/network_caller.dart';
import 'package:practice_2/data/utils/urls.dart';
import 'package:practice_2/ui/controllers/new_task_list_controller.dart';
import 'package:practice_2/ui/screen/add_new_task_screen.dart';
import 'package:practice_2/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:practice_2/ui/widgets/snack_bar_message.dart';
import '../utility/app_Colors.dart';
import '../widgets/task_card.dart';
import '../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});
  static const String name='/newtask';

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getTaskStatusCountListInProgress = false;

  List<TaskStatusModel> _taskStatusCountList = [];
  final NewTaskListController _newTaskListController =
      Get.find<NewTaskListController>();

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getNewTaskList();
          _getTaskStatusCount();
        },
        child: Column(
          children: [
            _buildSummarySection(),
            Expanded(
              child: GetBuilder<NewTaskListController>(builder: (controller) {
                return Visibility(
                  visible: !controller.inProgress,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: ListView.separated(
                    itemCount: controller.taskList.length,
                    itemBuilder: (context, index) {
                      return task_card(
                        taskModel: controller.taskList[index],
                        onRefreshList: _getNewTaskList,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        onPressed: _onTapAddFAB,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Future<void> _onTapAddFAB() async {
    final bool? shouldRefresh = await Navigator.pushNamed(context, AddNewTaskScreen.name);
    if (shouldRefresh == true) {
      _getNewTaskList();
    }
  }

  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: _getTaskStatusCountListInProgress == false,
        replacement: const CenteredCircularProgressIndicator(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _getTaskSummaryCardList(),
          ),
        ),
      ),
    );
  }

  List<TaskSummaryCard> _getTaskSummaryCardList() {
    List<TaskSummaryCard> taskSummaryCardList = [];
    for (TaskStatusModel t in _taskStatusCountList) {
      taskSummaryCardList
          .add(TaskSummaryCard(title: t.sId!, count: t.sum ?? 0));
    }

    return taskSummaryCardList;
  }

  Future<void> _getNewTaskList() async {
    final bool result = await _newTaskListController.getNewTaskList();
    if (result == false) {
      showSnackBarMessage(context, _newTaskListController.errorMessage!, true);
    }
  }

  Future<void> _getTaskStatusCount() async {
    _taskStatusCountList.clear();
    _getTaskStatusCountListInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskStatusCount);
    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel =
          TaskStatusCountModel.fromJson(response.responeseData);
      _taskStatusCountList = taskStatusCountModel.taskStatusCountList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getTaskStatusCountListInProgress = false;
    setState(() {});
  }
}
