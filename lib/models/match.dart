import 'dart:convert';

import 'package:flutter_winning_eleven/models/season.dart';
import 'package:flutter_winning_eleven/models/team.dart';
import 'package:flutter_winning_eleven/utils/match_utils.dart';

enum MatchWinner {
  homeTeam,
  awayTeam,
  draw,
}

class Match {
  Match({
    this.season,
    this.id,
    this.utcDate,
    this.status,
    this.matchday,
    this.homeTeam,
    this.awayTeam,
    this.matchWinner,
  });

  Season? season;
  int? id;
  DateTime? utcDate;
  String? status;
  int? matchday;
  Team? homeTeam;
  Team? awayTeam;
  MatchWinner? matchWinner;

  factory Match.fromRawJson(String str) => Match.fromJson(json.decode(str));

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
}
