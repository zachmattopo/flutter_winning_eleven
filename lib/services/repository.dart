import 'package:flutter_winning_eleven/models/api_response.dart';
import 'package:flutter_winning_eleven/services/api_client.dart';

class Repository {
  static final Repository _repository = Repository._internal();

  static Repository get() {
    return _repository;
  }

  Repository._internal();

  final ApiClient apiClient = ApiClient();

  Future<ApiResponse> fetchCompetition(String competitionCode) =>
      apiClient.fetchCompetition(competitionCode);

  Future<ApiResponse> fetchPastMonthFinishedMatches({
    required DateTime dateFrom,
    required DateTime dateTo,
  }) =>
      apiClient.fetchPastMonthFinishedMatches(dateFrom, dateTo);

  Future<ApiResponse> fetchTeam(int id) => apiClient.fetchTeam(id);
}
