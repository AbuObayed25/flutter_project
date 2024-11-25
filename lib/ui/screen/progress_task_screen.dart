import 'package:flutter/material.dart';
import 'package:practice_2/data/models/network_response.dart';
import 'package:practice_2/data/models/task_list_model.dart';
import 'package:practice_2/data/models/task_model.dart';
import 'package:practice_2/data/services/network_caller.dart';
import 'package:practice_2/data/utils/urls.dart';
import 'package:practice_2/ui/widgets/snack_bar_message.dart';

import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskListInProgress = false;
  List<TaskModel> _progressTaskList = [];
  @override
  void initState() {
    super.initState();
    _getProgressTaskList();

  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getProgressTaskListInProgress,
      replacement: const CircularProgressIndicator(),
      child: RefreshIndicator(
        onRefresh: ()async{
          _getProgressTaskList();
        },
        child: ListView.separated(
          itemCount: _progressTaskList.length,
          itemBuilder: (context, index) {
            return task_card(
              taskModel: _progressTaskList[index], onRefreshList: () {  },
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
        ),
      ),
    );
  }
  Future<void> _getProgressTaskList() async {
    _progressTaskList.clear();
    _getProgressTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.progressTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responeseData);
      _progressTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getProgressTaskListInProgress = false;
    setState(() {});
  }
}
