import 'dart:convert';

import 'package:flutter_winning_eleven/models/season.dart';

class Competition {
  Competition({
    this.id,
    this.name,
    this.emblemUrl,
    this.seasons,
  });

  int? id;
  String? name;
  String? emblemUrl;
  List<Season>? seasons;

  factory Competition.fromRawJson(String str) =>
      Competition.fromJson(json.decode(str));

  factory Competition.fromJson(Map<String, dynamic> json) {
    List<Season> seasons = <Season>[];

    if (json.containsKey('seasons')) {
      final seasonJsonArray = json['seasons'] as List?;

      if (seasonJsonArray != null && seasonJsonArray.isNotEmpty) {
        // ignore: unnecessary_lambdas
        seasons = seasonJsonArray.map((e) => Season.fromRawJson(e)).toList();
      }
    }

    return Competition(
      id: json['id'],
      name: json['name'],
      emblemUrl: json['emblem'],
      seasons: seasons,
    );
  }
}
