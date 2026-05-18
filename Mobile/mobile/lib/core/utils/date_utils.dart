import 'package:intl/intl.dart';

abstract final class AppDateUtils {
  static final _dateFmt     = DateFormat('dd/MM/yyyy');
  static final _dateTimeFmt = DateFormat('dd/MM/yyyy HH:mm');
  static final _timeFmt     = DateFormat('HH:mm');

  static String formatDate(DateTime date) => _dateFmt.format(date);

  static String formatDateTime(DateTime date) => _dateTimeFmt.format(date);

  static String formatTime(DateTime date) => _timeFmt.format(date);

  static String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60)  return '${diff.inMinutes}min atrás';
    if (diff.inHours < 24)    return '${diff.inHours}h atrás';
    if (diff.inDays < 7)      return '${diff.inDays}d atrás';
    return formatDate(date);
  }

  static bool isOverdue(DateTime date) => date.isBefore(DateTime.now());
}