import 'dart:convert';

class Season {
  Season({
    this.id,
    this.startDate,
    this.endDate,
    this.currentMatchday,
  });

  int? id;
  DateTime? startDate;
  DateTime? endDate;
  int? currentMatchday;

  factory Season.fromRawJson(String str) => Season.fromJson(json.decode(str));

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        id: json['id'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        currentMatchday: json['currentMatchday'],
      );
}
