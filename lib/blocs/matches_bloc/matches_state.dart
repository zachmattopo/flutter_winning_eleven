part of 'matches_bloc.dart';

abstract class MatchesState extends Equatable {
  const MatchesState();

  @override
  List<Object> get props => [];
}

class MatchesInitial extends MatchesState {}

class MatchesFetchInProgress extends MatchesState {
  const MatchesFetchInProgress();

  @override
  String toString() => 'MatchesFetchInProgress';
}

class MatchesFetchSuccess extends MatchesState {
  const MatchesFetchSuccess({required this.matches});

  final List<Match> matches;

  @override
  List<Object> get props => [matches];

  @override
  String toString() => 'MatchesFetchSuccess { matches: $matches }';
}

class MatchesFetchFailure extends MatchesState {
  const MatchesFetchFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'MatchesFetchFailure { errorMessage: $errorMessage }';
}
