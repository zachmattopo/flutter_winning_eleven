import 'package:equatable/equatable.dart';

class Team extends Equatable {
  const Team({
    this.id,
    this.name,
    this.shortName,
    this.tla,
    this.crestUrl,
    this.address,
    this.websiteUrl,
    this.founded,
    this.clubColors,
    this.venue,
  });

  final int? id;
  final String? name;
  final String? shortName;
  final String? tla;
  final String? crestUrl;
  final String? address;
  final String? websiteUrl;
  final int? founded;
  final String? clubColors;
  final String? venue;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json['id'],
        name: json['name'],
        shortName: json['shortName'],
        tla: json['tla'],
        crestUrl: json['crest'],
        address: json['address'],
        websiteUrl: json['website'],
        founded: json['founded'],
        clubColors: json['clubColors'],
        venue: json['venue'],
      );

  @override
  List<Object?> get props => [
        id,
        name,
        shortName,
        tla,
        crestUrl,
        address,
        websiteUrl,
        founded,
        clubColors,
        venue,
      ];
}
