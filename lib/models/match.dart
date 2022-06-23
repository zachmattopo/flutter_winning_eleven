import 'package:equatable/equatable.dart';
import 'package:flutter_winning_eleven/models/season.dart';
import 'package:flutter_winning_eleven/models/team.dart';
import 'package:flutter_winning_eleven/utils/match_utils.dart';

enum MatchWinner {
  homeTeam,
  awayTeam,
  draw,
}

class Match extends Equatable {
  const Match({
    this.season,
    this.id,
    this.utcDate,
    this.status,
    this.matchday,
    this.homeTeam,
    this.awayTeam,
    this.matchWinner,
  });

  final Season? season;
  final int? id;
  final DateTime? utcDate;
  final String? status;
  final int? matchday;
  final Team? homeTeam;
  final Team? awayTeam;
  final MatchWinner? matchWinner;

  factory Match.fromJson(Map<String, dynamic> json) => Match(
        season: Season.fromJson(json['season']),
        id: json['id'],
        utcDate: DateTime.parse(json['utcDate']),
        status: json['status'],
        matchday: json['matchday'],
        homeTeam: Team.fromJson(json['homeTeam']),
        awayTeam: Team.fromJson(json['awayTeam']),
        matchWinner: MatchUtils.parseMatchWinner(json['score']['winner']),
      );

  @override
  List<Object?> get props => [
        season,
        id,
        utcDate,
        status,
        matchday,
        homeTeam,
        awayTeam,
        matchWinner,
      ];
}
