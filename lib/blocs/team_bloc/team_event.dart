part of 'team_bloc.dart';

abstract class TeamEvent extends Equatable {
  const TeamEvent();

  @override
  List<Object> get props => [];
}

class TeamFetched extends TeamEvent {
  const TeamFetched({required this.id});

  final int id;

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'TeamFetched { id: $id }';
}
