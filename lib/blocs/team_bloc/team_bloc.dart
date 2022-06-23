import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_winning_eleven/models/api_response.dart';
import 'package:flutter_winning_eleven/models/team.dart';
import 'package:flutter_winning_eleven/services/repository.dart';

part 'team_event.dart';
part 'team_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  final Repository repository;

  TeamBloc({required this.repository}) : super(TeamInitial()) {
    on<TeamEvent>((event, emit) async {
      if (event is TeamFetched) {
        emit(const TeamFetchInProgress());

        final ApiResponse apiResponse = await repository.fetchTeam(event.id);

        if (apiResponse.success) {
          final Team team = Team.fromRawJson(apiResponse.data);

          emit(TeamFetchSuccess(team: team));
        } else {
          // Failed API call
          emit(
            TeamFetchFailure(
              errorMessage: apiResponse.errorData['message'],
            ),
          );
        }
      }
    });
  }
}
