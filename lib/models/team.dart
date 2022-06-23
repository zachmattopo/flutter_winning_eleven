import 'dart:convert';

class Team {
  Team({
    this.id,
    this.name,
    this.shortName,
    this.tla,
    this.crest,
    this.address,
    this.website,
    this.founded,
    this.clubColors,
    this.venue,
  });

  int? id;
  String? name;
  String? shortName;
  String? tla;
  String? crest;
  String? address;
  String? website;
  int? founded;
  String? clubColors;
  String? venue;

  factory Team.fromRawJson(String str) => Team.fromJson(json.decode(str));

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json['id'],
        name: json['name'],
        shortName: json['shortName'],
        tla: json['tla'],
        crest: json['crest'],
        address: json['address'],
        website: json['website'],
        founded: json['founded'],
        clubColors: json['clubColors'],
        venue: json['venue'],
      );
}
