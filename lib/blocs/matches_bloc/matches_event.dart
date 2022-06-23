part of 'matches_bloc.dart';

abstract class MatchesEvent extends Equatable {
  const MatchesEvent();

  @override
  List<Object> get props => [];
}

class MatchesFetched extends MatchesEvent {
  const MatchesFetched({
    required this.dateTo,
    required this.dateFrom,
  });

  final DateTime dateTo;
  final DateTime dateFrom;

  @override
  List<Object> get props => [
        dateTo,
        dateFrom,
      ];

  @override
  String toString() =>
      'MatchesFetched { dateTo: $dateTo, dateFrom: $dateFrom }';
}
