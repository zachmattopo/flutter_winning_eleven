part of 'team_bloc.dart';

abstract class TeamState extends Equatable {
  const TeamState();

  @override
  List<Object> get props => [];
}

class TeamInitial extends TeamState {}

class TeamFetchInProgress extends TeamState {
  const TeamFetchInProgress();

  @override
  String toString() => 'TeamFetchInProgress';
}

class TeamFetchSuccess extends TeamState {
  const TeamFetchSuccess({required this.team});

  final Team team;

  @override
  List<Object> get props => [team];

  @override
  String toString() => 'TeamFetchSuccess { team: $team }';
}

class TeamFetchFailure extends TeamState {
  const TeamFetchFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'TeamFetchFailure { errorMessage: $errorMessage }';
}
