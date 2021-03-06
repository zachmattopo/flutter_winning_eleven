import 'package:dio/dio.dart';
import 'package:flutter_winning_eleven/models/api_response.dart';
import 'package:flutter_winning_eleven/utils/app_config.dart';
import 'package:flutter_winning_eleven/utils/app_utils.dart';

class ApiClient {
  Dio apiClient = Dio();

  ApiClient() {
    // Set Dio configs
    final BaseOptions options = BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );

    apiClient = Dio(options);

    apiClient.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add token to http header before request is sent
        return handler.next(requestInterceptor(options)); // Continue
      },
    ));
  }

  RequestOptions requestInterceptor(RequestOptions options) {
    options.headers.addAll({'X-Auth-Token': AppConfig.authToken});

    return options;
  }

  Future<ApiResponse> fetchCompetition(String competitionCode) async {
    final String url = '/v4/competitions/$competitionCode';

    try {
      final Response response = await apiClient.get(url);

      return ApiResponse(
        success: true,
        data: response.data,
      );
    } on DioError catch (error) {
      return ApiResponse(
        success: false,
        error: error,
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<ApiResponse> fetchPastMonthFinishedMatches(
    DateTime dateFrom,
    DateTime dateTo,
  ) async {
    final String url = '/v4/competitions/${AppConfig.competitionCode}/matches';

    try {
      final Response response = await apiClient.get(
        url,
        queryParameters: {
          'status': 'FINISHED',
          'dateFrom': AppUtils.formatYYYYMMDD(dateFrom),
          'dateTo': AppUtils.formatYYYYMMDD(dateTo),
        },
      );

      return ApiResponse(
        success: true,
        data: response.data['matches'],
      );
    } on DioError catch (error) {
      return ApiResponse(
        success: false,
        error: error,
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<ApiResponse> fetchTeam(int id) async {
    final String url = '/v4/teams/$id';

    try {
      final Response response = await apiClient.get(url);

      return ApiResponse(
        success: true,
        data: response.data,
      );
    } on DioError catch (error) {
      return ApiResponse(
        success: false,
        error: error,
        stackTrace: StackTrace.current,
      );
    }
  }
}
