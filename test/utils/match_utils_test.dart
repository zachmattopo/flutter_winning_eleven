import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_winning_eleven/models/match.dart';
import 'package:flutter_winning_eleven/models/team.dart';
import 'package:flutter_winning_eleven/utils/match_utils.dart';

void main() {
  test('Map<Team, int> of team wins has no duplicate key (aka team) entries',
      () async {
    final File file = File('test_resources/mock_matches_json.json');
    final json = jsonDecode(await file.readAsString());

    final List matchesJsonArray = json as List? ?? [];

    final List<Match> matches =
        // ignore: unnecessary_lambdas
        matchesJsonArray.map((e) => Match.fromJson(e)).toList();

    // Get Map of team wins from the matches
    final Map<Team, int> teamWinMap = MatchUtils.getTeamWinMap(matches);

    final teamList = teamWinMap.keys;
    final distinctTeamList = teamList.toSet().toList();

    expect(teamList.length == distinctTeamList.length, true);
  });
}
