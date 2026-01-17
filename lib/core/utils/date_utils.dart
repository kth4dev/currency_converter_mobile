import 'package:intl/intl.dart';

abstract final class AppDateUtils {

  static String formatUpdatedDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'No data available';
    }

    try {
      final date = DateTime.parse(dateString).toLocal();
      final formatter = DateFormat('MMM d, yyyy • h:mm a');
      return 'Updated: ${formatter.format(date)}';
    } catch (_) {
      return 'Updated: $dateString';
    }
  }
}
