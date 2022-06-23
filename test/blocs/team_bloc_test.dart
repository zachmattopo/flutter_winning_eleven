import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_winning_eleven/blocs/team_bloc/team_bloc.dart';
import 'package:flutter_winning_eleven/models/api_response.dart';
import 'package:flutter_winning_eleven/models/team.dart';
import 'package:flutter_winning_eleven/services/repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'team_bloc_test.mocks.dart';

@GenerateMocks([Repository])
void main() {
  late TeamBloc teamBloc;
  late MockRepository mockRepository;

  final mockTeamJson = {
    'id': 454,
    'name': 'Venezia FC',
    'shortName': 'Venezia FC',
    'tla': 'VEN',
    'crest': 'https://crests.football-data.org/454.png'
  };
  final ApiResponse mockApiResponse = ApiResponse(
    success: true,
    data: mockTeamJson,
  );
  final Team mockTeam = Team.fromJson(mockApiResponse.data);

  setUp(() {
    mockRepository = MockRepository();

    teamBloc = TeamBloc(repository: mockRepository);
  });

  tearDown(() {
    teamBloc.close();
  });

  test('Initial bloc state is correct', () {
    expect(
      teamBloc.state,
      TeamInitial(),
    );
  });

  test('Close does not emit new states over the state stream', () async {
    final expectedStates = [emitsDone];

    unawaited(
      expectLater(
        teamBloc.stream,
        emitsInOrder(expectedStates),
      ),
    );

    await teamBloc.close();
  });

  group('TeamFetched event', () {
    blocTest<TeamBloc, TeamState>(
      'emits [TeamFetchInProgress, TeamFetchSuccess] on success',
      build: () {
        when(mockRepository.fetchTeam(454))
            .thenAnswer((_) async => mockApiResponse);
        return teamBloc;
      },
      // Add delay due to Bloc transforms events concurrently by default
      wait: const Duration(seconds: 2),
      act: (bloc) => bloc.add(const TeamFetched(id: 454)),
      expect: () => <TeamState>[
        const TeamFetchInProgress(),
        TeamFetchSuccess(team: mockTeam),
      ],
    );
  });
}
