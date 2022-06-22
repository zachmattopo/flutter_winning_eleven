import 'package:dio/dio.dart';

class ApiResponse<T> {
  ApiResponse({
    required this.success,
    this.data,
    this.error,
    this.stackTrace,
  }) {
    if (error != null) {
      setErrorData();
    }
  }

  bool success;
  T? data;
  DioError? error;
  StackTrace? stackTrace;
  Map errorData = {};

  Map setErrorData() {
    if (error?.response != null) {
      int? statusCode;

      if (error?.response?.statusCode != null) {
        statusCode = error?.response?.statusCode;
      }

      if (error?.response?.data != null) {
        if (error?.response?.data['message'] != null) {
          // Errors handled by server
          errorData['message'] = error?.response?.data['message'];
        } else if (error?.response?.data['error'] != null) {
          // Errors handled by Dio
          errorData['message'] = error?.response?.data['error'];
        } else {
          errorData['message'] =
              '[$statusCode error] Oops! Something went wrong. Please try again later.';
        }
      } else {
        errorData['message'] =
            '[$statusCode error] Oops! Something went wrong. Please try again later.';
      }
    } else {
      errorData['message'] =
          'Oops! Something went wrong. Please try again later.';
    }

    return errorData;
  }

  @override
  String toString() =>
      'ApiResponse {\n\tsuccess: $success, \n\tdata: $data, \n\terror: ${errorData['message']}\n\t}';
}
