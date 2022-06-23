import 'package:equatable/equatable.dart';
import 'package:flutter_winning_eleven/models/season.dart';

class Competition extends Equatable {
  const Competition({
    this.id,
    this.name,
    this.emblemUrl,
    this.seasons,
  });

  final int? id;
  final String? name;
  final String? emblemUrl;
  final List<Season>? seasons;

  factory Competition.fromJson(Map<String, dynamic> json) {
    List<Season> seasons = <Season>[];

    if (json.containsKey('seasons')) {
      final seasonJsonArray = json['seasons'] as List?;

      if (seasonJsonArray != null && seasonJsonArray.isNotEmpty) {
        // ignore: unnecessary_lambdas
        seasons = seasonJsonArray.map((e) => Season.fromJson(e)).toList();
      }
    }

    return Competition(
      id: json['id'],
      name: json['name'],
      emblemUrl: json['emblem'],
      seasons: seasons,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        emblemUrl,
        seasons,
      ];
}
