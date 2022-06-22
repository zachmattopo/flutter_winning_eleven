import 'dart:convert';

class Team {
  Team({
    this.id,
    this.name,
    this.shortName,
    this.tla,
    this.crestUrl,
  });

  int? id;
  String? name;
  String? shortName;
  String? tla;
  String? crestUrl;

  factory Team.fromRawJson(String str) => Team.fromJson(json.decode(str));

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json['id'],
        name: json['name'],
        shortName: json['shortName'],
        tla: json['tla'],
        crestUrl: json['crest'],
      );
}
