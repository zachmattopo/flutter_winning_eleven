import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_winning_eleven/blocs/competition_bloc/competition_bloc.dart';
import 'package:flutter_winning_eleven/blocs/team_bloc/team_bloc.dart';
import 'package:flutter_winning_eleven/models/team.dart';
import 'package:flutter_winning_eleven/utils/app_config.dart';

class BestTeamPage extends StatelessWidget {
  const BestTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Winning Eleven ⚽'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CompetitionBloc, CompetitionState>(
            listener: (context, state) {
              if (state is CompetitionFetchFailure) {
                // TODO(hafiz): Implement proper no internet error handling
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.orange,
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      'Error in getting competition, please restart app to try again.',
                      style: TextStyle(color: Colors.white),
                    ),
                    duration: Duration(milliseconds: 7000),
                    dismissDirection: DismissDirection.none,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<TeamBloc, TeamState>(
          builder: (context, state) {
            if (state is TeamFetchSuccess) {
              return _BestTeamContentWidget(team: state.team);
            }

            if (state is TeamFetchFailure) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            }

            // State is either `TeamFetchInProgress` or `TeamInitial`
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class _BestTeamContentWidget extends StatelessWidget {
  const _BestTeamContentWidget({
    required this.team,
    Key? key,
  }) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'THE BEST TEAM IN THE ${AppConfig.competitionName.toUpperCase()} IS..',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        team.name ?? team.shortName ?? 'N/A',
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      orientation == Orientation.portrait
                          ? _ImageWidget(
                              url: team.crestUrl,
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Text(
                          '(${team.address ?? 'Address unknown'})',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                orientation == Orientation.landscape
                    ? const SizedBox(
                        width: 32,
                      )
                    : const SizedBox(),
                orientation == Orientation.landscape
                    ? _ImageWidget(
                        url: team.crestUrl,
                      )
                    : const SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    this.url,
    Key? key,
  }) : super(key: key);

  final String? url;

  @override
  Widget build(BuildContext context) {
    return url != null
        ? Image.network(
            url!,
            errorBuilder: (_, __, ___) {
              // Workaround in case of SVGs
              return SvgPicture.network(
                url!,
              );
            },
          )
        : const SizedBox();
  }
}
