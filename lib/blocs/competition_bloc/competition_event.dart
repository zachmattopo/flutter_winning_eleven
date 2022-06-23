part of 'competition_bloc.dart';

abstract class CompetitionEvent extends Equatable {
  const CompetitionEvent();

  @override
  List<Object> get props => [];
}

class CompetitionFetched extends CompetitionEvent {
  const CompetitionFetched();

  @override
  String toString() => 'CompetitionFetched';
}
