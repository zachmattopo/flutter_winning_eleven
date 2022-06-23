import 'package:equatable/equatable.dart';

class Season extends Equatable {
  const Season({
    this.id,
    this.startDate,
    this.endDate,
    this.currentMatchday,
  });

  final int? id;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? currentMatchday;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        id: json['id'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        currentMatchday: json['currentMatchday'],
      );

  @override
  List<Object?> get props => [
        id,
        startDate,
        endDate,
        currentMatchday,
      ];
}
