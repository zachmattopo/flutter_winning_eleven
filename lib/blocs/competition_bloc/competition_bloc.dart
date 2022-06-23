import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_winning_eleven/blocs/matches_bloc/matches_bloc.dart';
import 'package:flutter_winning_eleven/models/api_response.dart';
import 'package:flutter_winning_eleven/models/competition.dart';
import 'package:flutter_winning_eleven/services/repository.dart';
import 'package:flutter_winning_eleven/utils/app_config.dart';
import 'package:flutter_winning_eleven/utils/competition_utils.dart';

part 'competition_event.dart';
part 'competition_state.dart';

class CompetitionBloc extends Bloc<CompetitionEvent, CompetitionState> {
  final Repository repository;
  final MatchesBloc matchesBloc;

  CompetitionBloc({
    required this.repository,
    required this.matchesBloc,
  }) : super(CompetitionInitial()) {
    on<CompetitionEvent>((event, emit) async {
      if (event is CompetitionFetched) {
        emit(const CompetitionFetchInProgress());

        final ApiResponse apiResponse =
            await repository.fetchCompetition(AppConfig.competitionCode);

        if (apiResponse.success) {
          final Competition competition =
              Competition.fromRawJson(apiResponse.data);

          // Use the `seasons` array in `competition` to get date range of matches
          final DateTime? dateTo =
              CompetitionUtils.getMatchesDateTo(competition);

          if (dateTo != null) {
            emit(CompetitionFetchSuccess(competition: competition));

            final DateTime dateFrom =
                CompetitionUtils.getMatchesDateFrom(dateTo);

            // Both start & end dates acquired, get matches within the date range
            matchesBloc.add(
              MatchesFetched(
                dateTo: dateTo,
                dateFrom: dateFrom,
              ),
            );
          } else {
            // Failed to determine the end date for match count
            emit(
              const CompetitionFetchFailure(
                errorMessage:
                    'Oops! Error in getting the date range of matches. Please try again later.',
              ),
            );
          }
        } else {
          // Failed API call
          emit(
            CompetitionFetchFailure(
              errorMessage: apiResponse.errorData['message'],
            ),
          );
        }
      }
    });
  }
}
