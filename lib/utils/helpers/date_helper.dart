import 'package:intl/intl.dart';

class DateInfo {
  final now = DateTime.now();

  List<String> get daysOfWeek {
    final days = List.generate(4, (i) => now.add(Duration(days: i)));
    return days.map((date) {
      if (date.isAtSameMomentAs(now)) {
        return 'Today, ${DateFormat('MMM d').format(date)}';
      } else {
        return DateFormat('EEE, MMM d').format(date);
      }
    }).toList();
  }

  List<String> get dayNames {
    final days = List.generate(4, (i) => now.add(Duration(days: i)));
    return days.map((date) {
      if (date.day == now.day && date.month == now.month && date.year == now.year) {
        return 'Today';
      } else {
        return DateFormat('EEE').format(date);
      }
    }).toList();
  }

  List<String> get months {
    final days = List.generate(4, (i) => now.add(Duration(days: i)));
    return days.map((date) => DateFormat('MMM').format(date)).toList();
  }

  List<String> get dates {
    final days = List.generate(4, (i) => now.add(Duration(days: i)));
    return days.map((date) => DateFormat('d').format(date)).toList();
  }

  List<String> get dateTime {
    final now = DateTime.now();
    final days = List.generate(4, (i) => now.add(Duration(days: i)));
    return days.map((date) => DateFormat('d, MMMM, yyyy').format(date)).toList();
  }

  List<String> get monthInCome {
    final now = DateTime.now();
    final startMonth = now.month;
    final months = List.generate(4, (i) {
      final month = (startMonth + i) % 12;
      final year = now.year + ((startMonth + i) ~/ 12); 
      return DateTime(year, month + 1, 1);
    });
    return months.map((date) => DateFormat('MMM').format(date)).toList();
  }
}
