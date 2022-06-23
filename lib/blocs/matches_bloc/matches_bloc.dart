import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_winning_eleven/blocs/team_bloc/team_bloc.dart';
import 'package:flutter_winning_eleven/models/api_response.dart';
import 'package:flutter_winning_eleven/models/match.dart';
import 'package:flutter_winning_eleven/models/team.dart';
import 'package:flutter_winning_eleven/services/repository.dart';
import 'package:flutter_winning_eleven/utils/match_utils.dart';

part 'matches_event.dart';
part 'matches_state.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  final Repository repository;
  final TeamBloc teamBloc;

  MatchesBloc({
    required this.repository,
    required this.teamBloc,
  }) : super(MatchesInitial()) {
    on<MatchesEvent>((event, emit) async {
      if (event is MatchesFetched) {
        emit(const MatchesFetchInProgress());

        final ApiResponse apiResponse =
            await repository.fetchPastMonthFinishedMatches(
          dateFrom: event.dateFrom,
          dateTo: event.dateTo,
        );

        if (apiResponse.success) {
          final List matchesJsonArray = apiResponse.data as List? ?? [];

          final List<Match> matches =
              // ignore: unnecessary_lambdas
              matchesJsonArray.map((e) => Match.fromJson(e)).toList();

          // Get best team from the matches
          final Map<Team, int> map = MatchUtils.getTeamWinMap(matches);
          final Team? team = MatchUtils.getBestTeam(map);

          if (team != null && team.id != null) {
            emit(MatchesFetchSuccess(matches: matches));

            // Acquired the best team last 30 days, get full detail of said team
            teamBloc.add(TeamFetched(id: team.id!));
          } else {
            // Failed to get best team last 30 days
            emit(
              const MatchesFetchFailure(
                errorMessage:
                    'Oops! Unable to determine the best team last 30 days. Please try again later.',
              ),
            );
          }
        } else {
          // Failed API call
          emit(
            MatchesFetchFailure(
              errorMessage: apiResponse.errorData['message'],
            ),
          );
        }
      }
    });
  }
}
