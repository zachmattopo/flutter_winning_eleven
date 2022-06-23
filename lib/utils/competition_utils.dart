import 'package:flutter_winning_eleven/models/competition.dart';
import 'package:flutter_winning_eleven/models/season.dart';

class CompetitionUtils {
  /// Get the end date to use when retrieving list of matches.
  ///
  /// If season has ended, will return the last end date of the season.
  ///
  /// Else, will return the current date time.
  DateTime? getMatchesDateTo(Competition competition) {
    if (competition.seasons == null) return null;

    for (final Season season in competition.seasons!) {
      if (season.startDate == null) break;

      // Guard against season that has not started, skip to next season
      if (isSeasonInFuture(season.startDate!)) continue;

      if (season.endDate == null) break;

      if (isSeasonEnded(season.endDate!)) {
        // Most recent season has ended, use the end date of that season
        return season.endDate;
      } else {
        // Season is still ongoing, use the current date time
        return DateTime.now().toUtc();
      }
    }

    return null;
  }

  /// Get the start date to use when retrieving list of matches (aka 30 days ago).
  DateTime getMatchesDateFrom(DateTime dateTo) {
    return dateTo.subtract(const Duration(days: 30)).toUtc();
  }

  bool isSeasonInFuture(DateTime startDate) {
    return DateTime.now().isBefore(startDate);
  }

  bool isSeasonEnded(DateTime endDate) {
    return DateTime.now().isAfter(endDate);
  }
}
