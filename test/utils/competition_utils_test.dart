import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_winning_eleven/utils/competition_utils.dart';

void main() {
  test(
      'The correct number of days (30) should be subtracted from a given dateTo',
      () {
    final DateTime dateTo = DateTime.now().toUtc();

    final DateTime expectedDateFrom =
        dateTo.subtract(const Duration(days: 30)).toUtc();

    expect(
      CompetitionUtils.getMatchesDateFrom(dateTo),
      expectedDateFrom,
    );
  });
}
