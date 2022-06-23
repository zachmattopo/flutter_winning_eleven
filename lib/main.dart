import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_winning_eleven/blocs/competition_bloc/competition_bloc.dart';
import 'package:flutter_winning_eleven/blocs/matches_bloc/matches_bloc.dart';
import 'package:flutter_winning_eleven/blocs/simple_bloc_delegate.dart';
import 'package:flutter_winning_eleven/blocs/team_bloc/team_bloc.dart';
import 'package:flutter_winning_eleven/services/repository.dart';
import 'package:flutter_winning_eleven/utils/app_utils.dart';
import 'package:flutter_winning_eleven/widgets/best_team_page.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const WinningElevenApp()),
    // Initialize bloc delegate
    blocObserver: SimpleBlocDelegate(),
  );
}

class WinningElevenApp extends StatelessWidget {
  const WinningElevenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeamBloc>(
          lazy: false,
          create: (context) => TeamBloc(
            repository: Repository.get(),
          ),
        ),
        BlocProvider<MatchesBloc>(
          lazy: false,
          create: (context) => MatchesBloc(
            repository: Repository.get(),
            teamBloc: BlocProvider.of<TeamBloc>(context),
          ),
        ),
        BlocProvider<CompetitionBloc>(
          lazy: false,
          create: (context) => CompetitionBloc(
            repository: Repository.get(),
            matchesBloc: BlocProvider.of<MatchesBloc>(context),
          )..add(
              const CompetitionFetched(),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Winning Eleven',
        theme: ThemeData(
          primarySwatch: AppUtils.appColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
        ),
        home: const BestTeamPage(),
      ),
    );
  }
}
