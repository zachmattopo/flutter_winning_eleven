part of 'competition_bloc.dart';

abstract class CompetitionState extends Equatable {
  const CompetitionState();

  @override
  List<Object> get props => [];
}

class CompetitionInitial extends CompetitionState {}

class CompetitionFetchInProgress extends CompetitionState {
  const CompetitionFetchInProgress();

  @override
  String toString() => 'CompetitionFetchInProgress';
}

class CompetitionFetchSuccess extends CompetitionState {
  const CompetitionFetchSuccess({required this.competition});

  final Competition competition;

  @override
  List<Object> get props => [competition];

  @override
  String toString() => 'CompetitionFetchSuccess { competition: $competition }';
}

class CompetitionFetchFailure extends CompetitionState {
  const CompetitionFetchFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() =>
      'CompetitionFetchFailure { errorMessage: $errorMessage }';
}
