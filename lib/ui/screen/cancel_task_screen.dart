import 'package:flutter/material.dart';
import 'package:practice_2/data/models/network_response.dart';
import 'package:practice_2/data/models/task_list_model.dart';
import 'package:practice_2/data/models/task_model.dart';
import 'package:practice_2/data/services/network_caller.dart';
import 'package:practice_2/data/utils/urls.dart';
import 'package:practice_2/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:practice_2/ui/widgets/snack_bar_message.dart';

import '../widgets/task_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  bool _getCancelledTaskListInProgress = false;
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCancelledTaskListInProgress,
      replacement: const CenteredCircularProgressIndicator(),
      child: RefreshIndicator(
        onRefresh: () async {
          _getCancelledTaskList();
        },
        child: ListView.separated(
          itemCount: _cancelledTaskList.length,
          itemBuilder: (context, index) {
            return task_card(
              taskModel: _cancelledTaskList[index],
              onRefreshList: _getCancelledTaskList,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
        ),
      ),
    );
  }

  Future<void> _getCancelledTaskList() async {
    _cancelledTaskList.clear();
    _getCancelledTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.cancelledTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responeseData);
      _cancelledTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getCancelledTaskListInProgress = false;
    setState(() {});
  }
}
