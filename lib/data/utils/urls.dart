class Urls {
  static const String _baseurl = 'http://35.73.30.144:2005/api/v1';

  static const String registration = '$_baseurl/Registration';
  static const String login = '$_baseurl/login';
  static const String addNewTask = '$_baseurl/CreateTask';
  static const String newTaskList = '$_baseurl/listTaskByStatus/New';
  static const String completedTaskList =
      '$_baseurl/listTaskByStatus/Completed';
  static const String cancelledTaskList =
      '$_baseurl/listTaskByStatus/Cancelled';
  static const String progressTaskList = '$_baseurl/listTaskByStatus/Progress';
  static const String taskStatusCount = '$_baseurl/taskStatusCount';
  static const String updateProfile = '$_baseurl/profileUpdate';
  static const String profileDetails = '$_baseurl/ProfileDetails';

  static String changeStatus(String taskId, String status) =>
      '$_baseurl/updateTaskStatus/$taskId/$status';

  static String deleteTask(String taskId) => '$_baseurl/deleteTask/$taskId';
}
