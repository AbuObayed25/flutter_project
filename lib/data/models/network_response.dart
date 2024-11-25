class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  dynamic responeseData;
  String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responeseData,
    this.errorMessage = 'Something went wrong',
  });
}
